%lab odling

clc
clear all

%___________________________________
%%Theory

%Optimizing: x = ga(fitnessfcn,nvars)
%https://se.mathworks.com/help/gads/ga.html

%___________________________________
%%Parameters

%basic parameters
Fin=0.01; %liters
qm=
Yem=
Ks=
ConcGlucose=
qsmax=
%gashold= %gas holdup
%db= %diameter bubble

%calculations of parameters
mu=
qs=
qp=
Yxs=mu/qs
Transferox=6*gashold/(db*(1-gashold))


%Vectors and time
tMax=15; %hours
timeSpan=[0 tMax];
dt=0.1;
time_vector=0:dt:tMax;
nIterations=length(time_vector);

startIPTG=5; %hours

%Assumptions


%___________________________________
%%Euler solution
Ms(1)=0;
Mx(1)=0.001;
V(1)=0.1;
DOT(1)=0.0;
%Oxconsumption(1)=0;

%Time total calculation
t=0;

for i=1:tMax/dt
    Mx(i+1)=Mx(i)+dt*(Mx*mu);
    Ms(i+1)=Ms(i)+dt*();
    V(i+1)=V(i)+dt*(Fin);
    Ox(i+1)=Ox(i)+dt*();
    R(i+1)=R(i)+dt*(r*DOT(i)-b*R(i));
    
    %calculating new parameters
    t=t+dt;
    D=Fin/V;
    qs=qsmax*(Ms/V)/(Ks+Ms/V);
end

figure(1)
hold on
plot(time_vector,Mx,'b')
plot(time_vector,Ms,'r')
plot(time_vector,DOT,'k')
plot(time_vector,R,'g')
title('Euler forward')
legend('S','I1','Ox','R');




