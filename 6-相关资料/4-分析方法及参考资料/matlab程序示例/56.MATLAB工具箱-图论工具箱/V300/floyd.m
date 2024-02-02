function [D,R]=floyd(A) 
%用floyd算法实现求任意两点之间的最短路程。可以有负权 
%参数D为连通图的权矩阵 
% A=[0   2   8   1  inf    inf   inf   inf 
%    2   0   6   inf  1    inf   inf   inf 
%    8   6   0   7    5     1    2     inf 
%    1  inf  7   0   inf   inf   9     inf 
 % inf  1   5   inf  0     3    inf    8 
 % inf inf  1   inf  3     0    4      6 
 % inf inf  2   9   inf    4    0      3 
 % inf inf inf  inf  8     6    3      0]; 
D=A;n=length(D); 
for i=1:n 
    for j=1:n   
        R(i,j)=i;%赋路径初值 
    end 
end 
for k=1:n  
    for i=1:n 
        for j=1:n  
            if D(i,k)+D(k,j)






