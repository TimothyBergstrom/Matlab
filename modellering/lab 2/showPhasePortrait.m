function showPhasePortrait(A)

  % Plot phase portrait
  [X,Y] = meshgrid(-1.5:0.1:1.5,-1.5:0.1:1.5);
  dx = A(1,1).*X + A(1,2).*Y;
  dy = A(2,1).*X + A(2,2).*Y;

  figure(10)
  clf
  quiver(X,Y,dx,dy)  

  axis tight

end