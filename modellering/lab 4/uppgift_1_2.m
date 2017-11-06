%lab 4 uppgift 1.2

clc
clear all

%___________________________________
%%Theory

%p=rho
%b=beta
%tau

%r=r0*(1-exp(-v*t^2))
%b=(h*exp(-h*tau))/(1-exp(-h*tau))

%Diffekv enkel
%dS/dt = -h*S+p*I+b*R
%dI/dt = h*S-p*I-r*I
%dR/dt = r*I-b*R

%Diffekv som ska räknas med
%dS/dt = -h*S+p*I1+b*R
%dI1/dt = (1-u)*h*S-p*I1-u*h*I1
%dI2/dt = u*h*S+u*h*I1-r*I2
%dR/dt = r*I2-b*R

%I1=infected with drug sensitive parasites
%I2=infected with drug resistant parasites
%v=exposure
%r=timedependent immunity acqusition rate
%u and v = medicine treatment?
%r0 = initial infectivity rate
%p = cured?

%___________________________________
%%Parameters
%coming from data from Nsukka region in Nigeria

%basic parameters
v=0.0024;
tau=0.6;
u=0.8;
h=0.5;
rho=0.8; p=rho;
r0=0.2;

%calculations of parameters
syms t
r=r0*(1-exp(-v*t^2));
b=(h*exp(-h*tau))/(1-exp(-h*tau));

%Vectors and time
tMax=50;
timeSpan=[0 tMax];
dt=0.01;
time_vector=0:dt:tMax;
nIterations=length(time_vector);

%Assuming zero infected from the start
S0=1.0;
I10=0.0;
I20=0.0;
R0=0.0;

%___________________________________
%%Euler solution
S(1)=1.0;
I1(1)=0.0;
I2(1)=0.0;
R(1)=0.0;

%Time total calculation
t=0;

for i=1:tMax/dt
    S(i+1)=S(i)+dt*(-h*S(i)+p*I1(i)+b*R(i));
    I1(i+1)=I1(i)+dt*((1-u)*h*S(i)-p*I1(i)-u*h*I1(i));
    I2(i+1)=I2(i)+dt*(u*h*S(i)+u*h*I1(i)-r*I2(i));
    R(i+1)=R(i)+dt*(r*I2(i)-b*R(i));
    
    %Recalculate r, since i = a timestep dt
    t=t+dt;
    r=r0*(1-exp(-v*t^2));
end

figure(1)
hold on
plot(time_vector,S,'b')
plot(time_vector,I1,'r')
plot(time_vector,I2,'k')
plot(time_vector,R,'g')
title('Euler forward')
legend('S','I1','I2','R');




