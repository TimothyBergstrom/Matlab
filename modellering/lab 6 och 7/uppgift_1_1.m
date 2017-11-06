%Uppgift 1.1

clear all

%Parameters
nParticles = 10000;
nRandomSteps = 60; %Mellan 200 och 250 så blir det något fel, diffar detta mycket
dt = 0.05;
dx = 1;
binary=[-1 1];

%____________________________
%Randomised

for ii=1:nParticles
    for i=1:nRandomSteps
    random(i)=binary(randi(numel(binary)));
    end
Particle{ii}=(random);
Steg(ii)=sum(random);
end

h=histogram(Steg,'Normalization','probability');
hold on

%____________________________
%Theoretical

D=(dx^2)/(2*dt);
% syms t x
t=nRandomSteps*dt;
x = -nRandomSteps:nRandomSteps;

probabilityfunk=((2*dx)/(sqrt(4*pi*D*t)))*exp((-x.^2)/(4*D*t));
plot(x,probabilityfunk);    

hold off


%____________________________
%System toolbox

%visa att 1 stämmer med 2, inte tvärt om!

syms t x dx dt

probabilityfunk=((2*dx)/(sqrt(4*pi*D*t)))*exp((-x.^2)/(4*D*t));
p=probabilityfunk;

pdifft=diff(p,t);
pdiffx=diff(p,x);
pdiffdiffx=diff(pdiffx,x);
sol=D*pdiffdiffx-pdifft;

disp(sol)


%visar tvärt om.... feel!
% 
% D=(dx^2)/(2*dt);
% m=x/dx;
% n=t/dt;
% r=(1/2)*(n+m);
% facn=factorial(n);
% facr=factorial(r);
% facnr=factorial(n-r);
% C=facn/(facr*facnr);
% p=C/(2^n);
% pdifft=diff(p,t);
% pdiffx=diff(p,x);
% pdiffdiffx=diff(pdiffx,x);
% sol=D*pdiffdiffx-pdifft;
% disp(sol)