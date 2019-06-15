% Time sample 0.0078ms ou 128Hz
clc
loadlibrary('../lib/libemokit.so','../include/emokit/emokit.h')
frame=libpointer('emokit_framePtr');
frame.value.F3=0;
emotive=calllib('libemokit','emokit_create');
EMOKIT_VID=hex2dec('1234'); 
EMOKIT_PID=hex2dec('ed02');
number_device=calllib('libemokit','emokit_get_count',emotive,EMOKIT_VID, EMOKIT_PID);
fprintf("Current epoc devices connected: %d\n",number_device);
connect_ok=calllib('libemokit','emokit_open',emotive,EMOKIT_VID, EMOKIT_PID,1);
if(connect_ok~=0)
    fprintf('CANNOT CONNECT');
    return;
end
t=linspace(0,20,2559)
runtime = 20;
fprintf('Run time: %d \n', runtime);
F3=[];
FC6=[];
P7=[]; 
T8=[]; 
F7=[]; 
F8=[]; 
T7=[]; 
P8=[]; 
AF4=[]; 
F4=[]; 
AF3=[];
O2=[];
O1=[];
FC5=[];
tic;
while (toc < runtime)
    r=calllib('libemokit','emokit_read_data_timeout',emotive,10);
    if( r> 0)
        a=calllib('libemokit','emokit_get_next_frame',emotive,frame);
        if(a~=0)
            fprintf('READ PROBLEM');
            return; 
        end
    
    resp.F3=frame.value.F3*0.5127/1000; 
    resp.FC6=frame.value.FC6*0.5127/1000;
    resp.P7=frame.value.P7*0.5127/1000; 
    resp.T8=frame.value.T8*0.5127/1000; 
    resp.F7=frame.value.F7*0.5127/1000; 
    resp.F8=frame.value.F8*0.5127/1000; 
    resp.T7=frame.value.T7*0.5127/1000; 
    resp.P8=frame.value.P8*0.5127/1000; 
    resp.AF4=frame.value.AF4*0.5127/1000; 
    resp.F4=frame.value.F4*0.5127/1000; 
    resp.AF3=frame.value.AF3*0.5127/1000;
    resp.O2=frame.value.O2*0.5127/1000;
    resp.O1=frame.value.O1*0.5127/1000;
    resp.FC5=frame.value.FC5*0.5127/1000;
    F3=[F3 resp.F3];
    FC6=[FC6 resp.FC6];
    P7=[P7 resp.P7]; 
    T8=[T8 resp.T8]; 
    F7=[F7 resp.F7]; 
    F8=[F8 resp.F8]; 
    T7=[T7 resp.T7]; 
    P8=[P8 resp.P8]; 
    AF4=[AF4 resp.AF4]; 
    F4=[F4 resp.F4]; 
    AF3=[AF3 resp.AF3];
    O2=[O2 resp.O2];
    O1=[O1 resp.O1];
    FC5=[FC5 resp.FC5];
    fprintf('F3: %.4f , FC6: %.4f , P7: %.4f , T8: %.4f , F7: %.4f , F8: %.4f , T7: %.4f , P8: %.4f , AF4: %.4f , F4: %.4f,AF3: %.4f , O2: %.4f , O1: %.4f , FC5: %.4f \n', resp.F3, resp.FC6, resp.P7, resp.T8, resp.F7, resp.F8, resp.T7, resp.P8, resp.AF4, resp.F4, resp.AF3,resp.O2,resp.O1,resp.FC5);
     
    end
end

subplot(14,1,1)
plot(t,F3 )
title('EEG')
ylabel('F3')
subplot(14,1,2)
plot(t,FC6 )
ylabel('FC6')
subplot(14,1,3)
plot(t,P7)
ylabel('P7')
subplot(14,1,4)
plot(t,T8 )
ylabel('T8')
subplot(14,1,5)
plot(t,F7)
ylabel('F7')
subplot(14,1,6)
plot(t,F8 )
ylabel('F8')
subplot(14,1,7)
plot(t,T7 )
ylabel('T7')
subplot(14,1,8)
plot(t,P8 )
ylabel('P8')
subplot(14,1,9)
plot(t,AF4)
ylabel('AF4')
subplot(14,1,10)
plot(t,F4 )
ylabel('F4')
subplot(14,1,11)
plot(t,AF3 )
ylabel('AF3')
subplot(14,1,12)
plot(t,O2 )
ylabel('O2')
subplot(14,1,13)
plot(t,O1)
ylabel('O1')
subplot(14,1,14)
plot(t,FC5 )
ylabel('FC5')
xlabel('t')
calllib('libemokit','emokit_close',emotive);
calllib('libemokit','emokit_delete',emotive);


