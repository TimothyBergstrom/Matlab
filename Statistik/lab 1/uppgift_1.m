%uppgift 1

%Stänger
close all
clear all
clc

%%KOD

%%Normalfördelning
%vi sätter x = 0 som mitt
dx=0.01;
xvector=[-3:dx:3];
tick=1;
for i=-3:dx:3
    y(tick)=normpdf(i); %y är en vekotor med sannolikhet
    tick=tick+1;
end

%plottar
plot(xvector,y,'r')

%%Randomiserade tal
%standard normal distribution och standard deviation, mu = 0, sigma = 1
antal=10000;
for i=1:antal
    slump(i)=normrnd(0,1);
end

hold on
hist_density(slump);