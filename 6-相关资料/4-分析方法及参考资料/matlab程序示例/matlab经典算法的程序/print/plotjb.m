clear
clc
t=0:0.001:10;
y=sin(t);
% plot(t,y);
Y=sin(10*t);
c=y.*Y;
plot(t,y,'r:',t,c,'b')


<i