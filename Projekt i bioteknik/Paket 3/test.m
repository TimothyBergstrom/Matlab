%Paket 3
clc
clear all
close all
 
%loading
load EnzData_GroupR.mat
 
%%no inhib finding values of v and converting to M/s
for i=1:length(EnzymeNoInh)
velocity{i}=EnzymeNoInh(:,i);
tempvector=velocity{i};
	for ii=1:length(velocity{i})
    vconvert(ii)=tempvector(ii)*((10^-3));
	end
C=polyfit(time, vconvert', 1);
v(i)=C(1); %gör polyfit istället
end
 
%finding and converting values of S
S=SubstrateConc.*10^-3;
 
%plotting normal
figure()
scatter(S,v)
hold on
eq=polyfit(S,v,4);
eqval=polyval(eq,S);
plot(S,eqval);
title('Nonlinear Regression Model')
legend('scatter','Non linear regression');
xlabel('S0');
ylabel('v')

%calculating KM and vmax from plot
disp('normal, looking at the plots')
Vmax=1.2*10^-6
KM=0.95*10^-3

%Burkplot
vburk=1./v;
Sburk=1./S;
 
%plotting Lineweaver burk
figure()
scatter(Sburk,vburk)
hold on
eq=polyfit(Sburk,vburk,1);
eqval=polyval(eq,Sburk);
plot(Sburk,eqval);
title('Lineweaver burk plot')
legend('scatter','Linear regression');
xlabel('1/S0');
ylabel('1/v')

figure()
hold on
eq=polyfit(Sburk,vburk,1);
eqval=polyval(eq,Sburk);
plot(Sburk,eqval);

%calculating KM and vmax from plot
disp('Lineweaver burk, calculating with matlab')
intersect=eq(2); %skärning = 1/vmax
Vmax=1/intersect
slope=eq(1); %lutning = km/vmax
KM=Vmax*slope

Vmaxsave=Vmax;  %Sparar värden
KMsave=KM;


%%with inhibitors

for iii=1:3;
    for i=1:length(EnzymeNoInh)
    velocity{i}=EnzymeInh(:,i,iii);
    tempvector=velocity{i};
        for ii=1:length(velocity{i})
        vconvert(ii)=tempvector(ii)*((10^-3));
        end
    C=polyfit(time, vconvert', 1);
    v(iii,i)=C(1); %gör polyfit istället  Rad = inhib 1,2,3
    end
end


for i=1:3
vburk=1./v(i,:);
Sburk=1./S;
 
%plotting Lineweaver burk
hold on
hold on
eq=polyfit(Sburk,vburk,1);
eqval=polyval(eq,Sburk);
plot(Sburk,eqval);
end
title('Lineweaver burk plot with Inhib')
legend('Linear regression, no inhib', 'Inhib 1', 'Inhib 2', 'Inhib 3');
xlabel('1/S0');
ylabel('1/v')


%Komptetitiv (om man ser på graf)
% 1/v=1/vmax+(km/vmax)*alpha/S, alpha = 1 + I/Ki
%slope=alpha*km/vmax
%slope*vmax/km=1+I/Ki
%((slope*vmax/km)-1)/I=1/Ki
% Ki=(((slope*vmax/km)-1)/I)^-1

for i=1:3
vburk=1./v(i,:);
Sburk=1./S;
%plotting Lineweaver burk
hold on
hold on
eq=polyfit(Sburk,vburk,1);
eqval=polyval(eq,Sburk);
slope=eq(1);
Ki(i)=InhibitorConc(i)/((slope*Vmaxsave/KMsave)-1);
end

Ki=mean(Ki)

