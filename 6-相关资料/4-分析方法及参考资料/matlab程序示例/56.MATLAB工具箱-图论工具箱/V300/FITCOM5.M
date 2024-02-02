%例子：
%二元插值interp2
%不规则数据griddata

clear;close;
%二元插值interp2
x=0:4;y=2:4;
z=[82 81 80 82 84;79 63 61 65 81;84 84 82 85 86];
[x,y]=meshgrid(x,y);
subplot(2,2,1);
mesh(x,y,z);title('RAW DATA');
xi=0:0.1:4;yi=2:0.2:4;
[XI,YI]=meshgrid(xi,yi);
zspline=interp2(x,y,z,XI,YI,'spline');
subplot(2,2,2);
mesh(XI,YI,zspline);
title('SPLINE');

%不规则数据griddata
x=[2,3,4,0,2,3,0,1,4];
y=[2,2,2,3,3,3,4,4,4];
z=[80,82,84,79,61,65,84,84,86];
subplot(2,2,3);stem3(x,y,z);title('RAW DATA');
ZI=griddata(x,y,z,XI,YI,'cubic');
subplot(2,2,4);mesh(XI,YI,ZI);title('GRIDDATA');
