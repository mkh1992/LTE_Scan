function cellID = SSSdetect(signal,PSSstartLoc,freqOffset,PSSn)
Nfft = 128;
Guard = [160,144,144,144,144,144,144]*Nfft/2048;
SSSstartLoc = PSSstartLoc - (Nfft+Guard(2));
ofdmSymbol = signal(SSSstartLoc+Guard(2):SSSstartLoc+Guard(2)+Nfft-1);
Carriers = fft(ofdmSymbol);
Carriers = Carriers([Nfft/2+2+freqOffset:Nfft,1:Nfft/2+1+freqOffset]);
SSSinsignal =Carriers(Nfft/2+[-31:1:-1,1:31]);
sub0_corr = zeros(168,1);
sub5_corr = zeros(168,1);
for NID1 = 0:167
    [d_sub0,d_sub5] = sssGenerate(NID1,PSSn-1);
    sub0_corr(NID1+1) = abs(d_sub0*SSSinsignal);
    sub5_corr(NID1+1) = abs(d_sub5*SSSinsignal);
end
%% Cell Id retrieving
[maxVal_sub0,maxInd_sub0]=max(sub0_corr);
[maxVal_sub5,maxInd_sub5]=max(sub5_corr);
if maxVal_sub0>maxVal_sub5
    cellID = 3*(maxInd_sub0-1)+PSSn-1;
else
    cellID = 3*(maxInd_sub5-1)+PSSn-1;
end