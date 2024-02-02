function f=Floyd(w)
%floyd.m
%  [d,r]=floy(a)
%采用floyd算法计算图a中每对顶点最短路
%d是矩离矩阵
%r是路由矩阵

n=length(w);
d{1}=w;
for i=2:n
    for j=1:n
        for k=1:n
            d{i}(j,k)=min(d{i-1}(j,:)+w(:,k)');
        end
    end
end
t=zeros(n,n);
for i=1:n
    for j=1:n
        m=inf;
        for k=1:n
            if d{k}(i,j)<=m
                m=d{k}(i,j);
            end
        end
        t(i,j)=m;
    end
end
f=t;