function new_chrom=Mutation(mutation_pro,lenchrom,input_chrom,group_num,limit)
% 本函数完成变异操作
% mutation_pro           变异概率
% lenchrom                 染色体长度
% input_chrom   输入交叉过后的染色体
% group_num              种群规模
% iter_num             最大迭代次数
% limit                  每个个体的上限和下限
% num                   当前迭代次数
% new_chrom           变异后的染色体
set_new=[];
for i=1:group_num   %每一轮for循环中，可能会进行一次变异操作，染色体是随机选择的，变异位置也是随机选择的，
    %但该轮for循环中是否进行变异操作则由变异概率决定（continue控制）
    % 随机选择一个染色体进行变异
    index=ceil(rand*group_num);
    % 变异概率决定该轮循环是否进行变异
    if rand>mutation_pro
        continue;
    end
        % 变异位置
        temp_new=input_chrom(index,:);
        mu_times=size(input_chrom,2)/10; %计算要变异的点位数
        for times=1:mu_times
            pos=ceil(rand*sum(lenchrom));  %随机选择了染色体变异的位置，即选择了第pos个变量进行变异
            temp_new(1,pos)=randi([floor(limit(pos,1)) ceil(limit(pos,2))])+rand;
        end
    set_new=[set_new;temp_new];
end
new_chrom=[input_chrom;set_new];