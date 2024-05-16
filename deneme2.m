clc;
clear all;
close all;

% Set parameters
N = 1e6;  % Number of bits
Eb = 12;   % Energy per bit (in arbitrary units)
No = 2;    % Noise power spectral density (W/Hz)
sigma_sq = No/2;  % Variance of noise
N0 = 2*10^-6; % Noise power spectral density (W/Hz)

% Define range of Eb/No values (in dB)
EbNo_dB = 0:0.5:10;

% Convert Eb/No from dB to linear scale
EbNo = 10.^(EbNo_dB./10);

% Theoretical BER for binary polar transmission
BER_theo_polar = 0.5 * erfc(sqrt(EbNo));

% Theoretical BER for binary on-off transmission
BER_theo_on_off = 0.5 * erfc(sqrt(EbNo/2));

% Initialize arrays for simulated BER
BER_sim_polar = zeros(size(EbNo));
BER_sim_on_off = zeros(size(EbNo));

for i = 1:length(EbNo)
    % Generate random binary data
    data = randi([0,1],1,N);
    
    % Modulation for polar transmission
    symbols_polar = 2*data - 1; % BPSK modulation
    
    % Modulation for on-off transmission
    symbols_on_off = sqrt(Eb)*data; % On-off keying modulation
    
    % Generate AWGN noise
    noise = sqrt(sigma_sq)*randn(1,N);
    
    % Received signal for polar transmission
    received_polar = symbols_polar + noise;
    
    % Received signal for on-off transmission
    received_on_off = symbols_on_off + noise;
    
    % Demodulation for polar transmission
    decoded_polar = received_polar > 0; % Thresholding
    
    % Demodulation for on-off transmission
    decoded_on_off = received_on_off > sqrt(Eb/2); % Thresholding
    
    % Calculate number of errors for polar transmission
    errors_polar = sum(decoded_polar ~= data);
    
    % Calculate number of errors for on-off transmission
    errors_on_off = sum(decoded_on_off ~= data);
    
    % Calculate simulated BER for polar transmission
    BER_sim_polar(i) = errors_polar/N;
    
    % Calculate simulated BER for on-off transmission
    BER_sim_on_off(i) = errors_on_off/N;
end

% Convert Eb/No to dB
EbNo_dB = 10*log10(EbNo);

% Plot theoretical and simulated BER for both transmissions
figure;
semilogy(EbNo_dB, BER_theo_polar, 'r-', 'LineWidth', 2);
hold on;
semilogy(EbNo_dB, BER_sim_polar, 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
semilogy(EbNo_dB, BER_theo_on_off, 'g--', 'LineWidth', 2);
semilogy(EbNo_dB, BER_sim_on_off, 'ms', 'MarkerSize', 5, 'MarkerFaceColor', 'm');
grid on;
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate');
title('Binary Polar vs Binary On-Off Transmission');
legend('Theoretical (Polar)', 'Simulated (Polar)', 'Theoretical (On-Off)', 'Simulated (On-Off)');
