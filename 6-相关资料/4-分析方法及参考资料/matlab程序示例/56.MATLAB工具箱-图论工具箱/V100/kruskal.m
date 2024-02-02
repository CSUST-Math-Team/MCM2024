function c1=kruskal(c,v0)
%  c1=kruskal(c,v0)
%最小生成树kruskal原程序
%c:原图的邻接矩阵
%v0:根节点
%c1:最小生成树的邻接矩阵

[X,Y]=size(c);
if X~=Y
    error('输入必须为方阵')
end
if v0>length(c(1,:))
    error('不存在该顶点')
end
N=length(c(:,1));
con=0;
c(find(c==0))=inf;
c1=zeros(N,N);
comp=zeros(N,N);
comp(:,1)=[1:N]';
while con<N-1
    clear min0;
  min0=min(min(c));
  [x,y]=find(c==min0);
  X=x(1);
  Y=y(1);
  c(X,Y)=inf;
  [i1,j1]=find(comp==X);
  [i2,j2]=find(comp==Y);
  if i1~=i2
      l1=length(find(comp(i1,:)~=0));
      l2=length(find(comp(i2,:)~=0));
      comp(i1,[l1+1:l1+l2])=comp(i2,[1:l2]);
      comp(i2,:)=0;
      c1(X,Y)=min0;
      con=con+1;
  end
end
