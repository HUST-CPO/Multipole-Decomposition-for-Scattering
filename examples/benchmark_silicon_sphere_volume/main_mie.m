% compute the multipole coefficients of silicon sphere using Mie theory

close all
clear
clc

%% parameters
nm = 1e-9;
radius = 210 * nm;
n0 = 1;
n1 = 3.5;
lambda_min = 900 * nm;
lambda_max = 1900 * nm;
lambda_step = 1 * nm;
lambda = lambda_min:lambda_step:lambda_max;
order = 3;

%% computation of multipole coefficients
[an, bn] = mie_scatter(radius, n0, n1, lambda, order);
[sigma_a, sigma_b, sigma_total] = mie_cross_section(an, bn, lambda, order, radius);
save(['sca_data_mie.mat']);
