clear all
%värden i dagar
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
V=[100];
E=[0];
R=[200];
L=[0];
Totalcells=1000*(1-activation)+R+L+E;
h=0.01;
t=0;
%Euler
tic
for i=1:(120/h)
E(i+1)=E(i)+h*((1-latent)*infection*R(i)*V(i)+endlatent*L(i)-deathhiv*E(i));
L(i+1)=L(i)+h*(latent*infection*R(i)*V(i)-deathnormal*L(i)-endlatent*L(i));
R(i+1)=R(i)+h*(gamma-deathnormal*R(i)-infection*R(i)*V(i));
V(i+1)=V(i)+h*(production*E(i)-recycle*V(i));
Totalcells(i+1)=1000*(1-activation)+R(i)+L(i)+E(i);
t(i+1)=t(i)+h;
end
toc
%E = Infection of cells
%V = Free virons
%L = Latent cells
%R = Regeneration of new cells
subplot(2,3,1)
semilogy(t,Totalcells);
title('Totalt antal celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,2)
semilogy(t,R);
title('Regeneration av nya celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,3)
semilogy(t,E);
title('Infektion av celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,4)
semilogy(t,L);
title('Latenta celler')
xlabel('tid (i dagar)')
ylabel('Antal celler (logaritmisk skala)')
subplot(2,3,5)
semilogy(t,V);
title('Antal fria virus i blodet')
xlabel('tid (i dagar)')
ylabel('Antal virus (logaritmisk skala)')
subplot(2,3,6)
plotyy(t,V,t,Totalcells)
title('Totalt antal celler och virus')
xlabel('tid (i dagar)')
ylabel('Värde (logaritmisk skala)')