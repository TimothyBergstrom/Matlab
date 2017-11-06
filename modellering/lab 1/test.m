load population_data_swedish_bears.mat;
t = t - t(1); % Shift the time so that it starts from t = 0

% Plot observed data
figure(3);
plot(t,data,'kx');
title('Exponential data fit');
xlabel('time');
ylabel('Population size');
% Make data linear
lnData = log(data);
tData = [ones(size(t)),t];
% Plot linear data
figure(2)
plot(t,lnData,'kx');
title('Linear data');
xlabel('time');
ylabel('ln(population size)');

% Estimate parameters using MATLAB row reduction
parameters = tData\lnData;
y0 = exp(parameters(1)); % y0 = exp(lny0);
growthFactor = parameters(2);
% Generate data using the exponential model with estimated parameters
data_fit = y0.*exp(growthFactor.*t);
% Plot resulting data
figure(3);
hold on
C1=plot(t,data_fit,'k-','linewidth',2);

Integraloriginalfit = trapz(t,data_fit)

%___________________________


pol=polyfit(t,data,8);
polnummer=polyval(pol,t);
plot(t,polnummer);

pol=polyfit(t,data,1);
polnummer=polyval(pol,t);
plot(t,polnummer,'g');

%__________________________


% Set parameters
tMax = 78; % Max time
dt = 1; % Time step
timeVector = 0:dt:tMax; % Time stamps
nIterations = length(timeVector); % Number of iterations in Euler forward
growthRate = 0.0370; % Exponential growth factor (r)
y0 = 130; % Initial condition
timeSpan = [0 tMax]; % Time span (used in MATLAB ODE solver)
% Set dy/dt function
exp_growth = @(t,y) growthRate.*y;


% Matlab inbuilt ODE-solver
[t,y] = ode45(exp_growth, timeSpan, y0);
% Plot the solution
figure(3);
C2=plot(t,y,'r');
title('The problem of overfitting');
xlabel('time');
ylabel('Population size');

legend('Observed data','Estimated function (least square method)','Training set, all points are used','Underfitted curve with linear regression','Using only initial population, Malthus law');


Integralode45 = trapz(t,y)

Skillnad=Integralode45-Integraloriginalfit
