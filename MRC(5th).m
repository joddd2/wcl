clc;
clear all;
close all;
%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%
N=5; % Number of trials
m = 10^6; %Number of bits in each trial
ip = rand(1,m)>0.5; % Generated bits
BPSK = 2*ip-1; % Generated BPSK symbols
snr_dB = 0:1:15; % range of snr values
snr = 10.^(snr_dB/10); % snr value in the normal scale
L=2; % Number of diversity branches
% theoretical BER value for MRC combiner with 2 diversity branches
p_R_MRC = 1/2 - 1/2*(1+1./snr).^(-1/2);
ber_MRC_ana = p_R_MRC.^2.*(1+2*(1-p_R_MRC));
%%%%%%%%%% Receive MRC one by Two System %%%%%%%%%%%%%%%%%%%
n_err=zeros(1,length(snr_dB)); % Initialize the bit error counter
for p = 1:N
for q = 1:length(snr_dB)
% Generate white noise samples
No = 1/sqrt(2)*[randn(L,m) + 1j*randn(L,m)];
% Generate channel coefficient
h = 1/sqrt(2)*[randn(L,m) + 1j*randn(L,m)];
symbol = kron(ones(L,1),BPSK); % array of symbols
rec_vector = h.*symbol + 10^(-snr_dB(q)/20)*No;% received symbol
% Decision metric
dec_metric = sum(conj(h).*rec_vector,1)./sum(h.*conj(h),1);
ip_hat = real(dec_metric)>0; % Estimated symbol
n_err(q) = n_err(q)+size(find([ip- ip_hat]),2); % compare input and estimated symbols
end
end
ber_MRC_sim = n_err/(N*m);
semilogy(snr_dB,ber_MRC_ana,'-r*','LineWidth',2)
hold on;
semilogy(snr_dB,ber_MRC_sim,'ob','LineWidth',2)
legend('ber MRC sim', 'ber MRC ana');
xlabel('SNR (dB)');
ylabel('BER');