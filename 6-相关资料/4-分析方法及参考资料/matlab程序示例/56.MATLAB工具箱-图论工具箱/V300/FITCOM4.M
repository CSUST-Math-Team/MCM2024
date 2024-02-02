%例子：样条插值与拟合

clear;close;
x=linspace(0,2*pi,21);
y=sin(x)+(rand(1,21)-0.5)*0.1;
plot(x,y,'o');hold on;fnplt(csape(x,y));
fnplt(csaps(x,y,0.8),'r:');hold off;
