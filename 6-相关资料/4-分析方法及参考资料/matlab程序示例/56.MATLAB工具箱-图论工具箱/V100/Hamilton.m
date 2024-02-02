function [d,path]=Hamilton(A)
%[d,path]=Hamilton(A)
%clear
%clc
%d=[0 9 inf 3 inf;9 0 2 inf 7;inf 2 0 2 4;3 inf 2 0 inf;inf 7 4 inf 0]

[C,t]=dijkstra(A);
a=length(C);
pd=zeros(a);
o=[]; 
D=[];
for i=1:a
    clear y
    y=0;
    pd(i,i)=1;
    e=sum(pd,2);
    k=[i];
    v=i;
    while e(i,1)
        c=find(pd(i,1:length(pd))==0);
        b=C(v,c(1));
        B=c;
        f=B(1);
        if length(c)~=1
            for x=2:length(c)
                if b>C(v,c(x))
                    b=C(v,c(x));
                    f=B(x);               
                end
            end
            k=[k f];
            y=y+b;            
        else k=[k f];
            y=y+b;
        end
        v=f;
        pd(i,f)=1;
        e=sum(pd,2);          
    end
    y=y+C(f,i);
    D=[D y];
    k=[k i];
   o=[o;k];
end
n1=find(D(1:length(D))==min(D));
cl=o(n1,1:length(o));
%“原来路径为cl”
%用二代换法改进寻找的回路
sum2=[]; 
L=length(cl);
for m1=1:length(n1)   
    flag=1;
    while flag>0
        flag=0;
        for m=1:L-3
            for n=m+2:L-1
                if C(cl(m1,m),cl(m1,n))+C(cl(m1,m+1),cl(m1,n+1))
                    flag=1;
                    cl(m1,m+1:n)=cl(m1,n:-1:m+1);
                end
            end
        end
    end
    sum1=0;
    for i=1:L-1
        sum1=sum1+C(cl(m1,i),cl(m1,i+1));
    end
sum2=[sum2  sum1];
end
%路径的表示
n2=find(sum2(1:length(sum2))==min(sum2));
c2=cl(n2,1:length(cl));
d=min(sum2);
z1={}; 
path1={};
for m2=1:length(n2) 
    for w=1:length(c2)
        z1{m2,w}=num2str(c2(m2,w));
    end
    for w=1:length(c2)-1
        u1=c2(m2,w);
        u2=c2(m2,w+1);  
        z1{m2,w+1}=strrep(z1{m2,w},num2str(c2(m2,w)),t{u1,u2});
    end
    path1{m2}=z1{m2,length(c2)};
end
path=path1;
path=path';
%结果为：
%d =
%   22
%path= 
%  '1-4-3-2-3-5-3-4-1'
%  '2-3-4-1-4-3-5-3-2'
%  '3-2-3-4-1-4-3-5-3'
%  '4-3-2-3-5-3-4-1-4'
%  '5-3-2-3-4-1-4-3-5'