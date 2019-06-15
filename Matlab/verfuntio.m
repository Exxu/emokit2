clear all 
unloadlibrary libemokit
[notfound, warnings] = loadlibrary('../lib/libemokit.so','../include/emokit/emokit.h')
libfunctionsview libemokit
sm.F3=0
sm.F3=0
% sm.FC6=0 
% sm.P7=0 
% sm.T8=0 
% sm.F7=0 
% sm.F8=0 
% sm.T7=0 
% sm.P8=0 
% sm.AF4=0 
% sm.F4=0 
% sm.AF3=0
% sm.O2=0
% sm.O1=0
% sm.FC5=0

inft=libstruct('emokit_frame',sm)
t=libpointer('emokit_framePtr',inft)
get(inft)
get(t)