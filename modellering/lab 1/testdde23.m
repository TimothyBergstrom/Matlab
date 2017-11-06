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
exp_growth = @(t,y,Z) growthRate.*Z;
tau=1;
r2=0.3;
historyfunc=@(t) y0*exp(r2*t);

% Matlab inbuilt ODE-solver
sol = dde23(exp_growth, tau, historyfunc, timeSpan);
t=sol(1).x;
y=sol(1).y;
% Plot the solution
figure(1);
plot(t,y,'g');
title('Exponential growth with delay');
xlabel('time');
ylabel('Population size');
hold on

%__________________________________

%Euler with delay
y=1;
t=0;

for i=1:(tau/dt)
y(i)=y0*exp(r2*t);
t=t+dt;
end

for i=(tau/dt):length(timeVector)-1
y(i+1)=y(i)+dt*growthRate*y(i-(-1+tau/dt));
end

plot(timeVector,y,'r');

%___________________________________

i=1;
y=3;

for i=1:length(timeVector)-1
y(i+1)=y(i)+dt*growthRate*y(i);
end

plot(timeVector,y,'b');
legend('dde23','Euler forward with delay', 'Euler forward without delay)');
