%lab 5 uppgift 1.2.1

clc
clear all
%___________________________________
%%Theory

%y(t+1)=y(t)*rho*exp(-alpha*y(t));
%rho=per capita growth rate
%alpha=incident of cannibalism
%exp(-alpha*y(t)) = probabiltity that offspring survives until maturity

%solve for when it reaches a steady state, i.e f(y*) = y*
%y*=y at steady state
%f(y) = y(t+1)


%___________________________________
%%Parameters

syms rho alpha f t y

p=rho;
a=alpha;


%___________________________________
%%Code

f=y*p*exp(-a*y);
sol=solve(f==y); %look for when f does not change!
steadystates=[sol(1) sol(2)]
fprim=diff(f,y); %solve for eigen


for i=1:2
    eig=subs(fprim,y,steadystates(i));  
    eigen(i)=eig;
end

eigen