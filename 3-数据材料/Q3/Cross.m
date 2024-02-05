function new_chrom=Cross(cross_pro,input_chrom,group_num)
%随机选择两个染色体位置交叉
% cross_pro                   交叉概率
% lenchrom                   染色体的长度，即所有参数的数量
% input_chrom              染色体群,经过选择遗传下来的表现比较好的
% group_num                种群规模
% new_chrom                交叉后的染色体
set_temp_new=[];
for i=1:floor(group_num/2)  %每一轮for循环中，可能会进行一次交叉操作，染色体是随机选择的，交叉位置也是随机选择的，
    p1=input_chrom(2*i-1,:);
    p2=input_chrom(2*i,:);
    if cross_pro>rand
         pick1=randi([2 size(p1,2)-1]);
         pick2=randi([2 size(p1,2)-1]);
         if pick1>pick2
             tt=pick1;
             pick1=pick2;
             pick2=tt;
         end
         set_temp_new=[set_temp_new;[p1(1,1:(pick1-1)) p2(1,pick1:pick2) p1(1,pick2+1:end)]];
         set_temp_new=[set_temp_new;[p2(1,1:(pick1-1)) p1(1,pick1:pick2) p2(1,pick2+1:end)]];
    end
end
new_chrom=[input_chrom;set_temp_new];
end