function [GA_BP_predict]=BP(x_train_regular,y_train_regular,hidden_num,input_num,...
    output_num,chrom,x_test_data,x_train_maxmin,y_train_maxmin,y_test_data)
net=newff(x_train_regular,y_train_regular,hidden_num,{'tansig','purelin'});
w1=chrom(1:input_num*hidden_num);   %输入和隐藏层之间的权重参数
B1=chrom(input_num*hidden_num+1:input_num*hidden_num+hidden_num); %隐藏层神经元的偏置
w2=chrom(input_num*hidden_num+hidden_num+1:input_num*hidden_num+...
    hidden_num+hidden_num*output_num);  %隐藏层和输出层之间的偏置
B2=chrom(input_num*hidden_num+hidden_num+hidden_num*output_num+1:input_num*hidden_num+...
    hidden_num+hidden_num*output_num+output_num); %输出层神经元的偏置
%网络权值赋值
net.iw{1,1}=reshape(w1,hidden_num,input_num);
net.lw{2,1}=reshape(w2,output_num,hidden_num);
net.b{1}=reshape(B1,hidden_num,1);
net.b{2}=reshape(B2,output_num,1);
% net.trainParam.epochs=200;          %最大迭代次数
net.trainParam.lr=0.001;          %学习率
% net.layers{1}.transferFcn='tansig';
% net.layers{2}.transferFcn='purelin';
% net.trainParam.goal=0.00001;
% net.trainParam.epochs=10;
net.trainparam.max_fail =30;%持续无法优化次数（泛化能力）
[net,~]=train(net,x_train_regular,y_train_regular);
%将输入数据归一化
x_test_regular = mapminmax('apply',x_test_data,x_train_maxmin);
%放入到网络输出数据
y_test_regular=sim(net,x_test_regular);
%将得到的数据反归一化得到预测数据
GA_BP_predict=mapminmax('reverse',y_test_regular,y_train_maxmin);
% GA_BP_predict=round(GA_BP_predict);
% mse_chrom=mse(GA_BP_predict'-y_test_data);
% mae_chrom=mean(abs((y_test_data-GA_BP_predict')));
% mape_chrom=mean(abs((y_test_data-GA_BP_predict')./y_test_data));
end