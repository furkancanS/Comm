clc;
clear all;

%% P(x<= x) = 1 - Q((x-m)/a)
%% P(x > x) = Q((x-m)/a)

mu = 8;
sigma = 3;
x = 10.42;

z1 = (x - mu) / sigma;

mu2 = 8;
sigma2 = 3;
x2 = 2.18;

z2 = (x2 - mu2) / sigma2;

p1= 0.209;
p2= 0.0268;

p11=1-p1;
p22=1-p2;


