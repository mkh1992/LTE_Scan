%rtl_log
function radio=rtlRadio()
userInput.CenterFrequency = 939.9e6;
userInput.RadioAddress = '0';
frontEndSampleRate = 1.92e6;
radio = comm.SDRRTLReceiver(userInput.RadioAddress,...
    'CenterFrequency',userInput.CenterFrequency,...
    'EnableTunerAGC',true,...
    'SampleRate',frontEndSampleRate,...
    'OutputDataType','double',...
    'FrequencyCorrection',0);
radio.SamplesPerFrame =1.92e4 ;
radio.EnableBurstMode = 1;
radio.NumFramesInBurst = 4;