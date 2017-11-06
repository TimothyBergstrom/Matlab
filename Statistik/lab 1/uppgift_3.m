%uppgift 3

%Stänger
close all
clear all
clc

%laddar data
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

namn={'MCV','ALP','ALAT','ASAT','GT','Drinks','Selector'};
namninv=namn';


%%Kod
for i=1:7
    totalvektor{i}=data(:,i);
end

%%Korellation: Gör om till koordinater och plotta med scatter

%r=strenght of linear association.
...abs(r) = 1 => perfekt linjär korrelation
...abs(r)~0 => dålig linjär korrelation
%r=Covarians(x,y)/standarddeviation(x)*standarddeviation(y)

%Detta ska göras för alla variabler i alla kombinationer från 1 till 6
kombinationer=combnk(1:6,2);

%Räknar covarianser
tick=1;
for i=1:length(kombinationer)
Kovarianstemp{i}=cov(totalvektor{kombinationer(i,1)},...
                 totalvektor{kombinationer(i,2)});

             %Hittat på internet
%If you only have two one-dimensional vectors,
...the number you're looking for is the (1,2)
...element of the output of cov

temp=Kovarianstemp{i};


Kovarians(i)=temp(1,2);
Std1(i)=std(totalvektor{kombinationer(i,1)});
Std2(i)=std(totalvektor{kombinationer(i,2)});

r(i)=Kovarians(i)/(Std1(i)*Std2(i));

subplot(3,5,i)
scatter(totalvektor{kombinationer(i,1)},totalvektor{kombinationer(i,2)});
%strcat fixar så att titlar inte staplas
title(strcat(namn(kombinationer(i,1)), ' och ', namn(kombinationer(i,2))))
xlabel(namn(kombinationer(i,1)))
ylabel(namn(kombinationer(i,2)))
text(min(totalvektor{kombinationer(i,1)}),...
    max(totalvektor{kombinationer(i,2)}),...
    ['r = ' num2str(r(i))])
end



%-1.0 to -0.5 or 1.0 to 0.5	Strong
%-0.5 to -0.3 or 0.3 to 0.5	Moderate
%-0.3 to -0.1 or 0.1 to 0.3	Weak
%-0.1 to 0.1                None or very weak

%abs(r)<0.5 är ett bra tröskelvärde

[row] = find(r>0.5);
brakombinationer=[kombinationer(row,1), kombinationer(row,2)];

disp('Bra korrelation mellan ')
for i = 1:length(brakombinationer)
disp(strcat(namn(kombinationer(i,1)), ' och ' ,namn(kombinationer(i,2))))
end

