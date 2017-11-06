%uppgift 3

%St�nger
close all
clear all
clc

%laddar data
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

namn={'MCV','ALP','ALAT','ASAT','GT','Drinks','Selector'};
namninv=namn';


%%Kod
for i=1:7
    totalvektor{i}=data(:,i);
end

%%Korellation: G�r om till koordinater och plotta med scatter

%r=strenght of linear association.
...abs(r) = 1 => perfekt linj�r korrelation
...abs(r)~0 => d�lig linj�r korrelation
%r=Covarians(x,y)/standarddeviation(x)*standarddeviation(y)

%Detta ska g�ras f�r alla variabler i alla kombinationer fr�n 1 till 6
kombinationer=combnk(1:6,2);

%R�knar covarianser
tick=1;
for i=1:length(kombinationer)
Kovarianstemp{i}=cov(totalvektor{kombinationer(i,1)},...
                 totalvektor{kombinationer(i,2)});

             %Hittat p� internet
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
%strcat fixar s� att titlar inte staplas
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

%abs(r)<0.5 �r ett bra tr�skelv�rde

[row] = find(r>0.5);
brakombinationer=[kombinationer(row,1), kombinationer(row,2)];

disp('Bra korrelation mellan ')
for i = 1:length(brakombinationer)
disp(strcat(namn(kombinationer(i,1)), ' och ' ,namn(kombinationer(i,2))))
end

