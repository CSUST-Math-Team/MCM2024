%微积分例2:二元函数求导（gradient)
clear;close;
xa=-1:0.1:1;ya=-1:0.1:1;
[x,y]=meshgrid(xa,ya);
F=y.*x.^2+y.^3.*x;
[fx,fy]=gradient(F,xa,ya);
subplot(1,2,1);mesh(fx);
subplot(1,2,2);mesh(fy);
