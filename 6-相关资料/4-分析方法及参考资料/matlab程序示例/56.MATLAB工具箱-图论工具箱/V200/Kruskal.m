function [out,len]=kruskal(map)
%  [out,len]=kruskal(map)
%  [out,len]=kruskal(map)
%求最小生成树算法,通过kruskal算法求最优树,并给出相应图像. 
%用法:
%	首先输入矩阵: 
%		map为图的邻接矩阵。
%	再用[out,len]=kruskal(map)求最优树
%参数说明
%	map----3列邻接矩阵,每行表示一条边.第一列表示起点,第二列表示终点,第三列表示边长
%	out---输出边阵:[起点 终点]
%	len---输出最优树的总长度
%本算法调用由VC++6.0程序crusal1.c生成的MEX文件kruskal1.dll求得最小生成树,
%	表示无穷大的数值上界(默认10000)
%
%See also DIJKSTRA,LPINT,DP,BNBGUI,BNB18,
%By S. J. Lu 2000

op=map;
op(find(map)==inf)=10000;
[out,len]=krusk(op);
out=out';