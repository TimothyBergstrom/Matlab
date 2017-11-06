
%SIR model Delayed
 
%%Timothys kod
 
 
clear all
 
 
%______________________________
%Euler
 
%S'= -aS(t)I(t)+ R(t-tau)
%I' = aS(t)I(t)-uI(t)
%R' = uI(t)- R(t-tau )
 
%? = a, µ = u, ? = tau
a = 0.2;
u = 0.05;
dt=0.1;
tmax=50/dt; %change with dt!
t=[1:tmax]; 
tau=2;
tauekv=2/dt;
y0 = [0.95, 0.05, 0];
history = [0.99; 0.01; 0.0];
save=tau/dt;
S(1)=history(1);
I(1)=history(2);
R(1)=history(3);
Ssave=history(1);
Isave=history(2);
Rsave=history(3);
 
%After history, R uses before
for i=1:tmax-1
    if (i-tauekv)<1
    S(i+1)=S(i)+dt*(-a*S(i)*I(i)+Rsave);
    I(i+1)=I(i)+dt*(a*S(i)*I(i)-u*I(i));
    R(i+1)=R(i)+dt*(u*I(i)-Rsave);
    else
%After history, R uses same
    S(i+1)=S(i)+dt*(-a*S(i)*I(i)+R(i-tauekv+1));
    I(i+1)=I(i)+dt*(a*S(i)*I(i)-u*I(i));
    R(i+1)=R(i)+dt*(u*I(i)-R(i-tauekv+1));
    end
end
 
test=zeros(length(t),1);
 
figure(1)
hold on
plot(t,S,'b')
plot(t,I,'r')
plot(t,R,'g')
plot(t,test)
title('Euler forward')
legend('S','I','R');
 
hopp=[1:5:length(S)];
hopp(length(hopp)+1)=500;
Ssave=S(hopp);
Isave=I(hopp);
Rsave=R(hopp);
 
%_________________________
%dde23
timespan = [1:tmax*dt];
 
historyfunk=@(t) [0.99; 0.01; 0];
 
sol=dde23(@(t,q,Z)delayfunk(t,q,Z,a,u), tau,historyfunk, timespan);
 
x=sol(1).x;
y=sol(1).y;
S=y(1,:);
I=y(2,:);
R=y(3,:);
 
figure(2)
hold on
plot(x,S,'b')
plot(x,I,'r')
plot(x,R,'g')
title('dde23')
legend('S','I','R');
 
figure(3)
hold on
plot(x,Ssave,'k')
plot(x,Isave,'m')
plot(x,Rsave,'c')
plot(x,S,'b')
plot(x,I,'r')
plot(x,R,'g')
title('mixed')
legend('S(Euler)','I(Euler)','R(euler)','S(dde23)','I(dde23','R(dde23)');