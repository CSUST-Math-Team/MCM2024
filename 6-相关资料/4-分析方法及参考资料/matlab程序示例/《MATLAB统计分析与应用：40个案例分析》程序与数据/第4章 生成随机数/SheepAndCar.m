function  p = SheepAndCar(n)
%   p = SheepAndCar(n)���������ؿ��巽���������������⣬������߸���ѡ��֮��
%   Ӯ�������ĸ���p. �����n����������������������ʾ��������Ĵ�����
%   
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2010/2/20 20:51:00 $
   
for i = 1:length(n)
    x = randsample(3,n(i),'true');  % �������
    p(i) = sum(x~=3)/n(i);  % ���ʵ�ģ��ֵ
end