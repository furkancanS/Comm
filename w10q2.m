clc;
clear all;
close all;

Fs = 1000;
T = 1;
t = 0:1/Fs:T-1/Fs;

x = sawtooth(2*pi*2*t);

% Vary number of quantization levels
num_levels = 2:1024;
mean_errors = zeros(size(num_levels));
data_rates = zeros(size(num_levels));

for i = 1:length(num_levels)
    L = num_levels(i);
    mp = max(x); % Maximum signal amplitude
    dyn_range_of_interval = 2*mp/L;
    thresholds = linspace(-(mp-dyn_range_of_interval),(mp-dyn_range_of_interval),L-1);
    Temp_vector = [-mp thresholds mp];
    for k=1:length(Temp_vector)-1
        codebook(k) = (Temp_vector(k)+Temp_vector(k+1))/2; % Finds the midpoint of each interval (Quantized Value)
    end
    [index,quantv] = quantiz(x,thresholds,codebook);
    mean_errors(i) = mean((x-quantv).^2);
    
    % Compute data rate
    num_bits = ceil(log2(L)); % Number of bits per sample
    data_rates(i) = Fs * num_bits; % Data rate = Sampling Rate * Number of Bits per Sample
end

% Plot mean quantization error as a function of the number of quantization intervals
figure;
loglog(num_levels, mean_errors);
xlabel('Number of Quantization Intervals');
ylabel('Mean Squared Error');
title('Mean Squared Error vs. Number of Quantization Intervals');
grid on

% Plot data rate as a function of the number of quantization intervals
figure;
semilogx(num_levels, data_rates);
xlabel('Number of Quantization Intervals');
ylabel('Data Rate (bits per second)');
title('Data Rate vs. Number of Quantization Intervals');
grid on;
