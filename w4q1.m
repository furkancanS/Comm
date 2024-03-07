clc;
clear all;
close all;
% Define the parameters
T = 1/10; % Period of the sawtooth wave (fundamental frequency 10 Hz)
t = linspace(0, 1, 1000); % Time vector

% Define the sawtooth wave function with amplitude 1 V
x = @(t) sawtooth(2*pi/T*t);

% Plot the sawtooth wave signal
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sawtooth Wave Signal');
grid on;
legend('Message Signal');

% Calculate the Fourier Transform of the signal
Fs = 1000; % Sampling frequency (1 kHz)
X = fft(x(t));
frequencies = linspace(-Fs/2, Fs/2, length(X));

% Plot the signal in the frequency domain
figure;
stem(frequencies, abs(fftshift(X))/length(X), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain Representation of Sawtooth Wave Signal');
grid on;
xlim([-100,100]);

% Define the carrier frequency and modulation index
fc = 100; % Carrier frequency in Hz
fm = 10; % Modulating frequency in Hz
m = 1; % Modulation index

% Time vector
t = linspace(0, 1, 1000);

% Carrier signal
carrier = cos(2*pi*fc*t);

% Modulating signal (sawtooth wave with 10 Hz fundamental frequency)
modulating = sawtooth(2*pi*fm*t);

% AM signal
AM_signal = (1 + m*modulating) .* carrier;

% Plot the AM signal in the time domain
figure;
subplot(2, 1, 1);
plot(t, AM_signal, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('AM Signal in Time Domain');
grid on;

% Calculate the Fourier Transform of the AM signal
Fs = 1000; % Sampling frequency (1 kHz)
AM_signal_fft = fft(AM_signal);
frequencies = linspace(-Fs/2, Fs/2, length(AM_signal_fft));

% Plot the AM signal in the frequency domain
subplot(2, 1, 2);
stem(frequencies, abs(fftshift(AM_signal_fft))/length(AM_signal_fft), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('AM Signal in Frequency Domain');
grid on;
xlim([-350,350]);

% Shift the carrier frequency to 150 Hz
fc = 150; % New carrier frequency in Hz
carrier = cos(2*pi*fc*t);
AM_signal = (1 + m*modulating) .* carrier;

% Plot the shifted AM signal in the time domain
figure;
subplot(2, 1, 1);
plot(t, AM_signal, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Shifted AM Signal in Time Domain');
grid on;

% Calculate the Fourier Transform of the shifted AM signal
AM_signal_fft = fft(AM_signal);

% Plot the shifted AM signal in the frequency domain
subplot(2, 1, 2);
stem(frequencies, abs(fftshift(AM_signal_fft))/length(AM_signal_fft), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Shifted AM Signal in Frequency Domain');
grid on;
xlim([-350,350]);

% Define the carrier frequency and modulation index
fc = 100; % Carrier frequency in Hz
fm = 10; % Modulating frequency in Hz
m = 1; % Modulation index

% Time vector
t = linspace(0, 1, 1000);

% Carrier signal
carrier = cos(2*pi*fc*t);

% Modulating signal (sawtooth wave with 10 Hz fundamental frequency)
modulating = sawtooth(2*pi*fm*t);

% AM signal
AM_signal = (1 + m*modulating) .* carrier;

% Envelope recovery
envelope = abs(hilbert(AM_signal));

% Plot the AM signal and envelope recovery output
figure;
plot(t, AM_signal, 'b', 'LineWidth', 1.5);
hold on;
plot(t, envelope, 'r', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
legend('AM signal','Envelope Recovery Output')
grid on;
xlim([0,0.25]);

% Original modulating signal (sawtooth wave with 10 Hz fundamental frequency)
original_modulating = sawtooth(2*pi*fm*t);

% Recovered message signal (envelope recovery output)
recovered_message = envelope - 1;

% Plot the original and recovered message signals
figure;
plot(t, modulating, 'b', 'LineWidth', 1.5);
hold on;
stem(t, recovered_message, 'r', 'LineWidth', 0.1, 'Marker', 'o', 'LineStyle', 'none');
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Original and Recovered Message Signals');
legend('Original Message Signal', 'Recovered Message Signal');
grid on;
xlim([0,0.25]);
ylim([-2,2]);
