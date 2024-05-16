clc;
clear all;
close all;
% Set parameters
N = 1e6;  % Number of bits
Eb = 12;   % Energy per bit (in arbitrary units)
No = 2;    % Noise power spectral density (W/Hz)

% Convert No to noise variance
sigma_sq = No/2;  % Variance of noise

% Generate random bits
bits = randi([0 1], N, 1);

% Range of Eb/N0 values in dB
EbN0_dB = -10:1:10; % dB

% Convert Eb/N0 from dB to linear scale
EbN0_lin = 10.^(EbN0_dB/10);

% Calculate theoretical BER for binary on-off transmission
BER_on_off_theo = 0.5 * exp(-EbN0_lin); % Assuming on-off keying

% Calculate theoretical BER for binary polar transmission
A2 = sqrt(2*Eb); % Decision threshold
sigma_0 = sqrt(No); % Standard deviation of noise
BER_polar_theo = 0.5 * erfc(A2 / (sqrt(2) * sigma_0));

% Initialize arrays for simulated BER
BER_on_off_sim = zeros(size(EbN0_dB));
BER_polar_sim = zeros(size(EbN0_dB));

% Simulate BER for each Eb/N0 value
for i = 1:length(EbN0_dB)
    % Simulate BER for binary on-off transmission
    noise_on_off = sqrt(sigma_sq/2)*randn(N, 1);  % Zero-mean Gaussian noise
    received_symbols_on_off = sqrt(2*Eb)*bits + noise_on_off;
    decisions_on_off = received_symbols_on_off > sqrt(Eb);
    errors_on_off = sum(bits ~= decisions_on_off);
    BER_on_off_sim(i) = errors_on_off / N;

    % Simulate BER for binary polar transmission
    symbols_polar = sqrt(Eb/2) * (2*bits - 1); % +1 for 1, -1 for 0
    noise_polar = sqrt(No/2) * randn(N,1);
    received_symbols_polar = symbols_polar + noise_polar;
    decoded_data_polar = (received_symbols_polar > 0);
    errors_polar = sum(bits ~= decoded_data_polar);
    BER_polar_sim(i) = errors_polar / N;
end

% Plot the theoretical and simulated BER
figure;
semilogy(EbN0_dB, BER_on_off_theo, 'b', 'LineWidth', 2);
hold on;
semilogy(EbN0_dB, BER_polar_theo, 'r', 'LineWidth', 2);
semilogy(EbN0_dB, BER_on_off_sim, 'bo', 'MarkerSize', 5);
semilogy(EbN0_dB, BER_polar_sim, 'ro', 'MarkerSize', 5);
hold off;

% Add labels and legend
xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate (BER)');
title('Theoretical and Simulated BER vs. E_b/N_0');
legend('Binary On-Off (Theory)', 'Binary Polar (Theory)', 'Binary On-Off (Simulated)', 'Binary Polar (Simulated)');
grid on;
