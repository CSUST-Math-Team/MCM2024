%例子：一元插值例interp1
clear;close;
fplot('sin',[0,2*pi]);hold on;
x=0:2*pi;y=sin(x);
h1=plot(x,y,'ko');
xi=[1:5]+0.5;
yi=interp1(x,y,xi,'linear');
h2=plot(xi,yi,'kx');
yi=interp1(x,y,xi,'spline');
h3=plot(xi,yi,'k*');
legend([h1;h2;h3],'data','linear','spline');
hold off;
