function y = crnd(pdffun, pdfdef, m, n)
%��������һԪ�����ֲ������
%   y = crnd(pdffun, pdfdef, m, n)������ָ��һԪ�����ֲ����������m��n�С�pdffunΪ�ܶ�
%   �������ʽ��pdfdefΪ�ܶȺ���������ע�⣺pdfdefֻ�����������䣬���ܶȺ���������Ϊ������
%   �䣬Ӧ��ɱȽϴ���������䣬����[-10000,10000]
%
%   example:
%   pdffun = 'x*(x>=0 & x<1)+(2-x)*(x>=1 & x<2)';
%   x = crnd(pdffun, [0 2], 1000, 1);
%   [fp,xp] = ecdf(x);
%   ecdfhist(fp, xp, 20);
%   hold on
%   fplot(pdffun, [0 2], 'r')
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/17 12:10:00 $

fun = vectorize(['(' pdffun ')' '*x']);    % x*f(x)����������
try
    xm = quadl(fun, min(pdfdef), max(pdfdef));    % ����x����ѧ����xm
catch
    xm = mean(pdfdef);    % ���㶨�������ƽ��ֵxm
end

pdffun = vectorize(['(' pdffun ')' '*x/x']);    % x*f(x)/x����������
cdfrnd = rand(m*n, 1);    % ����[0,1]�Ͼ��ȷֲ������
y = zeros(m*n, 1);        % ����0������Ϊ����y�ĳ�ֵ
options = optimset;       % ����һ�����Ƶ������̵Ľṹ�����
options.Display = 'off';  % ����ʾ�м��������
% ͨ��ѭ������ָ��һԪ�����ֲ��������
for i = 1:m*n
    funcdf = @(x)[quadl(pdffun, min(pdfdef), x) - cdfrnd(i)];
    y(i) = fsolve(funcdf, xm, options);
end
y=reshape(y,[m,n]);    % ������y��Ϊ����