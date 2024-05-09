clc;
clear all;

N = 1e6; 
q = 0.1;
A = 8; 
nvar = 25; 

info_bits = double(rand(1,N) > (1-q));

noise_samples = sqrt(nvar)*randn(1,N);
x = A*info_bits + noise_samples;

T_range = -2:0.5:12;
BER_sim = zeros(size(T_range));
BER_theo = zeros(size(T_range));

for i = 1:length(T_range)
    T = T_range(i);
    rec_bits = double(x > T);
    BER_sim(i) = sum(xor(info_bits, rec_bits)) / N;
    BER_theo(i) = qfunc(T/sqrt(nvar))*(1-q) + qfunc((A-T)/sqrt(nvar))*q;
end

% Find the optimal threshold that minimizes BER
[~, idx_optimal] = min(BER_sim);
T_optimal = T_range(idx_optimal);

% Plot BER vs. threshold T
figure;
semilogy(T_range, BER_sim, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 5); 
hold on;
semilogy(T_range, BER_theo, 'b*--', 'LineWidth', 1.5, 'MarkerSize', 5); 
xlabel('Threshold T');
ylabel('Bit Error Rate (BER)');
legend('Simulated BER', 'Theoretical BER');
grid on;
title('BER vs. Threshold T');
ylim([10^-2, 10^0]); 

%optimal threshold
line([T_optimal, T_optimal], [10^-2, 10^0], 'Color', 'b', 'LineStyle', '--', 'LineWidth', 1);

%minimum BER
min_BER = min(BER_sim);
line([min(T_range), max(T_range)], [min_BER, min_BER], 'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);
