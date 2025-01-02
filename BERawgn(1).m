clc;
close all;
clear all;
% Number of information bits
m= 10^5;
%Range of SNR values
snr_dB = [0:1:20];
for j=1:1:length(snr_dB)
n_err = 0;
n_bits = 0;
while n_err < 100
% Generate sequence of binary bits
inf_bits=round(rand(1,m));
% BPSK modulator
x=2*(inf_bits-0.5);
% Noise variance
N0=1/10^(snr_dB(j)/10);
% Send over Gaussian Link to the receiver
y=x + sqrt(N0/2)*(randn(1,length(x))+i*randn(1,length(x)));
% Decision making at the Receiver
est_bits=y > 0;
% Calculate Bit Errors
diff=inf_bits-est_bits;
n_err=n_err+sum(abs(diff));
n_bits=n_bits+length(inf_bits);
end
% Calculate Bit Error Rate
BER(j)=n_err/n_bits;
end
% AWGN Theoretical BER
theoryBerAWGN=0.5*erfc(sqrt(10.^(snr_dB/10)));
semilogy(snr_dB,BER,'or','LineWidth',2);
hold on;
semilogy(snr_dB,theoryBerAWGN,'blad-','LineWidth',2);
legend('AWGN Simulated', 'AWGN Theoretical');
axis([0 20 10^-5 0.5]);
xlabel('SNR (dB)');
ylabel('BER');
grid on;