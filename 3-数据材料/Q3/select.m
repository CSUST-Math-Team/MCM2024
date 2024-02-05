function [new_chrom,new_fitness]=select(input_chrom,fitness_group,group_num)
% 用轮盘赌在原来的函数里选择
% fitness_group    种群信息
% group_num     种群规模
% newgroup        选择后的新种群
%求适应度值倒数  
fitness1=10./fitness_group; %individuals.fitness为个体适应度值
%个体选择概率
sumfitness=sum(fitness1);
sumf=fitness1./sumfitness;
%采用轮盘赌法选择新个体
index=find(sumf==max(sumf));
index=index(1); %先保留最优个体
while(1)   %group_num为种群数
    pick=rand;
    temp_sum=0;
   for j=1:size(sumf,2)   
       temp_sum=temp_sum+sumf(1,j);
       if j==size(sumf,2)||sumf(1,1)>=pick||(pick>=temp_sum&&pick<=temp_sum+sumf(1,j+1))
           index=[index j];
           break
       end
   end
   [~,c]=unique(index','rows');
   if size(c,1)<size(index,2)
       index(:,end)=[];
   end
   
   if size(index,2) >= group_num %判断是否存够了
        break
   end
end
%新种群
new_chrom=input_chrom(index,:);   
new_fitness=fitness_group(index);
end