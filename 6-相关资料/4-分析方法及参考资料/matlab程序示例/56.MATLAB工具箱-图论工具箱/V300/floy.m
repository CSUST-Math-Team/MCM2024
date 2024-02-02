%floyd.m
%采用floyd算法计算图a中每对顶点最短路
%d是矩离矩阵
%r是路由矩阵
function [d,r]=floy(a)
n=size(a,1);
d=a;
for i=1:n
    for j=1:n
        r(i,j)=j;
    end 
end 
r;
for k=1:n
    for i=1:n
        for j=1:n
            if d(i,k)+d(k,j)<d(i,j)
                d(i,j)=d(i,k)+d(k,j);
                r(i,j)=r(i,k);
            end
        end
    end
    k;
    d;
    r;
end