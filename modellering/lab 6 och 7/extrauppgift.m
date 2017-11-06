
clc
clear all
close all


%____________________________
%Parameters

R = 1.2;
y0 = 1;
M = 0.5;
dt=0.1;
tMax=3;
timeIterations=tMax/dt;
tidssteg=[1:timeIterations+1];
Svektor=[0:0.01:0.05];
y(1)=y0;


%___________________________
%Code
tick=1;
for S=Svektor
    for i=1:timeIterations
    y(i+1)=(R*(y(i)^2))/(((R-1)*(y(i)^2)/M)+y(i)+S);
    end
    hold on
    tick=tick+1;
    plot(tidssteg,y)
end