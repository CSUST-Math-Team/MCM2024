function [p,v]=ShortstPath(map,u1,u2,style)
switch style
    case '1'
        [p,v]=dijk1(map,u1,u2);
    case '2'
        if(u2~=length(map))
            disp('error:The u2 is the vertexes'' number of graph!');
            return;
        end
        [p,v]=dijk2(map,u1,u2);%此函数求点到其它各点的最短路径。
% 图与网络论中求最短路径的Dijkstra算法M函数
%格式[S,D]=minroute(i,m,W)
% i为最短路径的起始点，m为图顶点数，W为图的带权邻接矩阵，
%不构成边的两顶点之间的权用inf表示。显示结果为：S的每一列从上到下记录了从始点到终点的最短路径所经顶点的序号；
% D是一行向量，记录了S中所示路径大小；
    otherwise
         disp('error:The style is only alowed ''1'' or ''2''!' );
end
