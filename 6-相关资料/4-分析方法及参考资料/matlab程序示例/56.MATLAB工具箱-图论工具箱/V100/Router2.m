function [L,R]=Router2(D,path,s,t) 
%  [L,R]=Router2(D,path,s,t) 
%配合floyd算法的后续程序,s为源点,t为宿点 
%L为长度,R为路由 

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
