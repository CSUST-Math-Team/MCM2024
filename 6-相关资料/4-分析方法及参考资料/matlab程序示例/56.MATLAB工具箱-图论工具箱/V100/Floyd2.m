function [D,path]=Floyd2(a)
%  [D,path]=Floyd2(a)
%floyd算法通用程序，输入a为赋权邻接矩阵 
%输出为距离矩阵D,和最短路径矩阵path 

n=size(a,1);
D=a;
path=zeros(n,n);
for i=1:n
    for j=1:n
        if D(i,j)~=inf
            path(i,j)=j;
        end
    end
end
for k=1:n
    for i=1:n
        for j=1:n
            if D(i,k)+D(k,j)<D(i,j)
                D(i,j)=D(i,k)+D(k,j);
                path(i,j)=path(i,k);
            end
        end
    end
end
