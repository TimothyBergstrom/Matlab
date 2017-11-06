%Sir model
clear all

%S'= -?S(t)I(t)
%I' = ?S(t)I(t)-µI(t)
%R' = µI(t)

%? = a, µ = u


a = 0.2;
u = 0.05;
tmax=150;
t=[1:tmax];
dt=1;
y0 = [0.95, 0.05, 0];

S(1)=y0(1);
I(1)=y0(2);
R(1)=y0(3);

for i=1:tmax-1
    S(i+1)=S(i)+dt*(-a*S(i)*I(i));
    I(i+1)=I(i)+dt*(a*S(i)*I(i)-u*I(i));
    R(i+1)=R(i)+dt*(u*I(i));
end

figure(1)
hold on
plot(t,S,'b')
plot(t,I,'r')
plot(t,R,'g')

legend('S','I','R');

figure(2)
hold on
plot(S,I,'b')
plot(I,R,'r')
plot(S,R,'g')

legend('S,I','I,R','S,R');