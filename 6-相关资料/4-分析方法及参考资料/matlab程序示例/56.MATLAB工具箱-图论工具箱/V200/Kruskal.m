function [out,len]=kruskal(map)
%  [out,len]=kruskal(map)
%  [out,len]=kruskal(map)
%����С�������㷨,ͨ��kruskal�㷨��������,��������Ӧͼ��. 
%�÷�:
%	�����������: 
%		mapΪͼ���ڽӾ���
%	����[out,len]=kruskal(map)��������
%����˵��
%	map----3���ڽӾ���,ÿ�б�ʾһ����.��һ�б�ʾ���,�ڶ��б�ʾ�յ�,�����б�ʾ�߳�
%	out---�������:[��� �յ�]
%	len---������������ܳ���
%���㷨������VC++6.0����crusal1.c���ɵ�MEX�ļ�kruskal1.dll�����С������,
%	��ʾ��������ֵ�Ͻ�(Ĭ��10000)
%
%See also DIJKSTRA,LPINT,DP,BNBGUI,BNB18,
%By S. J. Lu 2000

op=map;
op(find(map)==inf)=10000;
[out,len]=krusk(op);
out=out';