%lab 5 uppgift 1.1.2

clc
clear all
%___________________________________
%%Theory

% Analyse stability of the steady states as a function p
% make a bifurcation diagram 
% (a) Iterate the equation numerically for 300 time steps.
% (b) Collect the last 100 values (call them your steady states) and plot as a function of ?, see below.
% rho_vector = rho.*ones(1,100);
% plot(rho_vector, steady_states);

% For which ? does the first bifurcation occur?
% Does this agree with your findings in Problem 1.1.1?


%___________________________________
%%Parameters
y0=0.1;
p=0.01:0.01:4;

syms p y t ysteady x f(y)

f=p*y-p*y^2;

%___________________________________
%%Code
hold on
dydt = f - y;
sol=solve(dydt);
y=0.1;
dt=0.01;

for p=0.01:dt:4; 
    for i=1:299 
    y(i+1)=p*y(i)*(1-y(i)); %kör graf för ett p, förkortning av f
    end 
rho_vector = p.*ones(1,100); 
steady_states=[y(201:300)];
hold on
plot(rho_vector, steady_states,'.');
y=0.1;
end 

%Shows that the first bifurcation point is at 1, when the graph changes
disp('bifurcation point at p=1')


