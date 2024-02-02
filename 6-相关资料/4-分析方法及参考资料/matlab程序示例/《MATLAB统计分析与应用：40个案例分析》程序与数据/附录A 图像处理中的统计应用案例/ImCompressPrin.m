function  [IMCom, NumPrin] = ImCompressPrin(filename,q)
%�������ɷַ�����ͼ��ѹ��
%
%   ImCompressPrin(filename,q) ��ʾ��ǰq�����ɷֵĵ÷־����ϵ������ָ���ͼ��.
%   �������filename��һ���ɵ��������������ַ���������ָ��ͼƬ�ļ����ļ�������
%   'football.jpg'. ���ͼƬ�ļ�����MATLAB��ǰ�ļ��л�����·���£�Ӧ��filename
%   ��ָ��ͼƬ�ļ�������·��. �������q��һ����������(0,1)�ڵ�ʵ������Ϊ��������
%   ����ָ���ָ�ͼ��ʱ�õ������ɷֵĸ�������Ϊ(0,1)�ڵ�ʵ��������ָ��ͼ��ѹ����
%   �ĵ����������л����q��ֵ�Զ�ȷ���õ������ɷֵĸ���. 
%
%   IMCom = ImCompressPrin(filename,q) �����ǰq�����ɷֵĵ÷־����ϵ�������
%   ����ͼ������IMCom.
%
%   [IMCom, NumPrin] = ImCompressPrin(filename,q) �����ػָ�ͼ��ʱ�õ�������
%   �ֵĸ�����ͼ��ѹ���ȵĵ���. ���������q��һ��(0,1)�ڵ�ʵ��ʱ��NumPrin���õ�
%   �����ɷֵĸ�������q��һ��������ʱ��NumPrin��ͼ��ѹ���ȵĵ���.
%
%   Copyright 2009 xiezhh.
%   $Revision: 1.0.0.0 $  $Date: 2009/10/18 12:20:30 $

% ����һ��ͼƬ������ͼ�����ݵĴ�С
I = imread(filename);
[nrow,ncol,npage] = size(I);
% ȷ��ͼ��ֿ�ĸ���
nrow = floor(nrow/16);
ncol = floor(ncol/16);
% ȷ�������õ����ɷֵĸ���m
n = nrow * ncol;
p = npage*256;
m = floor(n*p/(n+p));
% ����q��ȡֵ��ȷ�����õ����ɷֵĸ���qid
if q > 0 && q < 1
    qid = ceil(m*q); 
elseif q >= 1 && q <= m && round(q) ==q
    qid = q;
else
    error(['q��ȡֵӦΪ(0,1)�ڵ����򲻳���', num2str(m),'��������'])
end

flag = npage == 3;  % ���ͼ���ǩ����Ϊ���ͼ��flag = 1
% ��I����������������16������������I�Ĵ�С���е���
I = imresize(I,[16*nrow,16*ncol]);
% ��Iת��Ϊȡֵ����0��1֮���˫��������
I = double(I)/255;
% ��ʾԭʼͼ��
figure(1)
subplot(1,2,1)
imshow(I,[])
% ��ԭʼͼ��ֳ�nrow��ncol��16��16��С��. I_blockΪnrow��ncol��Ԫ������
if flag
    I_block = mat2cell(I,16*ones(1,nrow),16*ones(1,ncol),npage);
else
    I_block = mat2cell(I,16*ones(1,nrow),16*ones(1,ncol));
end
% ��I_blockתΪ16��16��npage��(nrow��ncol)������
x = cat(4,I_block{:});
% �� x תΪ(nrow��ncol)�У�(16��16��npage)�еľ���
x = reshape(x,[16*16*npage,nrow*ncol])';
% ����pcares�����ؽ����� x ������ xpr
[resid,xpr] = pcares(x,qid);
% �Ѿ���xprתΪ(nrow*ncol)��1��Ԫ������
xpr = mat2cell(xpr,ones(1,nrow*ncol));
% ��xpr��ÿһ��Ԫ��ת��16��16��npage������
xpr = cellfun(@(x)reshape(x,[16,16,npage]),xpr,'UniformOutput',0);
% �ı�Ԫ������xpr����״��ʹ֮��Ϊnrow��ncol��Ԫ������
xpr = reshape(xpr,[nrow,ncol]);
% ��Ԫ������xprתΪnrow��ncol��npage�����飬�õ��ָ���ͼ������I
I = cell2mat(xpr);
% ��ʾ��ǰqid�����ɷֵĵ÷־����ϵ������ָ���ͼ��
subplot(1,2,2)
imshow(I,[])
% ����ָ���ͼ�����ݡ��õ������ɷָ�����ͼ��ѹ���ȵĵ���
if nargout > 0
    IMCom = I;
    if q >= 1
        NumPrin = qid/m;
    else
        NumPrin = qid;
    end
end