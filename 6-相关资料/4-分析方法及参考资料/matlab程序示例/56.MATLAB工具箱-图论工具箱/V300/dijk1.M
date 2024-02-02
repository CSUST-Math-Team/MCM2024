function [p,v]=dijk1(map,u1,u2)
%求网络最短路径的dijkstra算法
%用法:
%	首先输入矩阵: 
%		map=[起点1 终点1 边长1;起点2 终点2  边长2;............;起点n 终点n 边长n]
%		和u1,u2
%  注意：这里map为无向图。
%	再用[p,v]=dijkstra(map,u1,u2)求最短路径
%参数说明
%	map----3列邻接矩阵,每行表示一条边.
%         第一列表示起点,第二列表示终点,第三列表示边长
%	u1---所求路径起点
%	u2---所求路径终点
%   p---输出最短路径
%   v---最短路径的总长度
%
%
%例如  
%		clear;map=[1 2 30;2 4 5;2 5 50;3 2 6;4 3 1;1 4 20;1 5 3]
%		[p,v]=dijkstra(map,2,5)
%
%本算法调用由VC++6.0程序dijk.c生成的MEX文件dijk.dll求得最短路径
%	表示无穷大的数值上界(默认10000)
%
%See also KRUSKAL,LPINT,DP,BNBGUI,BNB18,

%By W. Z. Li, 2000

l=map;
l(find(l==inf))=10000;
[p,v]=dijk(l,u1,u2);
p=p(p~=0); 


 
