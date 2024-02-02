%--------------------------------------------------------------------------
%               ����һ��Microsoft Excel������������ͼ1-12
%--------------------------------------------------------------------------

% ����һ��Microsoft Excel�����������ؾ��Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % ���÷�����Ϊ�ɼ�״̬
Workbook = Excel.Workbooks.Add;    % �½�һ������������������
Sheet1 = Workbook.Sheets.Item(1);    % ���ص�1��������ľ��Sheet1
% ����Ԫ������Tabhead
Tabhead = {'��ʽ','LineStyle','Weight','��ʽ','LineStyle','Weight'};
Sheet1.Range('A1:F1').Value = Tabhead;    % �ڵ�Ԫ��A1��F1��������������
Sheet1.Range('A2').Value = '��';    % �ڵ�Ԫ��A2��������������
% ͨ��ѭ������ͼ1-12
for j = 1:3:4
    for i=2:8
        Sheet1.Cells.Item((i-1)*256+j).Borders.Item(4).Linestyle = i-2+7*(j-1)/3;
        Weight = Sheet1.Cells.Item((i-1)*256 + j).Borders.Item(4).Weight;
        Sheet1.Cells.Item((i-1)*256+j).Borders.Item(4).ColorIndex = 1;
        Sheet1.Cells.Item((i-1)*256+j+1).Value = i-2+7*(j-1)/3;
        Sheet1.Cells.Item((i-1)*256+j+1).HorizontalAlignment = 2;     
        Sheet1.Cells.Item((i-1)*256+j+2).Value = Weight;
        Sheet1.Cells.Item((i-1)*256+j+2).HorizontalAlignment = 2;
    end
end