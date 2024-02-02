clear
clc
x=-2:0.01:2;
[x,y]=meshgrid(x,x); %x和y都是401x401的矩阵
r=sqrt(x.^2+x.^2)+eps;
z=sinc(r);
subplot(2,1,1);
mesh(z);
subplot(2,1,2);
surf(x,y,z);
<i