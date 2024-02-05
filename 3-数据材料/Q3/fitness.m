function fitness_value=fitness(input_chrom,input_num,hidden_num,output_num,input_data,output_data)
%该函数用来计算适应度值
%input_chrom     输入种群
%input_num        输入层的节点数，即数据特征数量
%output_num      隐含层节点数,隐藏层神经元的个数
%input_data        训练输入数据
%output_data     训练输出数据
%fitness_value    个体适应度值
w1=input_chrom(1:input_num*hidden_num);   %输入和隐藏层之间的权重参数
B1=input_chrom(input_num*hidden_num+1:input_num*hidden_num+hidden_num); %隐藏层神经元的偏置
w2=input_chrom(input_num*hidden_num+hidden_num+1:input_num*hidden_num+...
    hidden_num+hidden_num*output_num);  %隐藏层和输出层之间的偏置
B2=input_chrom(input_num*hidden_num+hidden_num+hidden_num*output_num+1:input_num*hidden_num+...
    hidden_num+hidden_num*output_num+output_num); %输出层神经元的偏置
%网络权值赋值
W1=reshape(w1,hidden_num,input_num);
W2=reshape(w2,output_num,hidden_num);
B1=reshape(B1,hidden_num,1);
B2=reshape(B2,output_num,1);

% IGABP
[~,n]=size(input_data);
A1=tansig(W1*input_data+repmat(B1,1,n));   %需与main函数中激活函数相同
A2=purelin(W2*A1+repmat(B2,1,n));      %需与main函数中激活函数相同 
A2=round(A2);

% GABP
% net=newff(input_data,output_data,hidden_num,{'tansig','purelin'});
% net.trainParam.epochs=10;
% net.trainParam.lr=0.1;
% net.trainParam.goal=0.00001;
% net.trainParam.show=100;
% net=train(net,input_data,output_data);
% A2=sim(net,input_data);
% A2=round(A2);

mse_chrom=mse(A2'-output_data);
fitness_value=mse_chrom; %误差即为适应度
end