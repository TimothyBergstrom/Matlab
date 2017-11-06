%jos
r=0.5;
K=1000;
y0=[3,2000];
tmax=10;
timeSpan = [0 tmax];

exp_growth = @(t,y) r*y.*(1-y/K);
[t,y] = ode45(exp_growth, timeSpan, y0);


for i=(tau/dt):length(timeVector)-1
y(i+1)=y(i)+dt*growthRate*y(i-(-1+tau/dt));
end

