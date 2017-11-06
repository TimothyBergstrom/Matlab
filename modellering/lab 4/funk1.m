function V=funk1(t,y,h,r,b,p)
 S = y(1);
 I = y(2);
 R = y(3);
 
V = [0; 0; 0];
V(1) = -h*y(1)+p*y(2)+b*y(3);
V(2) = h*y(1)-p*y(2)-r*y(2);
V(3) = r*y(2)-b*y(3);
 
end