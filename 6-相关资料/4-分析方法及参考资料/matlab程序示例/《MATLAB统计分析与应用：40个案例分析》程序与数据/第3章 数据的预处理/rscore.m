function [R,xmin,xrange] = rscore(x,dim)
%�����һ���任
%   R = rscore(X) ��X���м����һ���任������X������һ��������������ά���顣
%   ��X��һ�����������ر任��������R = (X�Cmin(X))./range(X)����X��һ������
%   ����X��ÿһ�е���Сֵ�ͼ���Ը��н��м����һ���任�����ر任�����R����X��
%   һ����ά���飬����X���׸��ǵ�һά���������Сֵ�ͼ��Ȼ���X���м����һ��
%   �任�����ر任���ά����R.  ����X��һ��1��1��1��4��4ά���飬����X��ǰ��ά��
%   Ϊ��һά�����Ǽ���X�ĵ�4ά�����ϵ���Сֵ�ͼ����X���м����һ���任������
%   ��RҲ��һ��1��1��1��4��4ά���顣
%
%   [R,xmin,xrange] = rscore(X) ������X����Сֵxmin = min(X)�ͼ���xrange = range(X).
%
%   [...] = rscore(X,dim) ��dim����ָ����X���ĸ�ά���м����һ���任������
%   dim = 1����ʾ��X�ĸ��н��м����һ���任��dim = 2����ʾ��X�ĸ��н��м����һ���任��
%
%   ��ο�zscore, min �� range �������÷�.

%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/2 15:58:36 $

if isequal(x,[]), z = []; return; end

if nargin < 2
    % Figure out which dimension to work along.
    dim = find(size(x) ~= 1, 1);
    if isempty(dim), dim = 1; end
end

% Compute X's min and range, and standardize it
xmin = min(x,[],dim);
xrange = range(x,dim);
xrange0 = xrange;
xrange0(xrange0==0) = 1;
R = bsxfun(@minus,x, xmin);
R = bsxfun(@rdivide, R, xrange0);
