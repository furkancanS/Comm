clc;
clear all;
close all;
% Define the carrier frequency and modulation index
fc = 100; % Carrier frequency in Hz
fm = 10; % Modulating frequency in Hz
m = 2; % Modulation index

% Time vector
t = linspace(0, 1, 1000);

% Carrier signal
carrier = cos(2*pi*fc*t);

% Modulating signal (sawtooth wave with 10 Hz fundamental frequency)
modulating = sawtooth(2*pi*fm*t);

% DSB-SC AM signal
DSBSC_AM_signal = m*modulating .* carrier;

% Plot the DSB-SC AM signal in the time domain
figure;
subplot(2, 1, 1);
plot(t, DSBSC_AM_signal, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('DSB-SC AM Signal in Time Domain');
grid on;

% Calculate the Fourier Transform of the DSB-SC AM signal
Fs = 1000; % Sampling frequency (1 kHz)
DSBSC_AM_signal_fft = fft(DSBSC_AM_signal);
frequencies = linspace(-Fs/2, Fs/2, length(DSBSC_AM_signal_fft));

% Plot the DSB-SC AM signal in the frequency domain
subplot(2, 1, 2);
stem(frequencies, abs(fftshift(DSBSC_AM_signal_fft))/length(DSBSC_AM_signal_fft), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('DSB-SC AM Signal in Frequency Domain');
grid on;
xlim([-350,350]);

% Demodulation of DSB-SC AM signal
% Multiply the DSB-SC AM signal with the carrier
demodulated_signal = DSBSC_AM_signal .* carrier;

% Calculate the Fourier Transform of the demodulated signal
demodulated_signal_fft = fft(demodulated_signal);

% Plot the demodulated signal in the frequency domain before LPF
figure;
stem(frequencies, abs(fftshift(demodulated_signal_fft))/length(demodulated_signal_fft), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Demodulated Signal in Frequency Domain (Before LPF)');
grid on;
xlim([-250,250]);

% FIR LPF design
lpf_order = 100; % Filter order
lpf_cutoff = 0.10; % Normalized cutoff frequency (0.01 corresponds to a lower cutoff frequency)
lpf = fir1(lpf_order, lpf_cutoff);

% Filter the demodulated signal
filtered_signal = filter(lpf, 1, demodulated_signal);

% Calculate the Fourier Transform of the filtered signal
filtered_signal_fft = fft(filtered_signal);
filtered_frequencies = linspace(-Fs/2, Fs/2, length(filtered_signal_fft));

% Plot the filtered signal in the frequency domain
% figure;
% subplot(2, 1, 1);
% plot(t, filtered_signal, 'b', 'LineWidth', 1.5);
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('Filtered Signal in Time Domain');
% grid on;

% Plot the filtered signal in the frequency domain
figure();
stem(filtered_frequencies, abs(fftshift(filtered_signal_fft))/length(filtered_signal_fft), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Filtered Signal in Frequency Domain');
grid on;
xlim([-100,100]);
ylim([0,0.35]);
% Recovered message signal (envelope recovery output)
recovered_message = abs(hilbert(filtered_signal)) - 1;

% Plot the original and recovered message signals
figure;
plot(t, modulating, 'b', 'LineWidth', 1.5);
hold on;
plot(t, recovered_message, 'r', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Original and Recovered Message Signals');
legend('Original Message Signal', 'Recovered Message Signal');
grid on;
xlim([0,0.25]);
ylim([-2,2]);

