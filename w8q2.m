clc;
clear all;
close all;

% Define the signal and parameters
Fs=2000;
t = 0:1/Fs:1;

fm = 10; % fundamental frequency of the sawtooth signal
xsig = sawtooth(2*pi*fm*t);

% Sample the signal at 250 Hz
Lsig = length(xsig);
fs = 250; 
ts = 1/fs;
td = 1/Fs;
Nfactor = ts/td; % Downsampling factor
s_out = downsample(xsig, Nfactor); 
xsig_sampled = upsample(s_out, Nfactor); 

% Adjust the length of t_sampled
t_sampled = 0:1/Fs:length(xsig_sampled)/Fs-1/Fs;

% Plot the original and sampled signal
figure;
plot(t, xsig);
hold on;
stem(t_sampled, xsig_sampled);
hold off;
grid on;
xlim([0, 0.2]);
ylim([-1.2, 1.2]);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original and Sampled Sawtooth Signal');
legend('Original Signal', 'Sampled Signal');

% Calculate and plot the spectra
f = -Fs/2:Fs/Lsig:Fs/2-Fs/Lsig;
f_sampled = -Fs/2:Fs/length(xsig_sampled):Fs/2-Fs/length(xsig_sampled);
spectrum_xsig = fftshift(abs(fft(xsig)));
spectrum_xsig_normalized = spectrum_xsig / max(spectrum_xsig);
spectrum_xsig_sampled = fftshift(abs(fft(xsig_sampled)));
spectrum_xsig_sampled_normalized = spectrum_xsig_sampled / max(spectrum_xsig);

figure;
stem(f, spectrum_xsig_normalized);
hold on;
stem(f_sampled, spectrum_xsig_sampled_normalized);
hold off;
grid on;
xlim([-20, 20]);
ylim([0, 1.2]);
xlabel('Frequency (Hz)');
ylabel('Normalized Gain');
title('Normalized Original and Sampled Signal Spectra');
legend('Original Signal', 'Sampled Signal');

% Design a low-pass filter
f_cutoff = fs / 2; % Nyquist frequency
filter_order = 30; % Filter order
b = fir1(filter_order, f_cutoff/(Fs/2)); % FIR filter coefficients

% Apply the filter to recover the original signal
xsig_recovered = filter(b, 1, xsig_sampled);

% Adjust the length of t_sampled
t_sampled = 0:1/Fs:length(xsig_sampled)/Fs-1/Fs;

% Adjust the length of t for the recovered signal
t_recovered = 0:1/Fs:length(xsig_recovered)/Fs-1/Fs;

% Plot the original, sampled, and recovered signals
figure;
plot(t, xsig, 'b');
hold on;
plot(t_recovered, xsig_recovered, 'r');
hold off;
grid on;
xlim([0, 0.2]);
ylim([-3.5, 3.5]);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original, Sampled, and Recovered Signals');
legend('Original Signal', 'Recovered Signal');

% Calculate and plot the spectra
f = -Fs/2:Fs/Lsig:Fs/2-Fs/Lsig;
f_sampled = -Fs/2:Fs/length(xsig_sampled):Fs/2-Fs/length(xsig_sampled);
f_recovered = -Fs/2:Fs/length(xsig_recovered):Fs/2-Fs/length(xsig_recovered);
spectrum_xsig_recovered = fftshift(abs(fft(xsig_recovered)));
spectrum_xsig_recovered_normalized = spectrum_xsig_recovered / max(spectrum_xsig);

figure;
stem(f, spectrum_xsig_normalized, 'b');
hold on;
stem(f_recovered, spectrum_xsig_recovered_normalized, 'r');
hold off;
grid on;
xlim([-1000, 1000]);
ylim([0, 1.2]);
xlabel('Frequency (Hz)');
ylabel('Normalized Gain');
title('Normalized Original, Sampled, and Recovered Signal Spectra');
legend('Original Signal', 'Recovered Signal');
