clc;
clear all;
close all;

Fs = 1000;
T = 1;
t = 0:1/Fs:T-1/Fs;

x = sawtooth(2*pi*2*t);

L = 4;
mp = max(x); % Maximum signal amplitude
dyn_range_of_interval = 2*mp/L;
thresholds = linspace(-(mp-dyn_range_of_interval),(mp-dyn_range_of_interval),L-1);
Temp_vector = [-mp thresholds mp];
for k=1:length(Temp_vector)-1
codebook(k) = (Temp_vector(k)+Temp_vector(k+1))/2; % Finds the midpoint of each interval (Quantized Value)
end
[index,quantv] = quantiz(x,thresholds,codebook);

% Plot the original and quantized signals
plot(t, x);
hold on;
stairs(t, quantv);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Original and Quantized Sawtooth Signals');
legend('Original', 'Quantized');
