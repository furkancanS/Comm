clc; clear all;
Fs = 1000;
T = 1;
t = 0:1/Fs:T-1/Fs;

yo = sawtooth(2*pi*2*t);

% Define different roll-off factors (β)
beta_values = [0.1, 0.5, 1.0];


% Perform raised cosine filtering with different roll-off factors
filtered_signals = cell(1, length(beta_values));
for i = 1:length(beta_values)
    beta = beta_values(i);
    span = 6; % Filter span
    rolloff = beta; % Roll-off factor

    % Design the raised cosine filter
    h = rcosdesign(rolloff, span, Fs);

    % Apply the filter
    y = filter(h, 1, yo);

    % Store the filtered signal
    filtered_signals{i} = y;

    % Plot the filtered signal in the time domain
    subplot(length(beta_values), 2, 2*i-1);
    plot((0:length(y)-1)/Fs, y);
    title(['Filtered Signal (β = ', num2str(beta), ')']);
    xlabel('Time (s)');
    ylabel('Amplitude');

    % Calculate and plot the power spectral density (PSD) of the filtered signal
    [Psd0, f0] = pwelch(y, [], [], [], 'twosided', Fs);
    subplot(length(beta_values), 2, 2*i);
    semilogy(f0 - Fs/2, fftshift(Psd0));
    title(['PSD of Filtered Signal (β = ', num2str(beta), ')']);
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
end
