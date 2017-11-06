%extrauppgift2
clear all
clc

load population_america.mat

t = t - t(1);

%y' = r*y*(1-y/K);

%A*x=B, x=A\B
x=data\t;


plot(t,data,'kx');
hold on
title('Infected');
xlabel('time');
ylabel('Population infected');

c=polyfit(t,data,5);
A=polyval(c,t);
plot(t,A);

K=230;
y0=data(1);
timespan=[0 t(21)];
funk = @(t,y) x*y*(1-y/K);
[t,y] = ode45(funk, timespan, y0);

plot(t,y);