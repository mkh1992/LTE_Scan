% PSS analyze
function [detectFlag,timeOffset,freqOffset,PSSn] = pssdetect_FDD(signal,Nfft)
Threshold_val = 0.8;
detectFlag = 0;
PSSn = 0;
timeOffset = 0;
freqOffset = 0;
%% Coarse Time Estimate
correlationOut = zeros(4*Nfft,1);
for delay= 1:4*Nfft
    correlationOut(delay) = MLfunc(signal,Nfft,delay);
end
[~,CoarseTime] = max(correlationOut);
%% PSS correlation
finetimeRange = -64*Nfft/2048:64*Nfft/2048;
Guard = 144*Nfft/2048;
u = [25,29,34];
PSS = zeros(3,62);
for i = 1:3
    PSS(i,:)=PSSeqCreate(u(i));
end
PSScorrelation = zeros(length(finetimeRange),7,3);
Threshold  = 0;
while Threshold < Threshold_val && CoarseTime < length(signal) - 2.05 * Nfft * (160+6*144+7*2048)/2048
    CoarseTime = CoarseTime + Nfft*(160+6*144+7*2048)/2048;
    for finetime = finetimeRange
        Offset = CoarseTime + finetime;
        for frameNum = 0:6
            ofdmSymbol = signal(Offset+Guard+(Guard+Nfft)*frameNum:Offset+(Guard+Nfft)*(frameNum+1)-1);
            Carriers = fft(ofdmSymbol,Nfft);
            Carriers = Carriers([Nfft/2+2:Nfft,1:Nfft/2+1]);
            for k = 1:3
                PSScorrelation(finetime+finetimeRange(end)+1,frameNum+1,k)=...
                    abs(conj(PSS(k,:))*Carriers(Nfft/2+[-31:1:-1,1:31]))/...
                    sqrt(62*abs(Carriers(Nfft/2+[-31:1:-1,1:31])'*Carriers(Nfft/2+[-31:1:-1,1:31])));
            end
        end
    end
    [Threshold,maxInd] = max(PSScorrelation(:));
end
if Threshold > Threshold_val
    detectFlag = 1;
    [TO,FrNum,PSSn] = ind2sub(size(PSScorrelation),maxInd);
    timeOffset = CoarseTime + finetimeRange(TO)+(Guard+Nfft)*(FrNum-1);
end


