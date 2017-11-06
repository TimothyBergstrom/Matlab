clc
clear all
close all
% Set parameters
tMax = 5; % Max time
dt = 0.01; % Time step
timeVector = 0:dt:tMax; % Time stamps
nIterations = length(timeVector); % Number of iterations in Euler forward
growthRate = 0.5; % Exponential growth factor
y0 = 3; % Initial condition
timeSpan = [0 tMax]; % Time span (used in MATLAB ODE solver)
% Set dy/dt function
exp_growth = @(t,y) growthRate.*y;

i=1
y(1)=3;

for i=1:200
y(i+1)=y(i)+dt*growthRate*y(i);

if y(i)>2*y(1)
    figure(1);
    ost=1:length(y);
    ost=ost*dt;
    plot(ost,y,'k-o','markerfacecolor','k');
    title('Exponential growth');
    xlabel('time');
    ylabel('Population size');
    break
end
    
    
end


Y=log(y); T=log(ost);
    plot(ost,Y,'k-o','markerfacecolor','k');
    title('Exponential growth');
    xlabel('time');
    ylabel('Population size');


y = y(1:end-1);
