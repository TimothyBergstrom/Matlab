  %Uppgift_1_1a blue feathers survive

%%Clearing
clear all
close all
clc

%%Parameters
a=[1 0 0];
b=[0 1 0];
g=[0 0 1];
timesteps=3; %collect last 100 values
dt=1;
p0=[0.1 0.99]; %Test for both initial conditions
tidsvektor=[1:timesteps];
%%Code

for value=1:3
p(1)=0.1;
    for i=1:timesteps-1
    p(i+1)=(a(value)*p(i)^2 + b(value)*p(i)*(1-p(i)))/(a(value)*p(i)^2 + 2*b(value)*p(i)*(1-p(i)) + g(value)*(1-p(i))^2);
    end
figure()
plot(tidsvektor, p);
end

figure(1)
title('only blue survive');

figure(2)
title('only green survive');

figure(3)
title('only yellow survive');