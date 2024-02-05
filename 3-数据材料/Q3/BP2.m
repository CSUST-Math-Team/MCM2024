clc;clear;close all;
% load('m5000.mat')%导入数据
data=xlsread('GABP数据集.xlsx');
train1=data(1:100,:);
test1=data(101:end,1:end-1);


net=feedforwardnet([10 10 10]);%建立一个隐含层数为1，节点数为10的网络

%定义在训练集过程中不使用测试集，只保留训练集与验证集（用于验证泛化能力）
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;

%训练网络。
net=train(net,(train1(:,1:(end-1)))',(train1(:,end))');%注意，这里每一列为一个实例，所以需要转置
%测试效果
test_out=sim(net,(test1)');%测试
test_out=test_out';