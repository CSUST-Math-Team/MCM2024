clear
clc
[x,y,z] =peaks; 
subplot(2,3,1);
meshz(x,y,z); %�������Χȹ,�������������ƽ��
axis([-inf inf -inf inf -inf inf]); 
subplot(2,3,2);
waterfall(x,y,z); %��x�������ˮ��Ч��
axis([-inf inf -inf inf -inf inf]); 
subplot(2,3,3);
meshc(x,y,z); %ͬʱ������״ͼ��ȸ���
axis([-inf inf -inf inf -inf inf]); 
subplot(2,3,4);
surfc(x,y,z); %ͬʱ��������ͼ��ȸ���
axis([-inf inf -inf inf -inf inf]);
subplot(2,3,5)
surfl(x,y,z); %����������Ч���Ĳ�ɫ����ͼ
axis([-inf inf -inf inf -inf inf]);
subplot(2,3,6)
contourf(x,y,z);
axis([-inf inf -inf inf -inf inf]);<i