syms y(t) y0 r K theta;
dSol = dsolve(diff(y) == r*y*(1-y/K), y(0) == y0);
disp(simplify(dSol));

ODE = r*y*((y/theta)-1)*(1-(y/K));

%solution
syms y y0 r K theta;
S=solve(r*y*((y/theta)-1)*(1-(y/K))==0)

%eigenvalues
DER=diff(r*y*((y/theta)-1)*(1-(y/K)))
EIGEN=solve(DER==0)

%K>theta
NEWDER = subs(DER, y, S(2))
NEWDER = subs(DER, y, S(3))



%för vilka r är theta<K?


% odesol = dsolve(diff(y) == ODE, y(0) == y0);
% disp(simplify(odesol));
% solve(K*log(y - theta) - theta*log(y - K) - log(y)*(K - theta) == -(K - theta)*(r*t + (theta*log(y0 - K) - K*log(y0 - theta) + log(y0)*(K - theta))/(K - theta)), y)