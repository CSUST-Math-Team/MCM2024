%--------------------------------------------------------------------------
%           ����һ��Microsoft Excel���������ı䵥Ԫ��A1�ı߿���ɫ
%--------------------------------------------------------------------------

% ����һ��Microsoft Excel�����������ؾ��Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % ���÷�����Ϊ�ɼ�״̬
Workbook = Excel.Workbooks.Add;    % �½�һ������������������
Sheet1 = Workbook.Sheets.Item(1);    % ���ص�1��������ľ��Sheet1

% ͨ��ѭ���ı䵥Ԫ��A1�ı߿���ɫ
for i = 0:56
    Sheet1.Range('A1').Borders.ColorIndex = i;
    pause(1);
end