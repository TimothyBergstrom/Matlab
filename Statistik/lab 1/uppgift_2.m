%uppgift 2

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


%%KOD

%Skapar histogram
subplot(4,2,1)
for i=1:7
    totalvektor{i}=data(:,i);
    subplot(4,2,i)
    hist_density(totalvektor{i});
    title(namn(i));
end

%Figur 1 till 4 vekar vara normalfördelade, figur 5 till 6 är ej det.

%Beräknar standard deviation och medelvärde för 1 till 4
for i=1:4
    Standard_deviation(i)=std(totalvektor{i});
    Mean_value(i)=mean(totalvektor{i});
    namncell{i}=namn(i);
end
Mean_value=Mean_value'; Standard_deviation=Standard_deviation'; Namn = namninv(1:4);
T = table(Namn,Standard_deviation,Mean_value);
disp(T);


%Beräknar Median och IQR (Interquartile range) 5 till 6
tick=1;
for i=5:6
    Median(tick)=median(totalvektor{i});
    IQR(tick)=iqr(totalvektor{i});
    tick=tick+1;
end
Median=Median'; IQR=IQR'; Namn = namninv(5:6);
T = table(Namn,Median,IQR);
disp(T);




    
