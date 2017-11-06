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
tau=1;

i=1;
y(1)=3;


for i=1:length(timeVector)
y(i+1)=y(i)+dt*growthRate*y(i-tau);
end
    
y = y(1:end-1);
figure(1);
plot(timeVector,y,'k-o','markerfacecolor','k');
title('Exponential growth');
xlabel('time');
ylabel('Population size');