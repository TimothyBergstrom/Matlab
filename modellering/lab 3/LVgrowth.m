%test
%x' = (1-x/Kx)-axy
%y' = mxy-dy

clear all
close all

m = 0.3;
r = 0.3;
b = 0.3;
a = 0.3;
y0 = [2, 0.5];
Kx = [4, 100000];
tMax = 30000; %change with dt!
t=1:tMax;
x(1)=y0(2);
y(1)=y0(1);
x=x';
dt=0.01;

%________________________
%Euler

K=Kx(1);
for i=1:tMax-1
    x(i+1)=x(i)+dt*(r*x(i)*(1-(x(i)/K))-a*x(i)*y(i));
    y(i+1)=y(i)+dt*(m*x(i)*y(i)-b*y(i));
end

figure(1)
plot(t,x);
title('K = 4');
hold on
plot(t,y);

K=Kx(2);
for i=1:tMax-1
    x(i+1)=x(i)+dt*(r*x(i)*(1-(x(i)/K))-a*x(i)*y(i));
    y(i+1)=y(i)+dt*(m*x(i)*y(i)-b*y(i));
end

figure(2)
plot(t,x);
title('K = 100000');
hold on
plot(t,y);


%________________________
%phaseplot
K=Kx(1);
A=[r*(1-1/K) a; m b]; 
figure(3)
hold on
plot(x,y)
Mix=[x' y'];

dx(1)= 0.485-0.5;
for i=2:tMax-1
    dx(i+1)=x(i+1)-x(i);
end

dy(1)= 1.97-2;
for i=2:tMax-1
    dy(i+1)=y(i+1)-y(i);
end

[X,Y] = meshgrid(0:0.1:2.25,0:0.1:2.5);
dx = r.*X.*(1-X./K) - a.*X.*Y;
dy = m.*X.*Y-b.*Y;


quiver(X,Y,dx,dy);

%________________________
%ODE