
clc
clear all
close all


%____________________________
%Parameters

tMax = 4;
dt = 0.1;
dx = 1;
dy = 1;
timeVector = 0:dt:tMax;
positionVectorX = -30:dx:30;
positionVectorY = -30:dy:30;
nTimeIterations = length(timeVector); % Number of iterations in Euler forward
nSpaceDimsX = length(positionVectorX);
nSpaceDimsY = length(positionVectorY);
D_V = 2;
D_w = 2;

% Construct the 9-pixel square source
I_source = 30;
Istart = zeros(nSpaceDimsY,nSpaceDimsX);
Istart(floor(nSpaceDimsY/2)-1:floor(nSpaceDimsY/2)+1,floor(nSpaceDimsX/2)-1:floor(nSpaceDimsX/2)+1) = I_source;
epsilon = 0.08;
a = 0.7;
b = 0.8;
% Set initial conditions
V = rand(nSpaceDimsY,nSpaceDimsX,nTimeIterations);
w = zeros(nSpaceDimsY,nSpaceDimsX,nTimeIterations);

%Time
% w(:,:,1:nTimeIterations)=0;


%____________________________
%Code
tick=0;
tack=0;
tuck=0;
for t=1:nTimeIterations-1
    for x=2:nSpaceDimsX-1
        for y=2:nSpaceDimsY-1
            
            % här måste euler implementeras 
            V(x,y,t+1)=V(x,y,t)+dt*(V(x,y,t)-((V(x,y,t)^3)/3)-w(x,y,t)+Istart(x,y)+D_V*((((V(x+1,y,t)-2*V(x,y,t)+V(x-1,y,t))/(dx^2)))+(((V(x,y+1,t)-2*V(x,y,t)+V(x,y-1,t))/(dy^2)))));
            w(x,y,t+1)=w(x,y,t)+dt*(epsilon*((V(x,y,t) + a -b*w(x,y,t))+D_w*((((w(x+1,y,t)-2*w(x,y,t)+w(x-1,y,t))/(dx^2)))+(((w(x,y+1,t)-2*w(x,y,t)+w(x,y-1,t))/(dy^2))))));
            
            tack=tack+1;
        end
        tuck=tuck+1;
    end
    
    
    % Här ska det börja från x1 och öka, tiden ska inte ändras  
   % V(end,:,t+1)=V(end-1,:,t+1);
            V(end,:,t+1)=V(end-1,:,t+1); %kant 1
            V(:,end,t+1)=V(:,end-1,t+1); %kant 2
            V(1,:,t+1)=V(2,:,t+1); %kant 3
            V(:,1,t+1)=V(:,2,t+1); %kant 4
       
            w(end,:,t+1)=w(end-1,:,t+1); %kant 1
            w(:,end,t+1)=w(:,end-1,t+1); %kant 2
            w(1,:,t+1)=w(2,:,t+1); %kant 3
            w(:,1,t+1)=w(:,2,t+1); %kant 4
      
    tick=tick+1;
    if tick>4
        Istart(:,:)=0;
    end
end

for i=1:nTimeIterations
surf(V(:,:,i))
view(2)
pause(0.1)
end


plot(timeVector,squeeze(V(30,30,:)));