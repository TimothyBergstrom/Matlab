load population_america.mat;
plot(t,data)
hold on

A=polyfit(t,data,1);
B=polyval(A,t);
plot(t,B);