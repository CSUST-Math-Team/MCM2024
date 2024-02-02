function xdot = lorenzeq(t,x)
xdot=[-8/3*x(1)+x(2)*x(3);
      -10*x(2)+10*x(3);
      -x(1)*x(2)+28*x(2)-x(3)];
<i