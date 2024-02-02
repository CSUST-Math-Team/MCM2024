function stats = reglm(y,X,model,varnames)
% �������Իع������������Իع����
%
%   reglm(y,X)���������Իع�����ķ��������Ͳ������ƽ�������Ա����ʽ��ʾ����Ļ��. ��
%   ��X���Ա����۲�ֵ��������n��p�еľ���. y��������۲�ֵ����������n��1�е�������.
%
%   stats = reglm(y,X)��������һ�������˻ع�������������ͳ�����Ľṹ�����stats.
%
%   stats = reglm(y,X,model)���ÿ�ѡ��model���������ƻع�ģ�͵�����. model��һ���ַ�����
%   ����õ��ַ�������
%       'linear'          ���г����������ģ�ͣ�Ĭ�������
%       'interaction'     ���г����������ͽ������ģ��
%       'quadratic'       ���г����������������ƽ�����ģ��
%       'purequadratic'   ���г�����������ƽ�����ģ��
%
%   stats = reglm(y,X,model,varnames)���ÿ�ѡ��varnames����ָ��������ǩ. varnames
%   �������ַ�������ַ���Ԫ�����飬����ÿ�е��ַ���ÿ��Ԫ�����ַ�����һ�������ı�ǩ��������
%   ����Ԫ����Ӧ��X��������ͬ. Ĭ������£���X1,X2,����Ϊ������ǩ.
%
%   ��:
%   x = [215 250 180 250 180 215 180 215 250 215 215
%       136.5 136.5 136.5 138.5 139.5 138.5 140.5 140.5 140.5 138.5 138.5]';
%   y = [6.2 7.5 4.8 5.1 4.6 4.6 2.8 3.1 4.3 4.9 4.1]';
%   reglm(y,x,'quadratic')
%
%   ------------------------------------���������------------------------------------
%   ������Դ    ���ɶ�            ƽ����             ����             Fֵ          pֵ
%   �ع�       5.0000          15.0277           3.0055          7.6122      0.0219
%   �в�       5.0000           1.9742           0.3948
%   �ܼ�      10.0000          17.0018
%
%         ���������(Root MSE)     0.6284             �ж�ϵ��(R-Square)    0.8839
%   �������ֵ(Dependent Mean)     4.7273        �������ж�ϵ��(Adj R-Sq)    0.7678
%
%   -----------------------------------��������-----------------------------------
%      ����               ����ֵ            ��׼��             tֵ          pֵ
%     ������             30.9428        2011.1117           0.0154      0.9883
%        X1              0.7040           0.6405           1.0992      0.3218
%        X2             -0.8487          29.1537          -0.0291      0.9779
%     X1*X2             -0.0058           0.0044          -1.3132      0.2461
%     X1*X1              0.0003           0.0003           0.8384      0.4400
%     X2*X2              0.0052           0.1055           0.0492      0.9626
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/22 21:41:00 $

if nargin < 2
   error('������Ҫ�����������');
end
p = size(X,2);    % X������������������
if nargin < 3 || isempty(model)
   model = 'linear';    % model������Ĭ��ֵ
end

% ���ɱ�����ǩvarnames
if nargin < 4 || isempty(varnames)
    varname1 = strcat({'X'},num2str([1:p]'));
    varnames = makevarnames(varname1,model);    % Ĭ�ϵı�����ǩ
else
    if ischar(varnames)
        varname1 = cellstr(varnames);
    elseif iscell(varnames)
        varname1 = varnames(:);
    else
        error('varnames �������ַ�������ַ���Ԫ������');
    end
    if size(varname1,1) ~= p
        error('������ǩ����X��������һ��');
    else
        varnames = makevarnames(varname1,model);    % ָ���ı�����ǩ
    end
end

ST = regstats(y,X,model);    % ����regstats�����������Իع���������ؽṹ�����ST
f = ST.fstat;    % F������ؽ��
t = ST.tstat;    % t������ؽ��

% ��ʾ���������
fprintf('\n');
fprintf('------------------------------------���������------------------------------------');
fprintf('\n');
fprintf('%s%7s%15s%15s%15s%12s','������Դ','���ɶ�','ƽ����','����','Fֵ','pֵ');
fprintf('\n');
fmt = '%s%13.4f%17.4f%17.4f%16.4f%12.4f';
fprintf(fmt,'�ع�',f.dfr,f.ssr,f.ssr/f.dfr,f.f,f.pval);
fprintf('\n');
fmt = '%s%13.4f%17.4f%17.4f';
fprintf(fmt,'�в�',f.dfe,f.sse,f.sse/f.dfe);
fprintf('\n');
fmt = '%s%13.4f%17.4f';
fprintf(fmt,'�ܼ�',f.dfe+f.dfr,f.sse+f.ssr);
fprintf('\n');
fprintf('\n');

% ��ʾ�ж�ϵ����ͳ����
fmt = '%22s%15.4f%25s%10.4f';
fprintf(fmt,'���������(Root MSE)',sqrt(ST.mse),'�ж�ϵ��(R-Square)',ST.rsquare);
fprintf('\n');
fprintf(fmt,'�������ֵ(Dependent Mean)',mean(y),'�������ж�ϵ��(Adj R-Sq)',ST.adjrsquare);
fprintf('\n');
fprintf('\n');

% ��ʾ�������Ƽ�t������ؽ��
fprintf('-----------------------------------��������-----------------------------------');
fprintf('\n');
fprintf('%8s%18s%15s%15s%12s','����','����ֵ','��׼��','tֵ','pֵ');
fprintf('\n');
for i = 1:size(t.beta,1)
    if i == 1
        fmt = '%8s%20.4f%17.4f%17.4f%12.4f\n';
        fprintf(fmt,'������',t.beta(i),t.se(i),t.t(i),t.pval(i));
    else
        fmt = '%10s%20.4f%17.4f%17.4f%12.4f\n';
        fprintf(fmt,varnames{i-1},t.beta(i),t.se(i),t.t(i),t.pval(i));
    end
end

if nargout == 1
    stats = ST;    % ����һ�������˻ع�������������ͳ�����Ľṹ�����
end

% -----------------�Ӻ���-----------------------
function varnames = makevarnames(varname1,model)
% ����ָ��ģ�͵ı�����ǩ
p = size(varname1,1);
varname2 = [];
for i = 1:p-1
    varname2 = [varname2;strcat(varname1(i),'*',varname1(i+1:end))];
end
varname3 = strcat(varname1,'*',varname1);
switch model
    case 'linear'
        varnames = varname1;
    case 'interaction'
        varnames = [varname1;varname2];
    case 'quadratic'
        varnames = [varname1;varname2;varname3];
    case 'purequadratic'
        varnames = [varname1;varname3];
end