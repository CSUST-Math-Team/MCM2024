clear
clc
subplot(2,2,1)
contour3(peaks,50); %�������������ȿռ��еĵȸ���
axis([-inf inf -inf inf -inf inf]); 
subplot(2,2,2)
contour(peaks, 50); %��������ȸ�����XYƽ���ͶӰ
subplot(2,2,3)
t=linspace(0,20*pi, 501); 
plot3(t.*sin(t), t.*cos(t), t);% �������ȿռ��е�����
subplot(2,2,4)
plot3(t.*sin(t), t.*cos(t), t, t.*sin(t), t.*cos(t), -t);% ͬʱ�����������ȿռ��е�����<i