function [D,path]=Floyd2(a)
%  [D,path]=Floyd2(a)
%floyd�㷨ͨ�ó�������aΪ��Ȩ�ڽӾ��� 
%���Ϊ�������D,�����·������path 

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
