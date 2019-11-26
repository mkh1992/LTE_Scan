% ML function have to be Maximized for finding timeDelay and Frequency
% Offset
function [MLval] = MLfunc(signal,Nfft,theta)
CPlength=144*Nfft/2048; % scalling CP length
gamma = signal(theta:(theta+CPlength))'*signal((theta+Nfft):(theta+Nfft+CPlength));
%phi   = 0.5*sum(abs(signal(theta:(theta+CPlength))).^2+abs(signal((theta+Nfft):(theta+Nfft+CPlength))).^2);
%roh   = (abs(gamma)/Nfft)/sqrt(mean(abs(signal(theta:(theta+CPlength))).^2)*...
%    mean(abs(signal((theta+Nfft):(theta+Nfft+CPlength))).^2));
%gamma = cos(2*pi*epsilon+phase(gamma))*abs(gamma);
MLval = abs(gamma);% - roh*phi;
%MLval = abs(gamma);