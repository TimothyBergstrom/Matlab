function V=delayfunk(t,x,Z,a,u)
 
V = [0; 0; 0];
 
V(1) = -a*x(1)*x(2)+Z(3);
V(2) = a*x(1)*x(2)-u*x(2);
V(3) = u*x(2)-Z(3);
 
end
