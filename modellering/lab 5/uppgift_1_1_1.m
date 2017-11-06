%lab 5 uppgift 1.1

clc
clear all
%___________________________________
%%Theory

%p=?=rho
%yt+1 = py(t)(1 - y(t))
%dy/dt=y(t+1)-y(t)
%f(y)=dy/dt

%solve y*=f(y*), where y* is y is at steady state
%Steady state: when dy/dt = 0
%Compute ? = df/dy (eigen)
%first bufircation?

%___________________________________
%%Parameters
syms p y(t) t ysteady x f(y)

clear y
syms y
f=p*y-p*y^2;
fsave=p*y-p*y^2;

%___________________________________
%%Code

%find dy/dt = 0 i.e when f = 0 (stationary point)

%f(y) = y(t+1) = -p*y^2 + p*y
%dy/dt = f(y) - y = 0 --> steady state

dydt = f - y;
sol=solve(dydt)
steady=[0; (p-1)/p];
fprim=diff(f,y);

%find is f(ysteady)=ysteady is true
y=steady(1); ysteady1=y;
fsteady1=p*y-p*y^2;
y=steady(2); ysteady2=y;
fsteady2=p*y-p*y^2;

%for ysteady2 this not true

%eigenvalues: df/dy (ysteady)
change=diff(f);
syms y
for i=1:2
eig=subs(change,y,steady(i));   %kolla p� help subs
eigen(i)=eig;    
end

eigen

%when eigen = 0 --> stable
%when |eigen| > 1, it is not stable.
%it all depends on p
%by putting in the stationary points in the eigenvaulues, we can see when
%the stability changes ---> that's our bufircation point
%bufircation diagram: p on the x axis, y on the y axis

%fprim on steadystate 1: Bifurcation points p=1 och -1. 
%fprim on steadystate 2: Bifurcations points p=1 och p=3. 
%bifurcation point at p=1
disp('bifurcation point at p=1')

