function [p,v]=ShortstPath(map,u1,u2,style)
switch style
    case '1'
        [p,v]=dijk1(map,u1,u2);
    case '2'
        if(u2~=length(map))
            disp('error:The u2 is the vertexes'' number of graph!');
            return;
        end
        [p,v]=dijk2(map,u1,u2);%�˺�����㵽������������·����
% ͼ���������������·����Dijkstra�㷨M����
%��ʽ[S,D]=minroute(i,m,W)
% iΪ���·������ʼ�㣬mΪͼ��������WΪͼ�Ĵ�Ȩ�ڽӾ���
%�����ɱߵ�������֮���Ȩ��inf��ʾ����ʾ���Ϊ��S��ÿһ�д��ϵ��¼�¼�˴�ʼ�㵽�յ�����·�������������ţ�
% D��һ����������¼��S����ʾ·����С��
    otherwise
         disp('error:The style is only alowed ''1'' or ''2''!' );
end
