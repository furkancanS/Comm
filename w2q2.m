clc;
clear all;

% Define the parameters
T = 0.5; % Period of the sawtooth wave
t = linspace(-2, 2, 1000); % Time vector

% Define the sawtooth wave function with amplitude between -2 and 2
x = @(t) 2*(sawtooth(2*pi/T*t + pi));

% Plot the sawtooth wave signal
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Periodic Sawtooth Wave Signal');
grid on;
legend('Message Signal');
ylim([-3, 3]);

% Calculate the Exponential Fourier Series coefficients
N = 50; % Number of coefficients
C = zeros(1, N);
for k = 1:N
    integrand = @(t) x(t) .* exp(-1j*k*2*pi/T*t);
    C(k) = (1/T) * integral(integrand, -T/2, T/2);
end

% Plot the magnitudes of the first five harmonics as a function of frequency
frequencies = 1:N;
frequencies = frequencies / T; % Convert harmonic numbers to frequencies
figure;
stem(frequencies(1:5), abs(C(1:5)), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude of First 5 Exponential Fourier Series Coefficients vs. Frequency');
grid on;

% Plot the magnitudes of the first ten harmonics as a function of frequency
figure;
stem(frequencies(1:10), abs(C(1:10)), 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude of First 10 Exponential Fourier Series Coefficients vs. Frequency');
grid on;

% Calculate the first harmonic approximation
x1 = abs(C(1)) * exp(1j*1*2*pi/T*t) + abs(C(1)) * exp(-1j*1*2*pi/T*t); % DC term

% Calculate the first three harmonics approximation
x3 = abs(C(1)) * exp(1j*1*2*pi/T*t) + abs(C(1)) * exp(-1j*1*2*pi/T*t); % DC term
x3 = x3 + abs(C(3)) * exp(1j*3*2*pi/T*t) + abs(C(3)) * exp(-1j*3*2*pi/T*t); % Third harmonic

% Calculate the first five harmonics approximation
x5 = abs(C(1)) * exp(1j*1*2*pi/T*t) + abs(C(1)) * exp(-1j*1*2*pi/T*t); % DC term
x5 = x5 + abs(C(3)) * exp(1j*3*2*pi/T*t) + abs(C(3)) * exp(-1j*3*2*pi/T*t); % Third harmonic
x5 = x5 + abs(C(5)) * exp(1j*5*2*pi/T*t) + abs(C(5)) * exp(-1j*5*2*pi/T*t); % Fifth harmonic

% Plot all signals together
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
hold on;
plot(t, abs(x1), 'r--', 'LineWidth', 1.5);
plot(t, abs(x3), 'g--', 'LineWidth', 1.5);
plot(t, abs(x5), 'm--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Approximations of Sawtooth Wave Signal');
legend('Original Signal', '1st Harmonic Approximation', '1st 3 Harmonics Approximation', '1st 5 Harmonics Approximation');
grid on;
