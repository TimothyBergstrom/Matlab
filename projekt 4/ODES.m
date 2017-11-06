%Uppgift ODE:s
clear all
%värden
gamma = 1.36;
micro = 1.36e-3;
tau = 0.2;
beta = 0.00027;
p = 0.1;
alpha = 3.6e-2;
sigma = 2;
delta = 0.33;
pii = 100;
regen = gamma;
deathnormal = micro;
activation = tau;
infection = beta;
latent = p;
endlatent = alpha;
recycle = sigma;
deathhiv = delta;
production = pii;
%Totalcells=1000*(1-activation)+R+L+E;
%ODE45
%____________________________________
tic
VERL=[];
VERL0=[100;0;200;0];
dagar=[0:120];
[t,VERL]=ode45(@(t,VERL)infectionfunktion(t,regen,activation,deathnormal,infection,latent,endlatent,recycle,deathhiv,production,VERL), dagar, VERL0);
toc
for i=1:121
Totalcells(i)=1000*(1-activation)+VERL(i,3)+VERL(i,4)+VERL(i,2);
end
Totalcells=Totalcells';
subplot(2,3,1)
plot(t,Totalcells);
title('Totalt antal celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,2)
semilogy(t,VERL(:,3));
title('Regeneration av nya celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,3)
semilogy(t,VERL(:,2));
title('Infektion av celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,4)
semilogy(t,VERL(:,4));
title('Latenta celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,5)
semilogy(t,VERL(:,1));
title('Antal fria virus i blodet')
xlabel('tid (i dagar)')
ylabel('Antal virus (logaritmisk skala)')
subplot(2,3,6)
hold off
yyaxis left
plot(t,Totalcells);
yyaxis right
semilogy(t,VERL(:,1));
title('Totalt antal celler och virus')
xlabel('tid (i dagar)')
ylabel('Värde (logaritmisk skala)')
%__________________________________________
%ODE15s
tic
VERL=[];
[t,VERL]=ode15s(@(t,VERL)infectionfunktion(t,regen,activation,deathnormal,infection,latent,endlatent,recycle,deathhiv,production,VERL), dagar, VERL0);
toc
for i=1:121
Totalcells(i)=1000*(1-activation)+VERL(i,3)+VERL(i,4)+VERL(i,2);
end
Totalcells=Totalcells';
figure;
subplot(2,3,1)
semilogy(t,Totalcells);
title('Totalt antal celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,2)
semilogy(t,VERL(:,3));
title('Regeneration av nya celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,3)
semilogy(t,VERL(:,2));
title('Infektion av celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,4)
semilogy(t,VERL(:,4));
title('Latenta celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,5)
semilogy(t,VERL(:,1));
title('Antal fria virus i blodet')
xlabel('tid (i dagar)')
ylabel('Antal virus (logaritmisk skala)')
subplot(2,3,6)
semilogy(t,Totalcells);
hold on
semilogy(t,VERL(:,1));
title('Totalt antal celler och virus')
xlabel('tid (i dagar)')
ylabel('Värde (logaritmisk skala)')
