function [d,r]=Floyd(a)
%floyd�㷨����ͼa��ÿ�Զ������·
%  [d,r]=Floyd(a)
%����floyd�㷨����ͼa��ÿ�Զ������·
%d�Ǿ������
%r��·�ɾ���

n=size(a,1);
d=a;
for i=1:n
    for j=1:n
        r(i,j)=j;
    end 
end 

for k=1:n
    for i=1:n
        for j=1:n
            if d(i,k)+d(k,j)<d(i,j)
                d(i,j)=d(i,k)+d(k,j);
                r(i,j)=r(i,k);
            end 
        end 
    end
end
