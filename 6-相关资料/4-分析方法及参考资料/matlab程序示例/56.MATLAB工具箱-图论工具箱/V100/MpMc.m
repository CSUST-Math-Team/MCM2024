function  [Mm,mc,Mmr]=MpMc(a,c)
%  [Mm,mc,Mmr]=MpMc(a,c)
%������С���������MATLABԴ����,�ļ���Ϊmp_mc.m

A=a; %��·����������������
C=c; %��·�����Ѿ���
Mm=0; %��ʼ��������Ϊ��
mc=0; %��С���ѱ���
mcr=0;
mrd=0;
n=0;
while mrd~=inf %һֱ�������Ի���ΪȨֵ�Ҳ������·��
     for i=1:(size(mcr',1)-1)
           if a(mcr(i),mcr(i+1))==inf
                 ta=A(mcr(i+1),mcr(i))-a(mcr(i+1),mcr(i));
           else
                 ta=a(mcr(i),mcr(i+1));
           end
           n=min(ta,n); %�����·���ϵ���С����������ȡ����
     end
     for i=1:(size(mcr',1)-1)
           if a(mcr(i),mcr(i+1))==inf
                 a(mcr(i+1),mcr(i))=a(mcr(i+1),mcr(i))+n;
           else
                 a(mcr(i),mcr(i+1))=a(mcr(i),mcr(i+1))-n;
           end
     end
     Mm=Mm+n; %��ÿ�ε��������ӵ������ۼӣ��������ʱ�͵õ��������
     for i=1:size(a,1)
           for j=1:size(a',1)
                 if i~=j&a(i,j)~=inf
                       if a(i,j)==A(i,j) %������
                             c(j,i)=inf;
                             c(i,j)=C(i,j);
                       elseif a(i,j)==0 %���ϻ�
                             c(i,j)=inf;
                             c(j,i)=C(j,i);
                       elseif a(i,j)~=0 %�Ǳ��ϻ�
                             c(j,i)=C(j,i);
                             c(i,j)=C(i,j);
                       end
                 end
           end
     end
     [mcr,mrd]=floyd_mr(c) %���е������õ��Ի���ΪȨֵ�����·������(mcr)����ֵ(mrd)
     n=inf;
end
%�����Ǽ�����С���ѵ���ֵ
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
%��ʣ����е����������͵õ���·���ϵ�ʵ�����������н��㴦�ķ�����ֵ���������·����ʵ������
for i=1:size(Mmr,1)
     for j=1:size(Mmr',1)
           if Mmr(i,j)~=0
                 mc=mc+Mmr(i,j)*C(i,j); %��С����Ϊ�ۼӸ���·��ʵ���������䵥λ�������ѵĳ˻�
           end
     end
end

function[mr,mrd]=floyd_mr(a)
%���ø����㷨�������·��MATLABԴ����,�ļ���Ϊfloyd_mr.m
n=size(a,1);
[D,R]=floyd(a); %ͨ�������㷨�õ��������(D)��·������(R)
mrd=D(1,n); %��ȡ�����1���յ�n����̾���
rd=R(1,n); %��ȡ�����1��ʼ�����·������һ����ı��(rd)
mr=[1,rd]; %�����1��ʼ�����·����rd������·��

while rd~=n %ͨ��ѭ�������·��������ȡ������ֱ��rd��������һ����
     mr=[mr,R(rd,n)];
     rd=R(rd,n);
end

function[D,R]=floyd(a)
%�����㷨MATLABԴ����,�ļ���Ϊfloyd.m

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
