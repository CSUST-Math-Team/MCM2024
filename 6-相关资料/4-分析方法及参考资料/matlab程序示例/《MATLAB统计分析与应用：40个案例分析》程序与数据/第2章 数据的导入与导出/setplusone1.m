function  DataRange = setplusone1(DataRange)
for k = 1:DataRange.Count
   DataRange.Value{k} = DataRange.Value{k}+1;    % ����Ԫ��ȡֵ��1
end