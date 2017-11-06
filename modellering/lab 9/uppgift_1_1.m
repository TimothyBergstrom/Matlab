%Uppgift_1_1

%%Clearing
clear all
close all
clc

%%Parameters
a=0.2;
b=[0.01:0.005:6];
g=0.4;
timesteps=300; %collect last 100 values
dt=1;
p0=[0.1 0.99]; %Test for both initial conditions

%%Code
syms p b

%f=p(n+1);
f=(a*p^2 + b*p*(1-p))/(a*p^2 + 2*b*p*(1-p) + g*(1-p)^2);
steady=solve(f==p); %Finding steady states
fprim=diff(f,p);

for i=1:length(steady)
eig=subs(fprim,p,steady(i));   %kolla p� help subs
eigen(i)=eig;    
end

eigen
steady

yvector=[0:1];
avector=a*ones(size(yvector));
gvector=g*ones(size(yvector));


for p=p0
    figure
    for b=0.01:0.005:0.6; 
        for i=1:timesteps-1
         p(i+1)=(a*p(i)^2 + b*p(i)*(1-p(i)))/(a*p(i)^2 + 2*b*p(i)*(1-p(i)) + g*(1-p(i))^2);
        end
    rho_vector = b.*ones(1,100); 
    steady_states=[p(201:300)];
    hold on
    plot(rho_vector, steady_states,'.',avector,yvector,gvector,yvector);
    ylabel('Value of fixed points');
    xlabel('beta');
    end
 title(['p=' num2str(p(1))])
end

simplify(eigen)