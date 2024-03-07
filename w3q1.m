clc;
clear all;
Fs = 500;
ts = 1/Fs;
T = 1;
t = ts:ts:T;

f1 = 50;
x1 = 2*cos(2*pi*f1*t);

f2 = 150;
x2 = cos(2*pi*f2*t);

x = x1 + x2;

n = length(x);
f = (-Fs/2 : Fs/n : Fs/2 - Fs/n);
fre_x = fftshift(fft(x, n));

figure;

subplot(3,1,1)
stem(f, abs(fftshift(fft(x1, n)))/n, 'LineWidth', 1.5);
title('First Sinusoidal: 2cos(100πt)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(3,1,2)
stem(f, abs(fftshift(fft(x2, n)))/n, 'LineWidth', 1.5);
title('Second Sinusoidal: cos(500πt)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(3,1,3)
stem(f, abs(fre_x)/n, 'LineWidth', 1.5);
title('Sum of Two Sinusoidals: 2cos(100πt) + cos(500πt)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on
%% 

% Q2 design a lowpass filter 
% %and show the magnitude response

% Passband frequency in Hz
f_pass = 75;

% Stopband frequency in Hz
f_stop = 90;

% Design a low-pass FIR filter
lpFilt = designfilt('lowpassfir', 'PassbandFrequency', f_pass, 'StopbandFrequency', f_stop, 'SampleRate', Fs);

% Define the frequency vector for the plot
freq_vector = linspace(0, Fs/2, numel(lpFilt.Coefficients));

% Plot the magnitude response of the filter
fvtool(lpFilt, 'FrequencyVector', freq_vector, 'Fs', Fs);

% Apply the filter to the signal x
rec_x1 = filter(lpFilt, x);

%Q3
%% 

% Plot the original signal and filtered signal in frequency domain
figure(3)
stem(f, abs(fftshift(fft(x1, n)))/n, 'LineWidth', 1.5);
hold on;
stem(f, abs(fre_x)/n, 'LineWidth', 1.5);
hold off;
title('Original x1 Spectrum and Recovered x1 Spectrum After LPF');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Original x1 Spectrum', 'Recovered x1 Spectrum After LPF');
grid on;
xlim([-100, 100]);

% Plot the original signal and filtered signal in time domain
figure(4)
plot(t, x1);
hold on;
plot(t, rec_x1);
hold off;
title('Original 1st Sinusoidal and Filtered Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 1st Sinusoidal', 'Filtered Signal');
grid on;
xlim([0, 0.4]);
