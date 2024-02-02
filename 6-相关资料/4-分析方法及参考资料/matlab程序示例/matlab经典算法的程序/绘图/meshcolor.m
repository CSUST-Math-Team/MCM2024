clear
clc
[X0,Y0,Z0]=sphere(30);       %产生单位球面的三维坐标
X=2*X0;Y=2*Y0;Z=2*Z0;        %产生半径为2的球面的三维坐标
clf
subplot(1,2,1);
surf(X0,Y0,Z0);          %画单位球面
shading interp               %采用插补明暗处理
hold on,mesh(X,Y,Z),colormap(hot),hold off       %采用hot色图
hidden off                    %产生透视效果
axis equal,axis off          %不显示坐标轴
title('透视图')
subplot(1,2,2);
surf(X0,Y0,Z0);          %画单位球面
shading interp               %采用插补明暗处理
hold on,mesh(X,Y,Z),colormap(hot),hold off       %采用hot色图
hidden on                    %产生消隐效果
axis equal,axis off          %不显示坐标轴
title('消隐图')<i