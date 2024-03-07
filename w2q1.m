clc;
clear all;
close all;

% Define the parameters
T = 0.5; % Period of the square wave
t = linspace(-2, 2, 1000); % Time vector

% Define the square wave function with amplitude between 0 and 1
x = @(t) 0.5*(square(2*pi/T*t)+1);


% Plot the square wave signal
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Periodic Square Wave Signal');
grid on;
legend('Message Signal');
ylim([-0.5, 2]);

% Calculate the Exponential Fourier Series coefficients
N = 50; % Number of coefficients
C = zeros(1, N);
for k = 1:N
    integrand = @(t) x(t) .* exp(-1j*k*2*pi/T*t);
    C(k) = (1/T) * integral(integrand, -T/2, T/2);
end

% Plot the magnitudes of the coefficients
figure;
stem(1:N, abs(C), 'LineWidth', 1.5);
xlabel('Harmonic Number (k)');
ylabel('Magnitude');
title('Magnitude of Exponential Fourier Series Coefficients');
grid on;

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

% Reconstruct the signal using the first harmonic
x1 = zeros(size(t));
x1 = x1 + abs(C(1)) * exp(1j*1*2*pi/T*t) + abs(C(1)) * exp(-1j*1*2*pi/T*t); % DC term

% Reconstruct the signal using the first three harmonics
x3 = zeros(size(t));
x3 = x3 + abs(C(1)) * exp(1j*1*2*pi/T*t) + abs(C(1)) * exp(-1j*1*2*pi/T*t); % DC term
x3 = x3 + abs(C(3)) * exp(1j*3*2*pi/T*t) + abs(C(3)) * exp(-1j*3*2*pi/T*t); % Third harmonic

% Reconstruct the signal using the first ten harmonics
x10 = zeros(size(t));
x10 = x10 + abs(C(1)) * exp(1j*1*2*pi/T*t) + abs(C(1)) * exp(-1j*1*2*pi/T*t); % DC term
x10 = x10 + abs(C(3)) * exp(1j*3*2*pi/T*t) + abs(C(3)) * exp(-1j*3*2*pi/T*t); % Third harmonic
x10 = x10 + abs(C(5)) * exp(1j*5*2*pi/T*t) + abs(C(5)) * exp(-1j*5*2*pi/T*t); % Fifth harmonic
x10 = x10 + abs(C(7)) * exp(1j*7*2*pi/T*t) + abs(C(7)) * exp(-1j*7*2*pi/T*t); % Seventh harmonic
x10 = x10 + abs(C(9)) * exp(1j*9*2*pi/T*t) + abs(C(9)) * exp(-1j*9*2*pi/T*t); % Ninth harmonic

% Plot the signals
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
hold on;
plot(t, abs(x1), 'r--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Approximations of Square Wave Signal');
legend('Original Signal', '1st Harmonic Approximation');
grid on;
ylim([-0.5, 2]);

% Plot the signals
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
hold on;
plot(t, abs(x3), 'g--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Approximations of Square Wave Signal');
legend('Original Signal', '1st 3 Harmonics Approximation');
grid on;
ylim([-0.5, 2]);

% Plot the signals
figure;
plot(t, x(t), 'b', 'LineWidth', 1.5);
hold on;
plot(t, abs(x10), 'm--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Approximations of Square Wave Signal');
legend('Original Signal', '1st 10 Harmonics Approximation');
grid on;
ylim([-0.5, 2]);

