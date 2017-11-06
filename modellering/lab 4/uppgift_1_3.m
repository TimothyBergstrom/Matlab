%lab 4 uppgift 1.3

clc
clear all

%___________________________________
%%Theory

%p=rho
%b=beta
%tau
%r=r0*(1-exp(-v*t^2))
%b=(h*exp(-h*tau))/(1-exp(-h*tau))

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

%___________________________________
%%Parameters
%coming from data from Nsukka region in Nigeria

%basic parameters
v=0.002; vsave=v;
tau=1.5; tausave=tau;
u=0.8; usave=u;
h=2; hsave=h;
rho=0.07; p=rho; psave=p;
r0=0.1; r0save=r0;

%calculations of parameters
syms t
r=r0*(1-exp(-v*t^2));
b=(h*exp(-h*tau))/(1-exp(-h*tau));
rsave=r;
bsave=b;

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


for i=1:5
figure(i)
hold on
plot(time_vector,S,'b')
plot(time_vector,I1,'r')
plot(time_vector,I2,'k')
plot(time_vector,R,'g')
end

%________________________
%change variable up and down 50% and plot them in the baseline plots

%%changing v


for v=[0.001 0.003]

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

if v==0.001
figure(1)
hold on
plot(time_vector,S,'b--')
plot(time_vector,I1,'r--')
plot(time_vector,I2,'k--')
plot(time_vector,R,'g--')
else
figure(1)
hold on
plot(time_vector,S,'b:')
plot(time_vector,I1,'r:')
plot(time_vector,I2,'k:')
plot(time_vector,R,'g:')
title('changing variable v');
legend('S(base)','I1(base)','I2(base)','R(base)','S(down50%)','I1(down50%)','I2(down50%)','R(down50%)','S(up50%)','I1(up50%)','I2(up50%)','R(up50%)');
end

end

%resetting parameters
v=vsave;
r=rsave;
b=bsave;

%%changing tau

for tau=[0.75 2.25]

%b changes
b=(h*exp(-h*tau))/(1-exp(-h*tau));    
    
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

if tau==0.75
figure(2)
hold on
plot(time_vector,S,'b--')
plot(time_vector,I1,'r--')
plot(time_vector,I2,'k--')
plot(time_vector,R,'g--')
else
figure(2)
hold on
plot(time_vector,S,'b:')
plot(time_vector,I1,'r:')
plot(time_vector,I2,'k:')
plot(time_vector,R,'g:')
title('changing variable tau');
legend('S(base)','I1(base)','I2(base)','R(base)','S(down50%)','I1(down50%)','I2(down50%)','R(down50%)','S(up50%)','I1(up50%)','I2(up50%)','R(up50%)');
end

end

%resetting parameters
tau=tausave;
r=rsave;
b=bsave;

%%changing r0

for r0=[0.05 0.15]

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

if r0==0.75
figure(3)
hold on
plot(time_vector,S,'b--')
plot(time_vector,I1,'r--')
plot(time_vector,I2,'k--')
plot(time_vector,R,'g--')
else
figure(3)
hold on
plot(time_vector,S,'b:')
plot(time_vector,I1,'r:')
plot(time_vector,I2,'k:')
plot(time_vector,R,'g:')
title('changing variable r0');
legend('S(base)','I1(base)','I2(base)','R(base)','S(down50%)','I1(down50%)','I2(down50%)','R(down50%)','S(up50%)','I1(up50%)','I2(up50%)','R(up50%)');
end

end

%resetting parameters
r0=r0save;
r=rsave;
b=bsave;

%%changing p (rho)

for p=[0.035 0.105]

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

if p==0.035
figure(4)
hold on
plot(time_vector,S,'b--')
plot(time_vector,I1,'r--')
plot(time_vector,I2,'k--')
plot(time_vector,R,'g--')
else
figure(4)
hold on
plot(time_vector,S,'b:')
plot(time_vector,I1,'r:')
plot(time_vector,I2,'k:')
plot(time_vector,R,'g:')
title('changing variable p');
legend('S(base)','I1(base)','I2(base)','R(base)','S(down50%)','I1(down50%)','I2(down50%)','R(down50%)','S(up50%)','I1(up50%)','I2(up50%)','R(up50%)');
end

end

%resetting parameters
p=psave;
r=rsave;
b=bsave;

%changing h

for h=[1 3]

%b changes
b=(h*exp(-h*tau))/(1-exp(-h*tau));

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

if h==1
figure(5)
hold on
plot(time_vector,S,'b--')
plot(time_vector,I1,'r--')
plot(time_vector,I2,'k--')
plot(time_vector,R,'g--')
else
figure(5)
hold on
plot(time_vector,S,'b:')
plot(time_vector,I1,'r:')
plot(time_vector,I2,'k:')
plot(time_vector,R,'g:')
title('changing variable h');
legend('S(base)','I1(base)','I2(base)','R(base)','S(down50%)','I1(down50%)','I2(down50%)','R(down50%)','S(up50%)','I1(up50%)','I2(up50%)','R(up50%)');
end

end

%resetting parameters
h=hsave;
r=rsave;
b=bsave;


%end
