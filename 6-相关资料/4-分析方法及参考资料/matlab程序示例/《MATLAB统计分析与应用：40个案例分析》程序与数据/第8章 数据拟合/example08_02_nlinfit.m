%--------------------------------------------------------------------------
%             ��ȡԭʼ���ݣ�����nlinfit������һԪ�����Իع�
%--------------------------------------------------------------------------

%***************************��ȡ���ݣ�����ɢ��ͼ*****************************
HeadData = xlsread('examp08_02.xls');    %��Excel�ļ���ȡ����
x = HeadData(:, 4);    % ��ȡHeadData����ĵ�4�����ݣ�����������
y = HeadData(:, 9);    % ��ȡHeadData����ĵ�9�����ݣ���ͷΧ����
plot(x, y, 'k.')    % ����x��y��ɢ��ͼ
xlabel('����(x)')    % ΪX��ӱ�ǩ
ylabel('ͷΧ(y)')    % ΪY��ӱ�ǩ


%***********************����nlinfit������һԪ�����Իع�**********************
HeadData = xlsread('examp08_02.xls');    % ��Excel�ļ���ȡ����
HeadData = sortrows(HeadData, 4);    % Ϊ��ͼ��Ҫ����HeadData����4�д�С��������
x = HeadData(:, 4);    % ��ȡ�������������
y = HeadData(:, 9);    % ��ȡ�����ͷΧ����
options = statset;     % ����һ���ṹ������������趨�����㷨�Ŀ��Ʋ���
options.Robust = 'on';    % �����Ƚ���Ϸ���
% ����nlinfit�����������Իع�
[beta,r,J,COVB,mse] = nlinfit(x,y,@HeadCir1,[53,-0.2604,0.6276], options); 
%[beta,r,J,COVB,mse] = nlinfit(x,y,'HeadCir1',[53,-0.2604,0.6276],options);

%HeadCir2 = @(beta, x)beta(1)*exp(beta(2)./(x+beta(3)));    % ������������
%[beta,r,J,COVB,mse] = nlinfit(x,y,HeadCir2,[53,-0.2604,0.6276],options);
beta    %�鿴δ֪��������ֵ
mse    % �鿴�����в�ƽ����


%**************************����һԪ�����Իع�����****************************
yhat = HeadCir1(beta, x);    % ��y�Ĺ���ֵ
figure    % �½�һ���յ�ͼ�δ���
plot(x, y, 'k.')    % ����x��y��ɢ��ͼ
hold on

% ����robustfit������Ӧ�Ļع�ֱ�ߣ���ɫʵ�ߣ��߿�Ϊ3
plot(x, yhat, 'linewidth', 3)
xlabel('����(x)')    % ��X��ӱ�ǩ
ylabel('ͷΧ(y)')    % ��Y��ӱ�ǩ
legend('ԭʼ����ɢ��','�����Իع�����')    % Ϊͼ�μӱ�ע��


%**************************��������ֵ����������*****************************
% ���������ֵ��95%��������ĵ�1�ַ�ʽ
ci1 = nlparci(beta, r, 'covar', COVB, 'alpha', 0.05) 

% ���������ֵ��95%��������ĵ�2�ַ�ʽ
ci1 = nlparci(beta, r, 'jacobian', J, 'alpha', 0.05) 


%**************************����ͷΧ�۲�ֵ��Ԥ������**************************
xx =[0:0.1:16]';    % �趨��������

% ����������䴦ͷΧԤ��ֵ��Ԥ������
[ypred,delta] = nlpredci(@HeadCir1,xx,beta,r,'covar',COVB,'mse',mse, ...
                            'predopt','observation');

yup = ypred + delta;    % Ԥ���������ޣ��ߣ�
ydown = ypred - delta;    % Ԥ���������ޣ��ߣ�

figure    % �½�һ���յ�ͼ�δ���
hold on
h1 = fill([xx; flipud(xx)],[yup; flipud(ydown)],[0.5,0.5,0.5]);   % ���Ԥ������
set(h1,'EdgeColor','none','FaceAlpha',0.5);   % �����������߽�������ɫ�����͸����

plot(xx,yup,'r--','LineWidth',2);    % ��Ԥ�������������ߣ���ɫ����
plot(xx,ydown,'b-.','LineWidth',2);    % ��Ԥ�������������ߣ���ɫ�㻮��
plot(xx, ypred, 'k','linewidth', 2)    % ���ع����ߣ���ɫʵ��

grid on    % ��Ӹ�������
ylim([32, 57])    % ����y�����ʾ��ΧΪ32��57
xlabel('����(x)')    % ��X��ӱ�ǩ
ylabel('ͷΧ(y)')    % ��Y��ӱ�ǩ
h2 = legend('Ԥ������','Ԥ����������','Ԥ����������','�ع�����');    % Ϊͼ�μӱ�ע��
set(h2, 'Location', 'SouthEast')    % ���ñ�ע��ķ���λ��Ϊͼ�δ������½�