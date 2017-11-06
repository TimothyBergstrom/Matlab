clc
clear all
close all
% Set parameters
tMax = 5; % Max time
dt = 0.05; % Time step
timeVector = 0:dt:tMax; % Time stamps
nIterations = length(timeVector); % Number of iterations in Euler forward
growthRate = 0.5; % Exponential growth factor
y0 = 3; % Initial condition
timeSpan = [0 tMax]; % Time span (used in MATLAB ODE solver)
% Set dy/dt function
exp_growth = @(t,y) growthRate.*y;


% Matlab inbuilt ODE-solver
[t,y] = ode45(exp_growth, timeSpan, y0);
% Plot the solution
figure(1);
plot(t,y,'k-o','markerfacecolor','k');
title('Exponential growth');
xlabel('time');
ylabel('Population size');
