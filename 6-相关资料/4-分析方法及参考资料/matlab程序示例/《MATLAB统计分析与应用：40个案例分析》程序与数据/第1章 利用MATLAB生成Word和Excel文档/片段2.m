%--------------------------------------------------------------------------
%               ����һ��Microsoft Excel������������ͼ1-11
%--------------------------------------------------------------------------

% ����һ��Microsoft Excel�����������ؾ��Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % ���÷�����Ϊ�ɼ�״̬
Workbook = Excel.Workbooks.Add;    % �½�һ������������������
Sheet1 = Workbook.Sheets.Item(1);    % ���ص�1��������ľ��Sheet1
% ͨ��ѭ������ͼ1-11
for j=1:2:7
    for i=1:14
        Sheet1.Cells.Item((i-1)*256 + j).Interior.ColorIndex = i + 14*(j-1)/2;
        Sheet1.Cells.Item((i-1)*256 + j + 1).Value = i + 14*(j-1)/2;
        Sheet1.Cells.Item((i-1)*256 + j + 1).HorizontalAlignment = 2;
    end
end