%% uppgift 3

%Stänger
close all
clear all
clc

%kod från rapport    
clouds=dlmread('clouds.txt','\t',1,0);
rain=[clouds(:,4) ; clouds(:,5) ; clouds(:,6) ; clouds(:,7) ; clouds(:,8)];
seeded=[clouds(:,2) ; clouds(:,2) ; clouds(:,2) ; clouds(:,2) ; clouds(:,2)];
season=[clouds(:,3) ; clouds(:,3) ; clouds(:,3) ; clouds(:,3) ; clouds(:,3)];
area=[zeros(108,1) ; zeros(108,1)+1 ; zeros(108,1)+2 ; zeros(108,1)+3 ...
; zeros(108,1)+4];


%% Kod
%with no interactions
Group{1}=area; Group{2}=season; Group{3}=seeded;
P1=anovan(rain,Group, 'model', 'interaction')
P1=anovan(rain,Group, 'model','linear')