%Uppgift_1_2

%%Clearing
clear all
close all
clc

%%Parameters
F(1)=0.2;
M(1)=0.6;
f(1)=1-F(1);
m(1)=1-M(1);
timesteps=10;
n=10;
nvektor=1:n;

%%Code

%M(t+1)=F(t);
%F(t+1)=0.5*M(t)+0.5*F(t);

for t=1:n-1
    M(t+1)=F(t);
    F(t+1)=0.5*M(t)+0.5*F(t);
end

for t=1:n-1
    m(t+1)=1-F(t);
    f(t+1)=1-(0.5*M(t)+0.5*F(t));
end

plot(nvektor,M,'b',nvektor,m,'r',nvektor,M(length(M)),'b',nvektor,m(length(m)))
legend('M','m');
title('Males, plotting m and M');
figure
plot(nvektor,F,'b',nvektor,f,'r')
legend('F','f');
title('Females, plotting f and F');

%________________

figure
plot(nvektor,M,'b',nvektor,m,'r',nvektor,M(length(M)),'b',nvektor,m(length(m)))
legend('A','a');
title('Probability of finding males with A and a');
figure
AA=(F.*F); Aa=2.*(F.*f); aa=(f.*f);
AA+Aa+aa
plot(nvektor,AA,'b',nvektor,Aa,'r',nvektor,aa)
legend('AA','Aa','aa');
title('Probability of finding females with AA, Aa and aa');
