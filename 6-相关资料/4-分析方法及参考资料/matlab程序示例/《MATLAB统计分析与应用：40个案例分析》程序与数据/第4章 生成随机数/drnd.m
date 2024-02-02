function out = drnd(p,n)
% out=drnd(p,n)
% copyright:rocwoods
% p is the probability distribution matrix;
% n is the number of the samples you want to generate;
% example
% x_p = [1 2 3;0.1 0.4 0.5];
% out = drnd(x_p,10)
%=================

a = cumsum(p(2,: ));    % �����ۻ����ʷֲ�
b = rand(n,1);          % ����[0,1]�Ͼ��ȷֲ������
out = zeros(1,n);       % ����0������Ϊ����out�ĳ�ֵ
% ͨ��ѭ������ָ����ɢ�ֲ��������
for k = 1:n
    c = find(a < b(k));
    if isempty(c)
        out(k) = p(1,1);
    else
        out(k) = p(1,c(end)+1);
    end
end