r=[1 1 -1 0 0 -2];
a=[1 0 0 1 -1 -1];
m=[1 0 0 0 1 1];
d=[1 1 -1 1 1 -1];
disp('tryck för nästa steg');

for i=1:6
    R=r(i);
    A=a(i);
    M=m(i);
    D=d(i);
    A=[R A;M D];
    showPhasePortrait(A);
    eig(A)
    k = waitforbuttonpress;
    close all
end
close all