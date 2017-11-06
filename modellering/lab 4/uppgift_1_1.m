%lab 4 uppgift 1.1

clc
clear all

%___________________________________

%%Theory

%p=rho
%b=beta
%tau

%dS/dt = -h*S+p*I+b*R
%dI/dt = h*S-p*I-r*I
%dR/dt = r*I-b*R
%b=(h*exp(-h*tau))/(1-exp(-h*tau))

%___________________________________
%%Parameters

tMax=20;
timeSpan=[0 tMax];

S0=1.0;
I0=0.0;
R0=0.0;

dt=0.01;
time_vector=0:dt:tMax;
nIterations=length(time_vector);
tau=0.6;
h=0.5;
rho=0.8; p=rho;
r=0.2;

%___________________________________
%%Euler solution

b=(h*exp(-h*tau))/(1-exp(-h*tau));

S(1)=1.0;
I(1)=0.0;
R(1)=0.0;

for i=1:tMax/dt
    S(i+1)=S(i)+dt*(-h*S(i)+p*I(i)+b*R(i));
    I(i+1)=I(i)+dt*(h*S(i)-p*I(i)-r*I(i));
    R(i+1)=R(i)+dt*(r*I(i)-b*R(i));
end

figure(1)
hold on
plot(time_vector,S,'b')
plot(time_vector,I,'r')
plot(time_vector,R,'g')
title('Euler forward')
legend('S','I','R');

Ssave=S;
Isave=I;
Rsave=R;

%___________________________________
%%ode45 solution
y0=[1.0; 0.0; 0.0];
syms S I R

[t,y]=ode45(@(t,y)funk1(t,y,h,r,b,p),timeSpan,y0);
S=y(:,1);
I=y(:,2);
R=y(:,3);

figure(2)
hold on
plot(t,S,'b')
plot(t,I,'r')
plot(t,R,'g')
title('ode45')
legend('S','I','R');

figure(3)
hold on
plot(time_vector,Ssave,'k')
plot(time_vector,Isave,'m')
plot(time_vector,Rsave,'c')
plot(t,S,'b')
plot(t,I,'r')
plot(t,R,'g')
title('mixed')
legend('S(Euler)','I(Euler)','R(euler)','S(ode45)','I(ode45)','R(ode45)');


