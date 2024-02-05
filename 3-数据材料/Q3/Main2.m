clc;clear;close all;
% load('m5000.mat')%导入数据
data=xlsread('波动预测数据集.xlsx');
%% 导入数据
% rowrank = randperm(size(data, 1));
% data=data(rowrank,:);
%设置训练数据和测试数据
[m,n]=size(data);
train_num=100; %自变量
x_train_data=data(1:train_num,1:n-1);
y_train_data=data(1:train_num,n);
%测试数据
x_test_data=data(1:end,1:n-1);
y_test_data=data(1:end,n);
x_train_data=x_train_data';
y_train_data=y_train_data';
x_test_data=x_test_data';
%% 标准化
[x_train_regular,x_train_maxmin] = mapminmax(x_train_data);
[y_train_regular,y_train_maxmin] = mapminmax(y_train_data);
%% 定义参数
input_num=size(x_train_data,1); %输入特征个数
hidden_num=6;   %隐藏层神经元个数
output_num=size(y_train_data,1); %输出特征个数
NIND=50; %每次生成的个体数（也是遗传算法的种群的大小）
iter=20;
cross_pro=0.7;      %交叉概率
mutation_pro=0.3;   %变异概率
%% 初始化
[init_popu]=initialize(hidden_num,x_train_regular,y_train_regular,NIND); %init_popu就是初始种群
%% 接下来给正常的BP神经网络进行优化，并计算误差
% MSE_BP=[];
% MAE_BP=[];
% MAPE_BP=[];
% for nind=1:NIND
%     chrom=init_popu(nind,:);  %最好的染色体
%     [mse_chrom,mae_chrom,mape_chrom]=BP(x_train_regular,y_train_regular,hidden_num,input_num,output_num,chrom,...
%         x_test_data,x_train_maxmin,y_train_maxmin,y_test_data); %运行BP神经网络。并返回MSE、MAE与MAPE
%     MSE_BP=[MSE_BP;mse_chrom];
%     MAE_BP=[MAE_BP;mae_chrom];
%     MAPE_BP=[MAPE_BP;mape_chrom];
% end
% E_BP=[MSE_BP MAE_BP MAPE_BP];
%% 接下来进行改进GABP的运算
lenchrom=ones(1,size(init_popu,2));  %生成规模为种群总长度的全1矩阵
GAed_popu=[];
new_popu=init_popu;
input_data=x_train_regular;
output_data=y_train_regular;
limit(1,:)=min(new_popu);
limit(2,:)=max(new_popu);
limit=limit';
limit(1,:)=limit(1,:)+0.1*limit(1,:);
limit(2,:)=limit(2,:)+0.1*limit(2,:);
for k=1:size(limit,1)
   if limit(k,1)<-2
       limit(k,1)=-2;
   end
   if limit(k,1)>2
       limit(k,2)=2;
   end
end
for d=1:iter
    %交叉
    new_popu=Cross(cross_pro,new_popu,size(new_popu,1));
    % 变异
    new_popu=Mutation(mutation_pro,lenchrom,new_popu,size(new_popu,1),limit);
    % 计算适应度
    new_fitness=[];
    for j=1:size(new_popu,1)
        sgroup=new_popu(j,:); %个体
        new_fitness(j)=fitness(sgroup,input_num,hidden_num,output_num,input_data,output_data);
    end
    % 选择
    [new_popu]=select(new_popu,new_fitness,NIND);%把表现好的挑出来，还是和种群数量一样
end
GAed_popu=new_popu;
%接下类进行GABP的BP阶段
MSE_GABP=[];
MAE_GABP=[];
MAPE_GABP=[];
P=[];
for nind=1:NIND
    chrom=GAed_popu(nind,:);  %最好的染色体
    [GA_BP_predict]=BP(x_train_regular,y_train_regular,hidden_num,input_num,output_num,chrom,...
        x_test_data,x_train_maxmin,y_train_maxmin,y_test_data); %运行BP神经网络。并返回MSE、MAE与MAPE
%     MSE_GABP=[MSE_GABP;mse_chrom];
%     MAE_GABP=[MAE_GABP;mae_chrom];
%     MAPE_GABP=[MAPE_GABP;mape_chrom];
P=[P GA_BP_predict'];
end
% E_GABP=[MSE_GABP MAE_GABP MAPE_GABP];
p1=round(P(:,1));
for i=1:size(p1,1)
   if p1(i,1)<0
       p1(i,1)=0;
   end
   if p1(i,1)>1
       p1(i,1)=1;
   end
end