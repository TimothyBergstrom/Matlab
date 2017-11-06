%Extra uppgift


close all
clear all
 
load population_data_swedish_bears.mat;
t = t - t(1); % Shift the time so that it starts from t = 0
 
% Plot observed data
plot(t,data,'kx');
hold on
title('Exponential data fit');
xlabel('time');
ylabel('Population size');
%Make data linear
lnData = log(data);
tData = [ones(size(t)),t];
%Estimate parameters using MATLAB row reduction
parameters = tData\lnData;
y0 = exp(parameters(1)); % y0 = exp(lny0);
growthFactor = parameters(2);
% Generate data using the exponential model with estimated parameters
data_fit = y0.*exp(growthFactor.*t);
% Plot resulting data
% figure(3);  
% hold on
% plot(t,data_fit,'k-','linewidth',2);
 
%______________________________________________
 
%Alla punkter = validation set

%y=y0.*exp(r.*t);
%log(y)=log(y0) + r*t
%Y=b+m*t

tid=1:78;
c=polyfit(t,log(data),1);
r=c(1);
y0=exp(c(2));
yy=y0.*exp(r.*tid);
plot(tid,yy);
hold on
 
% derp=polyval(c,tid);
% figure(2)
% plot(tid,derp);

 

%__________________________________

%De 4 första punkterna


%Från boken (det andra är mer effektivt)
sumy=sum(log(data(1:4)));
sumx=sum(t(1:4));
t2=t(1:4).*t(1:4);
sumx2=sum(t2);
tdata=t(1:4).*log(data(1:4));
sumxy=sum(tdata);
m=(4*sumxy-sumx*sumy)/(4*sumx2-sumx^2);
b=(sumx2*sumy-sumx*sumxy)/(4*sumx2-sumx^2);

sparadsumma1=0;

for i=5:9
   summa=(data(i)-(m*t(i)+b))^2;
   sparadsumma1=sparadsumma1+summa;
end

disp(sparadsumma1);

spara1=b;
b=exp(b);
r=m;
y0=b;



for i=1:9
   y(i)=y0*exp(r.*t(i));
end

plot(t,y,'g');


%_______________________________
%punkter 4 till 9

%Från boken (det andra är mer effektivt)
sumy=sum(log(data(4:8)));
sumx=sum(t(4:8));
t2=t(4:8).*t(4:8);
sumx2=sum(t2);
tdata=t(4:8).*log(data(4:8));
sumxy=sum(tdata);
m=(5*sumxy-sumx*sumy)/(5*sumx2-sumx^2);
b=(sumx2*sumy-sumx*sumxy)/(5*sumx2-sumx^2);


sparadsumma2=0;


for i=1:4
   summa=(data(i)-(m*t(i)+b))^2;
   sparadsumma2=sparadsumma2+summa;
end

disp(sparadsumma2);

spara2=b;
b=exp(b);
r=m;
y0=b;

for i=1:9
   y(i)=y0*exp(r.*t(i));
end

plot(t,y,'r');

legend('Points','Validation set: All points','Only 4 points','The five last points');


% tid=0;
% Y=0;
% for i=1:78
% Y(i)=m*tid+b;
% tid=tid+1;
% end
 
