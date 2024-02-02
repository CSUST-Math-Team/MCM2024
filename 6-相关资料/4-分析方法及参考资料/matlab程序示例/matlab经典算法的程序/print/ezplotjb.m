clear
clc
subplot(3,3,1)
ezplot('cos(x)')
subplot(3,3,2)
ezplot('cos(x)', [0, pi])
subplot(3,3,3)
ezplot('1/y-log(y)+log(-1+y)+x - 1')
subplot(3,3,4)
ezplot('x^2 - y^2 - 1')
subplot(3,3,5)
ezplot('x^2 + y^2 - 1',[-1.25,1.25]); 
axis equal
subplot(3,3,6)
ezplot('x^3 + y^3 - 5*x*y + 1/5',[-3,3])
subplot(3,3,7)
ezplot('x^3 + 2*x^2 - 3*x + 5 - y^2')
subplot(3,3,8)
ezplot('sin(t)','cos(t)')
subplot(3,3,9)
ezplot('sin(3*t)*cos(t)','sin(3*t)*sin(t)',[0,pi])<i