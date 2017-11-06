
clc
clear all
close all


%____________________________
%Parameters
tMax = 5;
dt = 0.05;
dx = 1;
xMin = -10;
xMax = 10;
x=[-10:dx:10];
r = 1;
D = 3;
u0 = 0.1;
tid=0:dt:tMax;
%u(t,x)
%u(0,x)=0,1;
%u(t,xMin)=0;
%u(t,xMax)=0;

% initial condition = how many have a gene
% boundary = where genes does not spread, which is at tMax/tMin (i.e 10 steps!)

%syms u(t,x) dubbeldiffux t x

%du=r*u*(1-u)+D*dubbeldiffux;

%du/dt=(u(t+dt,x)-u(t,x))/dt
%dubbeldiffux=(u(t,x+dx)-2*u(t,x)+u(t,x-dx))/dx^2
%diffux=(u(t,x+dx)-u(t,x))/dx


%MAP t (totala u)
%(u(t+dt,x)-u(t,x))/dt = r*u*(1-u)+D*dubbeldiffux;
%(u(t+dt,x)-u(t,x))/dt = r*u*(1-u)+D*(u(t,x+dx)-2*u(t,x)+u(t,x-dx))/dx^2
%(u(t+dt,x)-u(t,x))/dt = u(t,x)*(1-u(t,x))+3*(u(t,x+dx)-2*u(t,x)+u(t,x-dx))/dx^2
%vid t=0, u vid alla x, u = 0.1
%(u(t+dt,x)-0.1)/dt=0.1*(1-0.1)+3*(0.1-2*0.1+0.1)/dx^2
%(u(t+dt,x)-u(t,x))/dt = u(t,x)*(1-u(t,x))+3*(u(t,x+dx)-2*u(t,x)+u(t,x-dx))/dx^2


%MAP x
%bryter ut
%(u(t+dt,x)-u(t,x))/dt - u(t,x)*(1-u(t,x)) = 3*(u(t,x+dx)-2*u(t,x)+u(t,x-dx))/dx^2
%dx^2*(u(t+dt,x)-u(t,x))/dt - u(t,x)*(1-u(t,x))/3 - 2*u(t,x) + u(t,x-dx) = u(t,x+dx)
%vid x = -10
%(u(t+dt,-10)-u(t,-10))/dt = u(t,-10)*(1-u(t,-10))+3*(u(t,-10+dx)-2*u(t,-10)+u(t,-10-dx))/dx^2
%(0+0)/dt = 0*(1-0)+3*(u(t,-9)-2*0+0)/dx^2 = 3*(u(t,-9)/dx^2)=0

%internet: du/dt = 0 + D*dubbeldiffux ----> du/dt = D*dubbeldiffux vid
%boundary

%%(u(t+dt,x)-u(t,x))/dt = u(t,x) + u(t,x)*(1-u(t,x))+3*(u(t,x+dx)-2*u(t,x)+u(t,x-dx))/dx^2

%______________________
%Med diffusion

i=1;
u=zeros(tMax/dt,length(x));
u(:,1)=0;
u(:,end)=0;
u(1,:)=0.1;

for i=1:tMax/dt
  for j=2:xMax*2-1
  u(i+1,j)=u(i,j)+dt*((u(i,j)*((1-u(i,j))+3*(u(i,j+1)-2*u(i,j)+u(i,j-1))/dx^2))); %vi glömde ta + och -1
  end
  u(:,1)=0;
  u(:,end)=0;
end

%TEST 

nTimeIterations=tMax/dt;
positionVector=x;

for iT = 1:nTimeIterations
figure(1);
plot(positionVector,u(iT,:));
drawnow;
end

surf(u)

A=input('')
%_______________
%ingen diffusion
i=1;
u=zeros(tMax/dt,length(x));
u(:,1)=0;
u(:,end)=0;
u(1,:)=0.1;

for i=1:tMax/dt
  for j=2:xMax*2-1
  u(i+1,j)=u(i,j)+dt*((u(i,j)*((1-u(i,j))+0*(u(i,j+1)-2*u(i,j)+u(i,j-1))/dx^2)));
  end
  u(:,1)=0;
  u(:,end)=0;
end

for iT = 1:nTimeIterations
figure(1);
plot(positionVector,u(iT,:));
drawnow;
end

surf(u)
