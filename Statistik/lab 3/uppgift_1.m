%% uppgift 1

%Stänger
close all
clear all
clc

%laddar data
load('dnadat.mat');

%parametrar
a=0.05; %signifikansnivå
p=0.25;

%H0: p(Nukleotid) = 0.25
%H1: p(Nukleotid) ~= 0.25

%% Kod

%Gör om dna sekvens till siffror
dnadata = nt2int(dna);

%Konverterar till vektor
dnadata = double(dnadata); %1 = a, 2 = c, 3 = g, t = 4

%check om chi2 kan fungera
check=length(dnadata)*p;


%test storhet

sequencelength=length(dnadata);

for i=1:4
    hittanukleotid=find(i==dnadata);
    antal=length(hittanukleotid);
    Q(i) = ((antal-sequencelength*p)^2)/(sequencelength*p);
end

Teststorhet=sum(Q)

%Förkasta H0 om Teststorhet > Chi2(r-1) där r = 4
%Från tabell: Chi2(3) med a = 0.05 = 12.8
Chi23 = 12.8

if Teststorhet > Chi23
    disp('H0 förkastas')
else
    disp('H0 kan ej förkastas')
end

pvalue = chi2cdf(Teststorhet,3,'upper')

%The returned value h = 1 indicates that chi2gof rejects the null 
...hypothesis at the default 5% significance level.
    
