%方程求根例4:解方程组f=0,g=0图解法
clear;close;
x1a=-1:0.01:1;
x2a=-1:0.01:1;
[x1,x2]=meshgrid(x1a,x2a);
f=4*x1-x2+exp(x1)/10-1;
g=-x1+4*x2+x1.^2/8;
contour(x1,x2,f,[0,0]);
hold on;
contour(x1,x2,g,[0,0]);
xlable('x');
ylable('y');
grid;
hold off;
zoom;
