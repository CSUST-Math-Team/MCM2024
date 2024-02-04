clc;
clear;
data=xlsread('波动预测数据集.xlsx');
train_ratio=0.8;%用作训练集的比例
train1=data(1:(floor(train_ratio*size(data, 1))),:);%前80%用于训练
x_train=train1(:,1:end-1);
y_train=train1(:,end);
test1=data(((floor(train_ratio*size(data, 1)))+1):size(data, 1),:);%后20%用于测试
x_test=test1(:,1:end-1);
y_test=test1(:,end);
% 进行标准化
[x_train_normalized, mu, sigma] = zscore(x_train);
x_test_normalized = (x_test - mu) ./ sigma;


%建立网络
net=feedforwardnet([40]);%建立一个隐含层数为1，节点数为10的网络;这里用了梯度下降的训练函数

%定义在训练集过程中不使用测试集，只保留训练集与验证集（用于验证泛化能力）
net.divideParam.trainRatio = 80/100; %训练集
net.divideParam.valRatio = 20/100; %验证集
net.divideParam.testRatio = 0/100; %测试集

% net.trainParam.epochs=5000;%指定最大迭代次数
% net.trainParam.goal=0.4;%目标精度，验证集的误差达到该数字时就停止迭代
% net.trainParam.min_grad=1e-2;%最小下降梯度
% net.trainParam.lr=0.1;%学习率
% net.trainparam.max_fail =20;%持续无法优化次数（泛化能力）
% net.layers{2}.transferFcn= 'logsig';%指定传递函数
%训练网络。
net=train(net,x_train_normalized',y_train');%注意，这里每一列为一个实例，所以需要转置
%测试效果
test_out=sim(net,x_test_normalized');%测试
test_out=test_out';
%分类
test_out=round(test_out);
for i=1:size(test_out,1)
   if test_out(i,1)<0
       test_out(i,1)=0;
   end
   if test_out(i,1)>1
       test_out(i,1)=1;
   end
end

