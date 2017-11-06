%uppgift 2

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


%%KOD

%Skapar histogram
subplot(4,2,1)
for i=1:7
    totalvektor{i}=data(:,i);
    subplot(4,2,i)
    hist_density(totalvektor{i});
    title(namn(i));
end

%Figur 1 till 4 vekar vara normalf�rdelade, figur 5 till 6 �r ej det.

%Ber�knar standard deviation och medelv�rde f�r 1 till 4
for i=1:4
    Standard_deviation(i)=std(totalvektor{i});
    Mean_value(i)=mean(totalvektor{i});
    namncell{i}=namn(i);
end
Mean_value=Mean_value'; Standard_deviation=Standard_deviation'; Namn = namninv(1:4);
T = table(Namn,Standard_deviation,Mean_value);
disp(T);


%Ber�knar Median och IQR (Interquartile range) 5 till 6
tick=1;
for i=5:6
    Median(tick)=median(totalvektor{i});
    IQR(tick)=iqr(totalvektor{i});
    tick=tick+1;
end
Median=Median'; IQR=IQR'; Namn = namninv(5:6);
T = table(Namn,Median,IQR);
disp(T);




    
