function c1=kruskal(c,v0)
%  c1=kruskal(c,v0)
%��С������kruskalԭ����
%c:ԭͼ���ڽӾ���
%v0:���ڵ�
%c1:��С���������ڽӾ���

[X,Y]=size(c);
if X~=Y
    error('�������Ϊ����')
end
if v0>length(c(1,:))
    error('�����ڸö���')
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
