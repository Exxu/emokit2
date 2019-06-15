clc
loadlibrary('../lib/libemokit.so','../include/emokit/emokit.h')
quality=libpointer('emokit_contact_qualityPtr');
quality.value.F3=0;
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

runtime = 20;
fprintf('Run time: %d \n', runtime);
tic;
while (toc < runtime)
    r=calllib('libemokit','emokit_read_data_timeout',emotive,8);
    if( r> 0)
        a=calllib('libemokit','emokit_get_qnext_frame',emotive,quality);
        if(a~=0)
            fprintf('READ PROBLEM');
            return; 
        end
    
        fprintf('F3: %d , FC6: %d , P7: %d , T8: %d , F7: %d , F8: %d , T7: %d , P8: %d , AF4: %d , F4: %d,AF3: %d , O2: %d , O1: %d , FC5: %d \n', quality.value.F3, quality.value.FC6, quality.value.P7, quality.value.T8, quality.value.F7, quality.value.F8, quality.value.T7, quality.value.P8, quality.value.AF4, quality.value.F4, quality.value.AF3,quality.value.O2,quality.value.O1,quality.value.FC5);
    end
end
calllib('libemokit','emokit_close',emotive);
calllib('libemokit','emokit_delete',emotive);
