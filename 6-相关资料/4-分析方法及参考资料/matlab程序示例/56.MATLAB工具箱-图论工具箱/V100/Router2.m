function [L,R]=Router2(D,path,s,t) 
%  [L,R]=Router2(D,path,s,t) 
%���floyd�㷨�ĺ�������,sΪԴ��,tΪ�޵� 
%LΪ����,RΪ·�� 

L=zeros(0,0); 
R=s; 
while 1 
if s==t 
L=fliplr(L); 
L=[0,L]; 
return 
end 
L=[L,D(s,t)]; 
R=[R,path(s,t)]; 
s=path(s,t); 
end
