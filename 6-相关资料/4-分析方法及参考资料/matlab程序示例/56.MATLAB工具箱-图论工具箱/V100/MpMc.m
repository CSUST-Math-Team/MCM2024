function  [Mm,mc,Mmr]=MpMc(a,c)
%  [Mm,mc,Mmr]=MpMc(a,c)
%计算最小费用最大流MATLAB源代码,文件名为mp_mc.m

A=a; %各路径最大承载流量矩阵
C=c; %各路径花费矩阵
Mm=0; %初始可行流设为零
mc=0; %最小花费变量
mcr=0;
mrd=0;
n=0;
while mrd~=inf %一直叠代到以花费为权值找不到最短路径
     for i=1:(size(mcr',1)-1)
           if a(mcr(i),mcr(i+1))==inf
                 ta=A(mcr(i+1),mcr(i))-a(mcr(i+1),mcr(i));
           else
                 ta=a(mcr(i),mcr(i+1));
           end
           n=min(ta,n); %将最短路径上的最小允许流量提取出来
     end
     for i=1:(size(mcr',1)-1)
           if a(mcr(i),mcr(i+1))==inf
                 a(mcr(i+1),mcr(i))=a(mcr(i+1),mcr(i))+n;
           else
                 a(mcr(i),mcr(i+1))=a(mcr(i),mcr(i+1))-n;
           end
     end
     Mm=Mm+n; %将每次叠代后增加的流量累加，叠代完成时就得到最大流量
     for i=1:size(a,1)
           for j=1:size(a',1)
                 if i~=j&a(i,j)~=inf
                       if a(i,j)==A(i,j) %零流弧
                             c(j,i)=inf;
                             c(i,j)=C(i,j);
                       elseif a(i,j)==0 %饱合弧
                             c(i,j)=inf;
                             c(j,i)=C(j,i);
                       elseif a(i,j)~=0 %非饱合弧
                             c(j,i)=C(j,i);
                             c(i,j)=C(i,j);
                       end
                 end
           end
     end
     [mcr,mrd]=floyd_mr(c) %进行叠代，得到以花费为权值的最短路径矩阵(mcr)和数值(mrd)
     n=inf;
end
%下面是计算最小花费的数值
for i=1:size(A,1)
     for j=1:size(A',1)
           if A(i,j)==inf
                 A(i,j)=0;
           end
           if a(i,j)==inf
                 a(i,j)=0;
           end
     end
end
Mmr=A-a; 
%将剩余空闲的流量减掉就得到了路径上的实际流量，行列交点处的非零数值就是两点间路径的实际流量
for i=1:size(Mmr,1)
     for j=1:size(Mmr',1)
           if Mmr(i,j)~=0
                 mc=mc+Mmr(i,j)*C(i,j); %最小花费为累加各条路径实际流量与其单位流量花费的乘积
           end
     end
end

function[mr,mrd]=floyd_mr(a)
%利用福得算法计算最短路径MATLAB源代码,文件名为floyd_mr.m
n=size(a,1);
[D,R]=floyd(a); %通过福德算法得到距离矩阵(D)和路径矩阵(R)
mrd=D(1,n); %提取从起点1到终点n的最短距离
rd=R(1,n); %提取从起点1开始沿最短路径上下一个点的编号(rd)
mr=[1,rd]; %从起点1开始沿最短路径到rd点的最短路径

while rd~=n %通过循环将最短路径依次提取出来，直到rd点就是最后一个点
     mr=[mr,R(rd,n)];
     rd=R(rd,n);
end

function[D,R]=floyd(a)
%福得算法MATLAB源代码,文件名为floyd.m

n=size(a,1);
D=a;
for i=1:n
  for j=1:n
  R(i,j)=j;
  end
end
R;

for k=1:n
  for i=1:n
    for j=1:n
      if D(i,k)+D(k,j)<D(i,j)
        D(i,j)=D(i,k)+D(k,j);
        R(i,j)=R(i,k);
      end
    end
  end
  k;
  D;
  R;
end
M=D(1,n);
