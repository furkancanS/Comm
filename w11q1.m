clc; clear all;
N = 1e6; % Number of samples
A = 8; % Mean
nvar = 9; % Variance

x = A + sqrt(nvar)*randn(1,N); % Generate samples

hist(x,20); % Plot histogram with 20 bins
xlabel('Value');
ylabel('Frequency');
title('Histogram of Normal Distribution Samples');

p_sim_gt_10_42 = sum(x > 10.42) / N;
p_sim_lt_2_18 = sum(x < 2.18) / N;
p_sim_2_18_lt_X_lt_10_42 = sum(x > 2.18 & x < 10.42) / N;

disp(' ');
disp(['Using numerical simulation:']);
disp(['P(X > 10.42) = ', num2str(p_sim_gt_10_42)]);
disp(['P(X < 2.18) = ', num2str(p_sim_lt_2_18)]);
disp(['P(2.18 < X < 10.42) = ', num2str(p_sim_2_18_lt_X_lt_10_42)]);

% Using Q-function table



p_gt_10_42 = 1 - normcdf(10.42, A, sqrt(nvar));
p_lt_2_18 = normcdf(2.18, A, sqrt(nvar));
p_2_18_lt_X_lt_10_42 = normcdf(10.42, A, sqrt(nvar)) - normcdf(2.18, A, sqrt(nvar));

disp(['Using Q-function table:']);
disp(['P(X > 10.42) = ', num2str(p_gt_10_42)]);
disp(['P(X < 2.18) = ', num2str(p_lt_2_18)]);
disp(['P(2.18 < X < 10.42) = ', num2str(p_2_18_lt_X_lt_10_42)]);
