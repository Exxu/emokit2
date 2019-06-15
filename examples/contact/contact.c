/* 

Get real-time contact quality readings

  */

#include <stdio.h>
#include <string.h>
#include <signal.h>
#include "emokit/emokit.h"

int quit;
void cleanup(int i){
	fprintf(stdout,"Shutting down\n");
	quit=1; 
}

int main(int argc, char **argv)
{
	struct emokit_device* d;
	signal(SIGINT, cleanup); //trap cntrl c
	

	quit=0;

	d = emokit_create();
	int count=emokit_get_count(d, EMOKIT_VID, EMOKIT_PID);
	printf("Current epoc devices connected: %d\n", count );
	int r = emokit_open(d, EMOKIT_VID, EMOKIT_PID, 1);
	if(r != 0)
	{
		emokit_close(d);
		emokit_delete(d);
		d = emokit_create();
		r = emokit_open(d, EMOKIT_VID, EMOKIT_PID, 0);
		if (r!=0) {
			printf("CANNOT CONNECT: %d\n", r);
			return 1;
		}
	}
	printf("Connected to headset.\n");
	
	r = emokit_read_data_timeout(d,1000);
	if (r<=0) {
		if(r<0)
			fprintf(stderr, "Error reading from headset\n");
		else
			fprintf(stderr, "Headset Timeout...\n");
		emokit_close(d);
		emokit_delete(d);
		return 1;
	}

	struct emokit_contact_quality c;
	while (!quit) {
		int err = emokit_read_data_timeout(d, 1000);
		if(err > 0) {
			int r = emokit_get_qnext_frame(d,&c);
			fprintf(stdout,"\033[H\033[2JPress CTRL+C to exit\n\nContact quality:\nF3  %4d\nFC6 %4d\nP7  %4d\nT8  %4d\nF7  %4d\nF8  %4d\nT7  %4d\nP8  %4d\nAF4 %4d\nF4  %4d\nAF3 %4d\nO2  %4d\nO1  %4d\nFC5 %4d",c.F3, c.FC6, c.P7, c.T8,c.F7, c.F8, c.T7, c.P8, c.AF4, c.F4, c.AF3, c.O2, c.O1, c.FC5);
			fflush(stdout);
		} else if(err == 0) {
			fprintf(stderr, "Headset Timeout...\n");
		}
	}
	emokit_close(d);
	emokit_delete(d);
	return 0;
}

