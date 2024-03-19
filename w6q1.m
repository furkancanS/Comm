clc;
clear all;
close all;

% Define parameters
fs = 10000; % Sampling rate (10 kHz)
t = 0:1/fs:1; % Time vector for 1 second duration

% Message signal (sawtooth)
A = 1; % Peak amplitude (1 V)
fm = 10; % Frequency (10 Hz)
m = A * sawtooth(2*pi*fm*t); % Generate sawtooth signal

% FM parameters
kf = 200*pi; % FM constant
fc = 300; % Carrier frequency (300 Hz)

% Numerical integration for FM modulation
m_intg = cumsum(m)/fs; % Integrate message signal

% FM signal generation
s = A * cos(2*pi*fc*t + kf*m_intg);  % FM signal with correct amplitude scaling


% Plot time domain representation
figure(1);
plot(t, s);
hold on;
plot(t, m);
hold off;
xlabel('Time (s)');
ylabel('FM Signal Amplitude (V)');
title('FM Signal in Time Domain');
grid on;

ylim([-1.5, 1.5]);
xlim([0, 0.2]);


% Compute the Fourier transform of the FM signal
N = length(s); % Number of samples
frequencies = linspace(-fs/2, fs/2, N); % Frequency axis
S = fftshift(fft(s))/N; % Fourier transform

% Plot the frequency domain representation
figure(2);
plot(frequencies, abs(S));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FM Signal in Frequency Domain');
grid on;
xlim([-800, 800]);

% Calculate FM transmission bandwidth
% Determine the bandwidth of the message signal (B)
% For a sawtooth wave, the nth harmonic has a frequency of n times the fundamental frequency
B = 3 * fm; % Bandwidth of the message signal (3rd harmonic)

% Determine the maximum frequency deviation (delta_f) caused by the message signal
% This can be estimated as the maximum frequency in the message signal, which occurs at the peak of the wave
delta_f = kf; % Maximum frequency deviation

% Calculate the FM transmission bandwidth using the formula W = 2(delta_f + B)
W = 2 * (delta_f + B); % FM transmission bandwidth
disp(['FM Transmission Bandwidth 1: ', num2str(W), ' Hz']);


% FM demodulation
ts = 1/fs; % Sampling period
s_der = diff([s(1) s])/ts/kf; % Numerical differentiator
mrec = abs(hilbert(s_der)); % Envelope detector
% Plot the differentiated signal and envelope detector output
figure(3);
t_diff = linspace(0, 1, length(s_der));
plot(t_diff, s_der);
hold on;
plot(t, mrec);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Differentiated Signal and Envelope Detector Output');
legend('Differentiated Signal', 'Envelope Detector Output');
grid on;
xlim([0, 0.2]);




