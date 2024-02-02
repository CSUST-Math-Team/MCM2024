function ceshi_Excel
%����MATLAB����Excel�ĵ�
%   ceshi_Excel
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/14 20:40:00 $

% �趨����Excel�ļ�����·��
filespec_user = [pwd '\����.xls'];

% �ж�Excel�Ƿ��Ѿ��򿪣����Ѵ򿪣����ڴ򿪵�Excel�н��в���������ʹ�Excel
try
    % ��Excel�������Ѿ��򿪣���������Excel
    Excel = actxGetRunningServer('Excel.Application');
catch
    % ����һ��Microsoft Excel�����������ؾ��Excel
    Excel = actxserver('Excel.Application'); 
end;

% ����Excel������Ϊ�ɼ�״̬
Excel.Visible = 1;    % set(Excel, 'Visible', 1); 

% �������ļ����ڣ��򿪸ò����ļ��������½�һ���������������棬�ļ���Ϊ����.Excel
if exist(filespec_user,'file'); 
    Workbook = Excel.Workbooks.Open(filespec_user);
    % Workbook = invoke(Excel.Workbooks,'Open',filespec_user);
else
    Workbook = Excel.Workbooks.Add;
    % Workbook = invoke(Excel.Workbooks, 'Add');
    Workbook.SaveAs(filespec_user);
end

% ���ص�ǰ��������
Sheets = Excel.ActiveWorkbook.Sheets;    % Sheets = Workbook.Sheets;
Sheet1 = Sheets.Item(1);    % ���ص�1�������
Sheet1.Activate;    % �����1�����

% ҳ������
Sheet1.PageSetup.TopMargin = 60;       % �ϱ߾�60��
Sheet1.PageSetup.BottomMargin = 45;    % �±߾�45��
Sheet1.PageSetup.LeftMargin = 45;      % ��߾�45��
Sheet1.PageSetup.RightMargin = 45;     % �ұ߾�45��

% �����иߺ��п�
% �����и�����RowHeight
RowHeight = [26,22,15,29,37,29,29,25,25,36,280,31,40,29,15,24]';
% ����Range���󣨴�A1��A16�����и�
Sheet1.Range('A1:A16').RowHeight = RowHeight;
% ����Range���󣨴�A1��H1�����п�
Sheet1.Range('A1:H1').ColumnWidth = [9,15,9,9,9,9,9,9];

% �ϲ���Ԫ��
Sheet1.Range('A1:H1').MergeCells = 1;
Sheet1.Range('A2:H2').MergeCells = 1;
Sheet1.Range('A8:A9').MergeCells = 1;
Sheet1.Range('B8:D8').MergeCells = 1;
Sheet1.Range('E8:H8').MergeCells = 1;
Sheet1.Range('B9:D9').MergeCells = 1;
Sheet1.Range('E9:H9').MergeCells = 1;
Sheet1.Range('A10:H10').MergeCells = 1;
Sheet1.Range('A11:H11').MergeCells = 1;
Sheet1.Range('A12:H12').MergeCells = 1;
Sheet1.Range('A13:H13').MergeCells = 1;
Sheet1.Range('A14:H14').MergeCells = 1;
Sheet1.Range('D16:H16').MergeCells = 1;

% ���õ�Ԫ��ı߿�
Sheet1.Range('A4:H14').Borders.Weight = 3;
Sheet1.Range('A10:H12').Borders.Item(3).Linestyle = 0;
Sheet1.Range('A10:H12').Borders.Item(4).Linestyle = 0;
Sheet1.Range('A13:H13').Borders.Item(4).Linestyle = 0;
Sheet1.Range('A14:H14').Borders.Item(3).Linestyle = 0;

% ���õ�Ԫ����뷽ʽ
Sheet1.Range('A1:H9').HorizontalAlignment = 3;
Sheet1.Range('A4:A9').HorizontalAlignment = 6;
Sheet1.Range('C4:C7').HorizontalAlignment = 6;
Sheet1.Range('E4:E7').HorizontalAlignment = 6;
Sheet1.Range('G4:G7').HorizontalAlignment = 6;
Sheet1.Range('A10:H10').HorizontalAlignment = 6;
Sheet1.Range('A11:H11').HorizontalAlignment = 6;    % -4130
Sheet1.Range('A11:H11').VerticalAlignment = 1;
Sheet1.Range('A12:H12').HorizontalAlignment = 4;
Sheet1.Range('A13:H13').VerticalAlignment = 1;
Sheet1.Range('A14:H14').HorizontalAlignment = 4;
Sheet1.Range('D16:H16').HorizontalAlignment = 4;

% д�뵥Ԫ������
Sheet1.Range('A1').Value = '��  ��  ��  ��';
Sheet1.Range('A2').Value = '�� 2009  ��  2010   ѧ�� ��һѧ�ڣ�';
Sheet1.Range('A4:H4').Value = {'�γ�����','','�γ̺�',...
    '','�ον�ʦѧԺ','','�ον�ʦ',''};
Sheet1.Range('A5:H5').Value = {'�ڿΰ༶','','��������',...
    '','Ӧ������','','ʵ������',''};
Sheet1.Range('A6:H6').Value = {'����ʽ','','�ľ�ʽ',...
    '','ѡ���Ծ�A/B','','����ʱ��',''};
Sheet1.Range('A7:H7').Value = {'���Է�ʽ','','ƽ����',...
    '','����������','','������',''};
Sheet1.Range('A8').Value = '�ɼ��ֲ�';
Sheet1.Range('B8').Value = '90������       ��ռ        %';
Sheet1.Range('E8').Value = '80---89��        ��ռ        %';
Sheet1.Range('B9').Value = '70---79��      ��ռ        %';
Sheet1.Range('E9').Value = '60---69��        ��ռ        %';
Sheet1.Range('A10').Value = ['�Ծ���������Ƿ���Ͻ�ѧ��١��Ѷȡ�֪ʶ��'...
    '���桢�༶�����ֲ�������ѧ��������ڵĹ���������֪ʶ�����������ѧ��'...
    '���ڵ����⼰�Ľ���ʩ�����ݣ�'];
Sheet1.Range('A12').Value = 'ǩ�� :                      ��     ��     ��';
Sheet1.Range('A13').Value = '���������������';
Sheet1.Range('A14').Value = '���������Σ�ǩ�֣�:             ��    ��    ��';
Sheet1.Range('D16').Value = '����Ժ��ǩ�֣�                  ��    ��    ��';

% �����ֺ�
Sheet1.Range('A4:H12').Font.size = 10.5;    % ���õ�Ԫ��A4��H12���ֺ�Ϊ10.5
Sheet1.Range('A1').Font.size = 16;          % ���õ�Ԫ��A1���ֺ�Ϊ16
Sheet1.Range('A1').Font.bold = 2;           % ��Ԫ��A1������Ӵ�

% ����ͼƬ�������ǰ����������ͼ�δ��ڣ�ͨ��ѭ����ͼ��ȫ��ɾ��
Shapes = Sheet1.Shapes;    % ���ص�1���������Shapes�ӿڵľ��
if Shapes.Count ~= 0;
    for i = 1 : Shapes.Count;
        Shapes.Item(1).Delete;    % ɾ����1��Shape����
    end;
end;

% ������ֵΪ75����׼��Ϊ4����̬�ֲ����������ֱ��ͼ��������ͼ������
zft = figure('units','normalized','position',...
 [0.280469 0.553385 0.428906 0.251302],'visible','off');  % �½�ͼ�δ��ڣ���Ϊ���ɼ�
set(gca,'position',[0.1 0.2 0.85 0.75]);    % ��������ϵ��λ�úʹ�С
data = normrnd(75,4,1000,1);    % ������ֵΪ75����׼��Ϊ4����̬�ֲ������
hist(data);    % ������̬�ֲ��������Ƶ��ֱ��ͼ
grid on;       % ��Ӳο�����
xlabel('���Գɼ�');    % ΪX��ӱ�ǩ
ylabel('����');       % ΪY��ӱ�ǩ
hgexport(zft, '-clipboard');    % ��ֱ��ͼ���Ƶ�������
% ѡ�й�����Sheet1��A11��Ԫ�񣬲�����MATLAB����������ֱ��ͼ
Sheet1.Range('A11').Select;
Sheet1.Paste    % Sheet1.PasteSpecial;

delete(zft);    % ɾ��ͼ�ξ��
Workbook.Save   % �����ĵ�