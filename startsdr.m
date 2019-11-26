function radio = startsdr()
 sdr = findsdru;
 radio = comm.SDRuReceiver(...
     'Platform', sdr.Platform, ...
       'SerialNum', sdr.SerialNum, ...
       'MasterClockRate', 1.92*4e6);
% radio.CenterFrequency  = 2409.5e6;
% radio.Gain = 40;
% radio.DecimationFactor = 4;
% radio.SamplesPerFrame = 10e4;
% radio.OutputDataType = 'double';
% radio.EnableBurstMode = 0;
% radio = comm.SDRuReceiver(...
%       'Platform', 'B200', ...
%       'SerialNum','3103D11' , ...
%       'MasterClockRate', 1.92*4e6);
radio.CenterFrequency  = 1850e6;
radio.Gain = 50;
radio.DecimationFactor = 4;
radio.SamplesPerFrame = 1.92e4;
radio.OutputDataType = 'double';
radio.EnableBurstMode = 1;
radio.NumFramesInBurst= 4; %% 100 mili seconds with 16e6 sample rate