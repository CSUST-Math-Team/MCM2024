%--------------------------------------------------------------------------
%                               ���ܶȹ���
%--------------------------------------------------------------------------

%*****************************��ȡ�ļ�������********************************
% ��ȡ�ļ�examp02_14.xls�ĵ�1���������е�G2:G52�е����ݣ����ܳɼ�����
score = xlsread('examp02_14.xls','Sheet1','G2:G52');
% ȥ���ܳɼ��е�0����ȱ���ɼ�
score = score(score > 0);


%*****************����Ƶ��ֱ��ͼ�����ܶȹ���ͼ����̬�ֲ��ܶ�ͼ****************
% ����ecdf��������xc���ľ���ֲ�����ֵf_ecdf
[f_ecdf, xc] = ecdf(score);
% �½�ͼ�δ��ڣ�Ȼ�����Ƶ��ֱ��ͼ��ֱ��ͼ��Ӧ7��С����
figure;
ecdfhist(f_ecdf, xc, 7);
hold on;
xlabel('���Գɼ�');  % ΪX��ӱ�ǩ
ylabel('f(x)');  % ΪY��ӱ�ǩ

% ����ksdensity�������к��ܶȹ���
[f_ks1,xi1,u1] = ksdensity(score);
% ���ƺ��ܶȹ���ͼ������������Ϊ��ɫʵ�ߣ��߿�Ϊ3
plot(xi1,f_ks1,'k','linewidth',3)

ms = mean(score);  % ����ƽ���ɼ�
ss = std(score);  % ����ɼ��ı�׼��
% ����xi1������̬�ֲ��ܶȺ���ֵ����̬�ֲ��ľ�ֵΪms����׼��Ϊss
f_norm = normpdf(xi1,ms,ss); 
% ������̬�ֲ��ܶȺ���ͼ������������Ϊ��ɫ�㻮�ߣ��߿�Ϊ3
plot(xi1,f_norm,'r-.','linewidth',3)

% Ϊͼ�μӱ�ע�򣬱�ע���λ��������ϵ�����Ͻ�
legend('Ƶ��ֱ��ͼ','���ܶȹ���ͼ', '��̬�ֲ��ܶ�ͼ', 'Location','NorthWest')
u1    %�鿴Ĭ�ϴ���



%**********************���Ʋ�ͬ�����Ӧ�ĺ��ܶȺ���ͼ************************
% ���ô���ֱ�Ϊ0.1��1��5��9������ksdensity�������к��ܶȹ���
[f_ks1,xi1] = ksdensity(score,'width',0.1);
[f_ks2,xi2] = ksdensity(score,'width',1);
[f_ks3,xi3] = ksdensity(score,'width',5);
[f_ks4,xi4] = ksdensity(score,'width',9);
figure;  % �½�ͼ�δ���

% �ֱ���Ʋ�ͬ�����Ӧ�ĺ��ܶȹ���ͼ�����Ƕ�Ӧ��ͬ�����ͺ���ɫ
plot(xi1,f_ks1,'c-.','linewidth',2);
hold on;
xlabel('���Գɼ�');  % ΪX��ӱ�ǩ
ylabel('���ܶȹ���');  % ΪY��ӱ�ǩ
plot(xi2,f_ks2,'r:','linewidth',2);
plot(xi3,f_ks3,'k','linewidth',2);
plot(xi4,f_ks4,'b--','linewidth',2);

% Ϊͼ�μӱ�ע�򣬱�ע���λ��������ϵ�����Ͻ�
legend('����Ϊ0.1','����Ϊ1','����Ϊ5','����Ϊ9','Location','NorthWest');



%**********************���Ʋ�ͬ�˺�����Ӧ�ĺ��ܶȺ���ͼ**********************
% ���ú˺����ֱ�ΪGaussian��Uniform��Triangle��Epanechnikov�˺�����
% ����ksdensity�������к��ܶȹ���
[f_ks1,xi1] = ksdensity(score,'kernel','normal');
[f_ks2,xi2] = ksdensity(score,'kernel','box');
[f_ks3,xi3] = ksdensity(score,'kernel','triangle');
[f_ks4,xi4] = ksdensity(score,'kernel','epanechnikov');
figure;  % �½�ͼ�δ���

% �ֱ���Ʋ�ͬ�˺�����Ӧ�ĺ��ܶȹ���ͼ�����Ƕ�Ӧ��ͬ�����ͺ���ɫ
plot(xi1,f_ks1,'k','linewidth',2)
hold on
xlabel('���Գɼ�');  % ΪX��ӱ�ǩ
ylabel('���ܶȹ���');  % ΪY��ӱ�ǩ
plot(xi2,f_ks2,'r:','linewidth',2)
plot(xi3,f_ks3,'b-.','linewidth',2)
plot(xi4,f_ks4,'c--','linewidth',2)

% Ϊͼ�μӱ�ע�򣬱�ע���λ��������ϵ�����Ͻ�
legend('Gaussian','Uniform','Triangle','Epanechnikov','Location','NorthWest');



%***************���ƾ���ֲ����������Ƶķֲ�������������̬�ֲ�ͼ***************
figure;   % �½�ͼ�δ���
% ���ƾ���ֲ�����ͼ��������ͼ�ξ��h�ͽṹ�����stats��
% �ṹ�����stats��5���ֶΣ��ֱ��Ӧ��Сֵ�����ֵ��ƽ��ֵ����λ���ͱ�׼��
[h,stats] = cdfplot(score);

% ��������Ϊ��ɫ���ߣ��߿�Ϊ2
set(h,'color','r', 'LineStyle', ':','LineWidth',2);
hold on
title ('');  % ȥ��ͼ�б���
xlabel('���Գɼ�');  % ΪX��ӱ�ǩ
ylabel('F(x)');  % ΪY��ӱ�ǩ

% ����ksdensity�������ۻ��ֲ��������й���
[f_ks, xi] = ksdensity(score,'function','cdf');
% ���ƹ��Ƶķֲ�����ͼ������������Ϊ��ɫʵ�ߣ��߿�Ϊ2
plot(xi,f_ks,'k','linewidth',2);

% �����ֵΪstats.mean����׼��Ϊstats.std����̬�ֲ�������xi���ķֲ�����ֵ
y = normcdf(xi,stats.mean,stats.std);
% ������̬�ֲ��ķֲ��������ߣ�����������Ϊ��ɫ�㻮�ߣ��߿�Ϊ2
plot(xi,y,'b-.','LineWidth',2);

% ��ӱ�ע�򣬲����ñ�ע���λ����ͼ�δ��ڵ����Ͻ�
legend('����ֲ�����', '���Ƶķֲ�����','������̬�ֲ�','Location','NorthWest');
