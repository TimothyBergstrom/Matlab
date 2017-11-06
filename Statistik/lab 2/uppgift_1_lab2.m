%% uppgift 1

%Stänger
close all
clear all
clc

%% laddar data
data=csvread('bupa.dat');

%Gör vektorer med rätt data
MCV=data(:,1); %Medelvolym röda blodceller (MCV). 
                 ...Ett högt värde är associerat medalkoholism medan
                 ...ett lågt värde indikerar blodbrist.
            
ALP=data(:,2); %Alkaliskt fosfatas (ALP), en hög mängd kan indikera
               ...stopp i gallgångarna.
ALAT=data(:,3); %Alanintransferas (ALAT) katalysator för alanincykeln
                ...i vilken bland annat ammoniak omsäts.
                ...Höga värden kan indikera problem med levern.

ASAT=data(:,4); %Aspartat aminotransferat (ASAT) enzym som katalyserar
                ...överföringen av en aminogrupp från aspartat 
                ...till en ketosyra. Vid skada på hjärta,
                ...lever och skelettmuskulatur kan ASAT mätas i blodet.

GT=data(:,5); %Gamma-glutamyltransferas (GT) enzym som hjälper till
              ...att transportera aminosyror och peptider i cellerna och
              ...katalyserar glutation. Finns främst i leverceller.

Drinks=data(:,6); %Antal halv-pints alkohol som konsumerats per dag

Selector=data(:,7); %Denna variabel används inte i labb 1.

namn={' MCV',' ALP',' ALAT',' ASAT',' GT',' Drinks',' Selector'};
namninv=namn';


%% Kod
for i=1:7
    totalvektor{i}=data(:,i);
end

for i=1:5
    %Regression
    savefitlm{i}=fitlm(Drinks,totalvektor{i}); %tips: kan lösa allt snabbt
    test{i}=[ones(length(totalvektor{i}),1),totalvektor{i},];
    saveregress{i}=regress(Drinks,test{i}); %obs: y och x, ej x och y
    polyfittest{i}=polyfit(Drinks,totalvektor{i},1);
    equation{i}=polyfittest{i}; %y = a + b*x, b = beta
    beta=equation(1);  
end

%p-värdet visar i princip styrkan av hypotesen som man utför och om
...hypotesen kan förkastas eller inte

%A small p-value (typically ? 0.05) indicates strong evidence against
...the null hypothesis, so you reject the null hypothesis.
...A large p-value (> 0.05) indicates weak evidence against the 
...null hypothesis, so you fail to reject the null hypothesis.
....p-values very close to the cutoff (0.05) are considered to be marginal


%p-value is an area which is an probablilty of an observed (or more
%extreme) results arise by chance.


%Visar p value
for i=1:5
    temp=savefitlm{i};
    temp=temp.Coefficients;
    temp=temp(2,4);
    temp = table2array(temp);
    pvalue(i)=temp;
end

%Bonferroni-korrektion där vi helt enkelt delar vår önskade
...signifikansnivår med antalet tester vi gjort.
 
%Räknar ut BK
a=0.05;
for i=1:5
BK(i)=a/5; %5 = antalet tester;
end


%skapar namn och tabeller
for i = 1:5
str1=namn(i); str2= ' och '; str3= namn(6);
Linearmodel(i)=strcat(str1,str2,str3);
end
pvalue=pvalue'; BK=BK'; Linearmodel=Linearmodel';
T=table(Linearmodel,pvalue,BK)




