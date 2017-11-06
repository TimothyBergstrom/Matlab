%% uppgift 2

%Stänger
close all
clear all
clc

%% Kod från rapport    

%Test med olika beta
betacell{1} = [2 3]; betacell{2} = [5 4]; betacell{3} = [1 10];
betacell{4} = [-1 10]; betacell{5} = [1 100]; betacell{6} = [5 5];


betacell=betacell';
betamatris= cell2mat(betacell);
realBeta=[2 3];

diary on
diary('datafil.txt')

for i = 1:length(betamatris)
realBeta=betamatris(i,:);
realBeta

%Värden
n=10000;p=unifrnd(0,1,[1,n]);
e=log(p./(1-p));x=normrnd(0,1,[1,n]);
y1=realBeta(1)+realBeta(2)*x+e;
y=(sign(y1)+1)/2;oneOutcomeFrequency=sum(y)/n %Calculate the frequency of 1s in the outcomes
[betaEstimate,stderr,phat,deviance] = logisticmle(y,x);
betaEstimate

%korsvalidering
pTest=unifrnd(0,1,[1,n]);
xTest=normrnd(0,1,[1,n]);
eTest=log(pTest./(1-pTest));
yTestReal=realBeta(1)+realBeta(2)*xTest+eTest;
yTestReal=(sign(yTestReal)+1)/2;
yTestPred=betaEstimate(1)+betaEstimate(2)*xTest;

%testset
yTestPred=(sign(yTestPred)+1)/2;
diff=yTestReal-yTestPred;
modelAccuracy=1-(sum(diff==1)+sum(diff==-1))/n
cross=crosstab(yTestPred,yTestReal);
kappa(cross)

%predo´
oneModelAccuracy=1-(sum((1-yTestReal)==1)+sum((1-yTestReal)==-1))/n
cross2=crosstab(zeros(n,1)+1,yTestReal);
cross2=[0, 0 ; cross2(1) cross2(2)];
kappa(cross2)


disp('_______________________________________________________')
for loop=1:5
disp(' ')
end

end

diary off



disp('Fil sparad')


%Vad händer med måtten träffsäkerhet och kappa?

%När jag ändrar från 2 3 till 5 4 ökar modelaccuracy (descending)
...och när jag ändrar till 1 10 så minskar accurycy