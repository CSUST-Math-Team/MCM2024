function [pre]=initialize(hidden_num,x_train_regular,y_train_regular,NIND)
pre=[]; %这里储存初始化的权重，每行就是一个个体
for iter=1:NIND
    pre_chrom=[];
    pre_net=newff(x_train_regular,y_train_regular,hidden_num,{'tansig','purelin'},'trainlm');
    pre_net.trainParam.epochs=200;          %最大迭代次数
    pre_.trainParam.lr=0.1;          %学习率
    pre_net.trainParam.goal=0.00001;
    pre_w1=pre_net.iw{1,1}; %提取“输入层-隐藏层”链接权重
    pre_chrom=reshape(pre_w1,1,size(pre_w1,1)*size(pre_w1,2)); %存入染色体
    pre_chrom=[pre_chrom pre_net.b{1}']; %在后面加上阈值
    pre_w2=pre_net.lw{2,1}; %提取“隐藏层-输出层”链接权重
    pre_chrom=[pre_chrom reshape(pre_w2,1,size(pre_w2,1)*size(pre_w2,2))]; %在后面加上“隐藏层-输出层”链接权重
    pre_chrom=[pre_chrom pre_net.b{2}'];
    pre=[pre;pre_chrom];
end
% ran(1,:)=min(pre);
% ran(2,:)=max(pre);
end