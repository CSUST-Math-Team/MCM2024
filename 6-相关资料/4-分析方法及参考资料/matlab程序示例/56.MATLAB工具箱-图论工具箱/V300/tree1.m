function [T,sum]=tree1(A) 
%求连通图的最小生成树 
%适用于无向图 
%A=[0  8  11 1  5  2 
%   8  0  6  12 7  3 
%   11 6  0  9  10 4 
%   1  12 9  0  3  5 
%   5  7  10 3  0  6 
%   2  3  4  5  6  0]; 
n=length(A); 
k=1; 
for i=1:n-1 
    for j=i+1:n 
        if A(i,j)>0 
            x(k)=A(i,j); 
            u(k)=i;%给出相应的边的端点的标号，标号与下标一样 
            v(k)=j; 
            k=k+1; 
        end 
    end 
end 
k=k-1;%边数 
for i=1:k-1 
    for j=i+1:k%按权从小到达排列边，相应的端点与标号跟着边移动 
        if x(j)






