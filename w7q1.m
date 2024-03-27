clc;
clear all;
close all;

[m, Fs] = audioread("Counting-16-44p1-mono-15secs.wav");
n = size(m, 1); % Length of the message
t = (0:n - 1) / Fs; % Total time in seconds
f = (-(n-1)/2:(n-1)/2)*(Fs/n); % Frequency Range
fre_m = fftshift(fft(m,n)); % Computes F.T.

figure;
stem(f, abs(fre_m));
xlabel('Frequency');
xlim([-5000, 5000]);

Fc = 10000; % 10 kHz carrier frequency
freqdev = 7500; % 7.5 kHz frequency deviation

%AM SSB FM modulations
s_am = ammod(m,Fc,Fs); % AM signal
s_ssb = ssbmod(m,Fc,Fs); % SSB signal (LSB signal)
s_fm = fmmod(m,Fc,Fs,freqdev); % FM signal

%spectrum of each signal
figure;
subplot(3,1,1);
fre_am = fftshift(fft(s_am,n));
stem(f, abs(fre_am));
xlabel('Frequency');
title('AM Modulated Signal Spectrum');

subplot(3,1,2);
fre_ssb = fftshift(fft(s_ssb,n));
stem(f, abs(fre_ssb));
xlabel('Frequency');
title('SSB Modulated Signal Spectrum');

subplot(3,1,3);
fre_fm = fftshift(fft(s_fm,n));
stem(f, abs(fre_fm));
xlabel('Frequency');
title('FM Modulated Signal Spectrum');

sa = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
'PlotAsTwoSidedSpectrum',false,'NumInputPorts',3,...
'ChannelNames',{'AM','SSB','FM'});
sa(s_am,s_ssb,s_fm);
release(sa);

%Q2

Noise_power = 0.001; % Noise power 1 mW.
w = sqrt(Noise_power)*randn(size(m)); % Noise Samples
r_am = s_am + w;
r_ssb = s_ssb + w;
r_fm = s_fm + w;

sa(r_am, r_ssb, r_fm);

% Demodulate the noisy signals
r_am_demod = amdemod(r_am, Fc, Fs);
r_fm_demod = fmdemod(r_fm, Fc, Fs, freqdev);

start_time = 4.5;
end_time = 4.52;
start_sample = round(start_time * Fs) + 1;
end_sample = round(end_time * Fs);

% Plot the original message, AM recovery, and FM recovery in the specified time interval
figure;
plot(t(start_sample:end_sample), m(start_sample:end_sample));
hold on;
plot(t(start_sample:end_sample), r_am_demod(start_sample:end_sample));
plot(t(start_sample:end_sample), r_fm_demod(start_sample:end_sample),'k');
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Message vs AM and FM Recovery');
legend('Original Message', 'AM Recovery', 'FM Recovery');
grid on;
