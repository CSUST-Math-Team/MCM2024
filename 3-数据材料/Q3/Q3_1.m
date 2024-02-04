clc
clear
data=xlsread('统计波动用.xlsx');
game=1;
temp=2;
for i=1:size(data,1)
    if data(i,1)==game %如果还是同一局
        if data(i,2)==temp %如果不是拐点
            data(i,3)=0;
        else %如果是拐点
            data(i,3)=1;
            temp=data(i,2);
        end
    else %换局了
        data(i,3)=0;
        temp=data(i,2);
        game=data(i,1);
    end
end