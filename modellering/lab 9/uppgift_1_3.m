%Uppgift_1_3

%%Clearing
clear all
close all
clc

%%Parameters

nIterations = 250;
dx = 3;
dy = 3;
xMin = -50;
xMax = 50;
yMin = 0;
yMax = 60;
D = 2;
alpha = 0.3; a=alpha;
beta = 0.2; b=beta;
gamma = 0.3; g=gamma;
timeVector = 0:1:nIterations;
positionVectorX = xMin:dx:xMax;
positionVectorY = yMin:dy:yMax;
nTimeIterations = length(timeVector); % Number of iterations in Euler forward
nSpaceDimsX = length(positionVectorX);
nSpaceDimsY = length(positionVectorY);

%%Code

syms p

%steady state
f=(a*p^2 + b*p*(1-p))/(a*p^2 + 2*b*p*(1-p) + g*(1-p)^2); %ingen diffusion
steadystates=solve(f==p)


%The three debuggers
tick=0;
tack=0;
tuck=0;

%Randomiserar p
p = rand(nSpaceDimsX,nSpaceDimsY);

%for loops
for t=1:nIterations-1
    tick=tick+1;
    for x=2:nSpaceDimsX-1
        tack=tack+1;
        for y=2:nSpaceDimsY-1
            tuck=tuck+1;
            
            %Fel på diffunderingen (fixat, fel i paranteser)
            p(x,y,t+1)=((a*p(x,y,t)^2 + b*p(x,y,t)*(1-p(x,y,t)))/(a*p(x,y,t)^2 + 2*b*p(x,y,t)*(1-p(x,y,t)) + g*(1-p(x,y,t))^2))...
            +D*((p(x+1,y,t)-2*p(x,y,t)+p(x-1,y,t))/(dx^2))...   %diffundering x
            +D*((p(x,y+1,t)-2*p(x,y,t)+p(x,y-1,t))/(dy^2));     %diffundering y
        
            
            %debug
            diffx=D*((p(x+1,y,t)-2*p(x,y,t)+p(x-1,y,t))/(dx^2));
            diffy=D*((p(x,y+1,t)-2*p(x,y,t)+p(x,y-1,t))/(dy^2));
        
            %fixing sides
            %p(end,:,t+1)=p(end-1,:,t+1);
            p(end,:,t+1)=p(end-1,:,t+1); %kant 1
            p(:,end,t+1)=p(:,end-1,t+1); %kant 2
            p(1,:,t+1)=p(2,:,t+1); %kant 3
            p(:,1,t+1)=p(:,2,t+1);%kant 4
            
        end
    end
end

for i=1:nIterations
surf(p(:,:,i))
%view(2)
pause(0.1)
end


pstart=p(:,:,1);
i=1;
for n=[1 3 5 10 15 20 30]
    pgeneration(:,:,i)=p(:,:,n);
    i=i+1;
end

