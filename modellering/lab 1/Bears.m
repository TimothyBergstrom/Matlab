close all
clear all

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
% Estimate parameters using MATLAB row reduction
parameters = tData\lnData;
y0 = exp(parameters(1)); % y0 = exp(lny0);
growthFactor = parameters(2);
% Generate data using the exponential model with estimated parameters
data_fit = y0.*exp(growthFactor.*t);
% Plot resulting data
figure(3);  
hold on
plot(t,data_fit,'k-','linewidth',2);
legend('Observed data','Estimated function');

%______________________________________________

%y=y0.*exp(r.*t);
%log(y)=log(y0) + r*t
%Y=b+m*t

% sumy=sum(log(data));
% sumx=sum(t);
% t2=t.*t;
% sumx2=sum(t2);
% tdata=t.*log(data);
% sumxy=sum(tdata);
% m=(9*sumxy-sumx*sumy)/(9*sumx2-sumx^2);
% b=(sumx2*sumy-sumx*sumxy)/(9*sumx2-sumx^2);
% 
% tid=0;
% Y=0;
% for i=1:78
% Y(i)=m*tid+b;
% tid=tid+1;
% end

tid=1:78;
c=polyfit(t,log(data),1);

r=c(1);
y0=exp(c(2));
yy=y0.*exp(r.*tid);
plot(tid,yy);

legend('Observed data','Estimated function','Curve from calculating y0 and r with MKM');

derp=polyval(c,tid);
figure(2)
plot(tid,derp);


% b=exp(y0)
%______________________________________________

% data_fit = y0.*exp(growthFactor.*t);
% data_fitdiff = growthFactor*y0.*exp(growthFactor.*t);
% 
% tid=1;
% y=1;
% 
% for i=1:78-1
% y(i+1)= y(i)+dt*growthFactor*y0.*exp(growthFactor.*t);
% tid=tid+dt;
% end
% 
% tid=1:78;
% plot(tid,y)


%______________________________________________

% B=polyfit(t,data,1);
% B=polyval(B,t);
% plot(t,B);
% 
% figure(2)
% A=log(data_fit);
% plot(t,A);
% 


%______________________________________________

% Set parameters
% tMax = 78; % Max time
% dt = 1; % Time step
% timeVector = 0:dt:tMax; % Time stamps
% nIterations = length(timeVector); % Number of iterations in Euler forward
% growthRate = 0.0370; % Exponential growth factor (r)
% y0 = 130; % Initial condition
% timeSpan = [0 tMax]; % Time span (used in MATLAB ODE solver)
% % Set dy/dt function
% exp_growth = @(t,y) growthRate.*y;
% 
% 
% % Matlab inbuilt ODE-solver
% [t,y] = ode45(exp_growth, timeSpan, y0);
% % Plot the solution
% figure(3);
% plot(t,y,'r');
% title('Exponential growth');
% xlabel('time');
% ylabel('Population size');
