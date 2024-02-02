clear
clc
subplot(2,2,1)
contour3(peaks,50); %画出曲面在三度空间中的等高线
axis([-inf inf -inf inf -inf inf]); 
subplot(2,2,2)
contour(peaks, 50); %画出曲面等高线在XY平面的投影
subplot(2,2,3)
t=linspace(0,20*pi, 501); 
plot3(t.*sin(t), t.*cos(t), t);% 画出三度空间中的曲线
subplot(2,2,4)
plot3(t.*sin(t), t.*cos(t), t, t.*sin(t), t.*cos(t), -t);% 同时画出两条三度空间中的曲线<i