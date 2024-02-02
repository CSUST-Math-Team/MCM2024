%微积分例1:一元函数求导（diff,gradient)
clear;close;
x=-2*pi:0.1:2*pi;
y=sin(x);
dy=diff(y)./diff(x);
plot(x,y,x(1:length(x)-1),dy);   
hold on;
yx =gradient(y,x);
plot(x,yx,'ro');
