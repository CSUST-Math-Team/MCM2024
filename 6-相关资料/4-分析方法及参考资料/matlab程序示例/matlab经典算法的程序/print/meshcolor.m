clear
clc
[X0,Y0,Z0]=sphere(30);       %������λ�������ά����
X=2*X0;Y=2*Y0;Z=2*Z0;        %�����뾶Ϊ2���������ά����
clf
subplot(1,2,1);
surf(X0,Y0,Z0);          %����λ����
shading interp               %���ò岹��������
hold on,mesh(X,Y,Z),colormap(hot),hold off       %����hotɫͼ
hidden off                    %����͸��Ч��
axis equal,axis off          %����ʾ������
title('͸��ͼ')
subplot(1,2,2);
surf(X0,Y0,Z0);          %����λ����
shading interp               %���ò岹��������
hold on,mesh(X,Y,Z),colormap(hot),hold off       %����hotɫͼ
hidden on                    %��������Ч��
axis equal,axis off          %����ʾ������
title('����ͼ')<i