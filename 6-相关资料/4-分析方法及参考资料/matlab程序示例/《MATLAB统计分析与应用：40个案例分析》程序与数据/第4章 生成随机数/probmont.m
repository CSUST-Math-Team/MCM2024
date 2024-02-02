function [p0,p] = probmont(n,m,N)
%   [p0,p] = probmont(n,m,N)����n���򣬴����зŻص������ȡ m �Σ���ÿ������
%   ��ȡ�������۸���p0�����ؿ���ģ�����p.�������NΪ���ģ�����.

% ���������mС���������nʱ�����۸��ʺ�ģ����ʾ�Ϊ0
if n > m
    p0 = 0;  % ���۸���
    p = 0;  % ģ�����
    return;
end
i = 0:n;  % ����һ������
% �������۸���
p0 = sum((-1).^i*factorial(n)./(factorial(i).*factorial(n-i)).*(1-i/n).^(m));

num = 0;
x = 0;
% ����ģ�����
for i = 1:N
    x = randsample(n,m,'true');  % �зŻ��������
    % ���n���������鵽������������ֵ����1
    if numel(unique(x)) == n
        num = num + 1;
    end
end
p = num/N;  % ģ�����