clear
clc
t=(0:0.02:2)*pi;
x=sin(t);
y=cos(t);
z=cos(2*t);
plot3(x,y,z,'b-',x,y,z,'bd')
view([-82,58]);
box on
legend('Á´','±¦Ê¯');<i