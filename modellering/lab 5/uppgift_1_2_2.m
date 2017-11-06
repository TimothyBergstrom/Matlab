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
fprim=diff(f); %solve for eigen

dt=0.1;
alpha=0.01;
a=alpha;
y=900;

for p=0.1:dt:30; 
    for i=1:299 
    y(i+1)=y(i)*p*exp(-a*y(i)); %kör graf för ett p
    end 
rho_vector = p.*ones(1,100); 
steady_states=[y(201:300)];
hold on
plot(rho_vector, steady_states,'.');
y=900;
end 

%bifurcation point at e^2
disp('bifurcation point at p=e^2 and p=1')