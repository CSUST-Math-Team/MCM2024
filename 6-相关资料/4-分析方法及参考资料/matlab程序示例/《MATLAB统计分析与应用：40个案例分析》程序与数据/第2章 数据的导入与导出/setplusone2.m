function [DataRange, customdata] = setplusone2(DataRange)
for k = 1:DataRange.Count
   DataRange.Value{k} = DataRange.Value{k}+1;    % ����Ԫ��ȡֵ��1
   customdata(k) = DataRange.Value{k};    % �ѵ�Ԫ��ȡֵ��������customdata
end
% ������ѡ�����е�Ԫ������������������customdata��Ϊ����
customdata = reshape(customdata, DataRange.Rows.Count, DataRange.Columns.Count);