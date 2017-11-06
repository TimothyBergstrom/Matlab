%uppgift 1_4

clc
clear all
close all

%____________________________
%Parameters

dt=0.1;
x=0;
y=0;
halflifeblood=1;
halflifeGI=2.5;
tMax=100; %timmar
t=[1:tMax];
tidsteg=[dt:dt:tMax];
timeIterations=tMax/dt; %antal tidssteg
intag=8;
intagspuls=intag/dt;
dissolve=1/2;
tidspuls=dissolve/dt;

%från boken s.315
a=2*log(2)/halflifeGI;
b=log(2)/halflifeblood;

%___________________________
%Kod

%uträkning av D
D(1:timeIterations)=0;

for i=1:intagspuls:timeIterations+1
    D(i:i+tidspuls-1)=2;
end

figure(1)
plot(tidsteg,D,'-')
title('D')

%Euler
for i = 1:timeIterations-1 %i är t i detta fall
    x(i+1)=x(i)+dt*(-a*x(i)+D(i));
    y(i+1)=y(i)+dt*(a*x(i)-b*y(i));
end

%plot
figure(2)
plot(tidsteg,x,'r')
hold on
plot(tidsteg,y,'b')
title('x(t) och y(t)')
legend('x(t)','y(t)')

%phase
figure(3)
plot(x,y)
title('x plottat mot y (x i x-axel och y i y-axel)')

%limit cycle: när är x(t) = 0 och y(t)=0?
%halflifeblood=1;
%halflifeGI=2.5;

%när är x = y?? Då "fastnar" de i en limit cycle i detta fall
%kolla på figur 1. När är x = y?
%i detta fall, mindre än 8