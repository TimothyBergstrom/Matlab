%uppgift 4

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

namn={' MCV',' ALP',' ALAT',' ASAT',' GT',' Drinks',' Selector'};
namninv=namn';


%%Kod
for i=1:7
    totalvektor{i}=data(:,i);
end

for i=1:5
    
    %%Regression
    savefitlm{i}=fitlm(Drinks,totalvektor{i}); %tips: kan l�sa allt snabbt
    test{i}=[ones(length(totalvektor{i}),1),totalvektor{i},];
    saveregress{i}=regress(Drinks,test{i}); %obs: y och x, ej x och y
    polyfittest{i}=polyfit(Drinks,totalvektor{i},1);
    equation{i}=polyfittest{i}; %y = a + b*x, b = beta
    beta=equation(1);
    
    %%F�rklaringsgrad
                 %Hittat p� internet
    %If you only have two one-dimensional vectors,
    ...the number you're looking for is the (1,2)
    ...element of the output of cov
    Kovarianstemp = cov(Drinks,totalvektor{i});
    Kovarians(i) = Kovarianstemp(1,2);
    Std1(i)=std(Drinks);
    Std2(i)=std(totalvektor{i});
    r(i)=Kovarians(i)/(Std1(i)*Std2(i));
    R2(i)=r(i)^2; %R2 = f�rklaringsgrad = r^2
    
   
    %%Residualer
    y=totalvektor{i};
    for ii=1:length(Drinks)
        e(ii)=y(ii)-polyval(equation{i},Drinks(i));
    end
    
    %%Standard deviation of residuals
    Str=sqrt((sum(e)^2)/(length(e)-2));
    
    %%Standardized residuals
    Sr=e/Str;
    
    %plottar  histogram
    subplot(2,5,i)
    hist_density(Sr);
    title(strcat('Histogram Sr f�r ', namn(6) ,' och ', namn(i)));
    
    %visar f�rklaringsgrad, mode = maximum frequency
    text(min(Sr),-1,['R^2 = ' num2str(R2(i))]);
    
    %qq-plot
    subplot(2,5,i+5)
    qqplot(Sr)
    title(strcat('qq-plot f�r Sr ', namn(6) ,' och ', namn(i)));
    
   
    
end






