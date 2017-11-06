%% uppgift 2

%St�nger
close all
clear all
clc

%% lad dar data
data=csvread('bupa.dat');

%G�r vektorer med r�tt data
MCV=data(:,1); %Medelvolym r�da blodceller (MCV). 
                 ...Ett h�gt v�rde �r associerat medalkoholism medan
                 ...ett l�gt v�rde indikerar blodbrist.
            
ALP=data(:,2); %Alkaliskt fosfatas (ALP), en h�g m�ngd kan indikera
               ...stopp i gallg�ngarna.
ALAT=data(:,3); %Alanintransferas (ALAT) katalysator f�r alanincykeln
                ...i vilken bland annat ammoniak oms�ts.
                ...H�ga v�rden kan indikera problem med levern.

ASAT=data(:,4); %Aspartat aminotransferat (ASAT) enzym som katalyserar
                ...�verf�ringen av en aminogrupp fr�n aspartat 
                ...till en ketosyra. Vid skada p� hj�rta,
                ...lever och skelettmuskulatur kan ASAT m�tas i blodet.

GT=data(:,5); %Gamma-glutamyltransferas (GT) enzym som hj�lper till
              ...att transportera aminosyror och peptider i cellerna och
              ...katalyserar glutation. Finns fr�mst i leverceller.

Drinks=data(:,6); %Antal halv-pints alkohol som konsumerats per dag

Selector=data(:,7); %Denna variabel anv�nds inte i labb 1.

namn={' MCV',' ALP',' ALAT',' ASAT',' GT',' Drinks',' Selector'};
namninv=namn';


%% Kod
for i=1:7
    totalvektor{i}=data(:,i);
end

for i=1:5
    %Regression
    savefitlm{i}=fitlm(Drinks,totalvektor{i}); %tips: kan l�sa allt snabbt
    test{i}=[ones(length(totalvektor{i}),1),totalvektor{i},];
    saveregress{i}=regress(Drinks,test{i}); %obs: y och x, ej x och y
    polyfittest{i}=polyfit(Drinks,totalvektor{i},1);
    equation{i}=polyfittest{i}; %y = a + b*x, b = beta
    beta=equation(1);  
end

kord1=find(Drinks>=5);
Drinksover5=Drinks(kord1);
kord2=find(Drinks<5);
Drinksunder5=Drinks(kord2);


booting=bootstrp(100, @mean,Drinks)
figure()
ksdensity(booting);


booting1=bootstrp(100, @mean,Drinksover5)
figure()
ksdensity(booting1);
booting2=bootstrp(100, @mean,Drinksunder5)
figure()
ksdensity(booting2);

skillnad=booting1-booting2;
quantile(skillnad,[0.025 0.975])
