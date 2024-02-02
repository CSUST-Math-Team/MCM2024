function ceshi_Word
%����MATLAB����Word�ĵ�
%   ceshi_Word
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/14 12:37:00 $

% �趨����Word�ļ�����·��
filespec_user = [pwd '\����.doc'];

% �ж�Word�Ƿ��Ѿ��򿪣����Ѵ򿪣����ڴ򿪵�Word�н��в���������ʹ�Word
try
    % ��Word�������Ѿ��򿪣���������Word
    Word = actxGetRunningServer('Word.Application');
catch
    % ����һ��Microsoft Word�����������ؾ��Word
    Word = actxserver('Word.Application'); 
end;

% ����Word����Ϊ�ɼ�
Word.Visible = 1;    % ��set(Word, 'Visible', 1);

% �������ļ����ڣ��򿪸ò����ļ��������½�һ���ļ��������棬�ļ���Ϊ����.doc
if exist(filespec_user,'file'); 
    Document = Word.Documents.Open(filespec_user);     
    % Document = invoke(Word.Documents,'Open',filespec_user);
else
    Document = Word.Documents.Add;     
    % Document = invoke(Word.Documents, 'Add'); 
    Document.SaveAs(filespec_user);
end

Content = Document.Content;    % ����Content�ӿھ��
Selection = Word.Selection;    % ����Selection�ӿھ��
Paragraphformat = Selection.ParagraphFormat;  % ����ParagraphFormat�ӿھ��

% ҳ������
Document.PageSetup.TopMargin = 60;      % �ϱ߾�60��
Document.PageSetup.BottomMargin = 45;   % �±߾�45��
Document.PageSetup.LeftMargin = 45;     % ��߾�45��
Document.PageSetup.RightMargin = 45;    % �ұ߾�45��

% �趨�ĵ����ݵ���ʼλ�úͱ���
Content.Start = 0;         % �����ĵ����ݵ���ʼλ��
title = '��  ��  ��  ��';
Content.Text = title;      % ������������
Content.Font.Size = 16 ;   % �����ֺ�Ϊ16
Content.Font.Bold = 4 ;    % ����Ӵ�
Content.Paragraphs.Alignment = 'wdAlignParagraphCenter';    % ���ж���

Selection.Start = Content.end;    % �趨�������ݵ���ʼλ��
Selection.TypeParagraph;    % �س�������һ��

xueqi = '�� 2009  ��  2010   ѧ�� ��һѧ�ڣ�';
Selection.Text = xueqi;     % �ڵ�ǰλ��������������
Selection.Font.Size = 12;   % �����ֺ�Ϊ12
Selection.Font.Bold = 0;    % ���岻�Ӵ�
Selection.MoveDown;         % ������ƣ�ȡ��ѡ�У�
paragraphformat.Alignment = 'wdAlignParagraphCenter';    % ���ж���
Selection.TypeParagraph;    % �س�������һ��
Selection.TypeParagraph;    % �س�������һ��
Selection.Font.Size = 10.5; % �����ֺ�Ϊ10.5

% �ڹ������λ�ò���һ��12��9�еı��
Tables = Document.Tables.Add(Selection.Range,12,9);    

% ���ص�1�����ľ��
DTI = Document.Tables.Item(1);    % ��DTI = Tables;

% ���ñ��߿�
DTI.Borders.OutsideLineStyle = 'wdLineStyleSingle';
DTI.Borders.OutsideLineWidth = 'wdLineWidth150pt';
DTI.Borders.InsideLineStyle = 'wdLineStyleSingle';
DTI.Borders.InsideLineWidth = 'wdLineWidth150pt';
DTI.Rows.Alignment = 'wdAlignRowCenter';
DTI.Rows.Item(8).Borders.Item(1).LineStyle = 'wdLineStyleNone';
DTI.Rows.Item(8).Borders.Item(3).LineStyle = 'wdLineStyleNone';
DTI.Rows.Item(11).Borders.Item(1).LineStyle = 'wdLineStyleNone';
DTI.Rows.Item(11).Borders.Item(3).LineStyle = 'wdLineStyleNone';

% ���ñ���п���и�
column_width = [53.7736,85.1434,53.7736,35.0094,...
    35.0094,76.6981,55.1887,52.9245,54.9057];    % �����п�����
row_height = [28.5849,28.5849,28.5849,28.5849,25.4717,25.4717,...
    32.8302,312.1698,17.8302,49.2453,14.1509,18.6792];    % �����и�����
% ͨ��ѭ�����ñ��ÿ�е��п�
for i = 1:9
    DTI.Columns.Item(i).Width = column_width(i);
end
% ͨ��ѭ�����ñ��ÿ�е��и�
for i = 1:12
    DTI.Rows.Item(i).Height = row_height(i);
end

% ͨ��ѭ������ÿ����Ԫ��Ĵ�ֱ���뷽ʽ
for i = 1:12
    for j = 1:9
        DTI.Cell(i,j).VerticalAlignment = 'wdCellAlignVerticalCenter';
    end
end

% �ϲ���Ԫ��
DTI.Cell(1, 4).Merge(DTI.Cell(1, 5));
DTI.Cell(2, 4).Merge(DTI.Cell(2, 5));
DTI.Cell(3, 4).Merge(DTI.Cell(3, 5));
DTI.Cell(4, 4).Merge(DTI.Cell(4, 5));
DTI.Cell(5, 2).Merge(DTI.Cell(5, 5));
DTI.Cell(5, 3).Merge(DTI.Cell(5, 6));
DTI.Cell(6, 2).Merge(DTI.Cell(6, 5));
DTI.Cell(6, 3).Merge(DTI.Cell(6, 6));
DTI.Cell(5, 1).Merge(DTI.Cell(6, 1));
DTI.Cell(7, 1).Merge(DTI.Cell(7, 9));
DTI.Cell(8, 1).Merge(DTI.Cell(8, 9));
DTI.Cell(9, 1).Merge(DTI.Cell(9, 3));
DTI.Cell(9, 2).Merge(DTI.Cell(9, 3));
DTI.Cell(9, 3).Merge(DTI.Cell(9, 4));
DTI.Cell(9, 4).Merge(DTI.Cell(9, 5));
DTI.Cell(10, 1).Merge(DTI.Cell(10, 9));
DTI.Cell(11, 5).Merge(DTI.Cell(11, 9));
DTI.Cell(12, 5).Merge(DTI.Cell(12, 9));
DTI.Cell(11, 1).Merge(DTI.Cell(12, 4));

Selection.Start = Content.end;    % ���ù��λ�����ĵ����ݵĽ�β
Selection.TypeParagraph;          % �س�������һ��
Selection.Text = '����Ժ��ǩ�֣�            ��    ��    ��';    % ������������
Paragraphformat.Alignment = 'wdAlignParagraphRight';    % �Ҷ���
Selection.MoveDown;    % �������

% д��������
DTI.Cell(1,1).Range.Text = '�γ�����';
DTI.Cell(1,3).Range.Text = '�γ̺�';
DTI.Cell(1,5).Range.Text = '�ον�ʦѧԺ';
DTI.Cell(1,7).Range.Text = '�ον�ʦ';
DTI.Cell(2,1).Range.Text = '�ڿΰ༶';
DTI.Cell(2,3).Range.Text = '��������';
DTI.Cell(2,5).Range.Text = 'Ӧ������';
DTI.Cell(2,7).Range.Text = 'ʵ������';
DTI.Cell(3,1).Range.Text = '����ʽ';
DTI.Cell(3,3).Range.Text = '�ľ�ʽ';
DTI.Cell(3,5).Range.Text = 'ѡ���Ծ�A/B';
DTI.Cell(3,7).Range.Text = '����ʱ��';
DTI.Cell(4,1).Range.Text = '���Է�ʽ';
DTI.Cell(4,3).Range.Text = 'ƽ����';
DTI.Cell(4,5).Range.Text = '����������';
DTI.Cell(4,7).Range.Text = '������';
DTI.Cell(5,1).Range.Text = '�ɼ��ֲ�';
DTI.Cell(5,2).Range.Text = '90������      ��ռ        %';
DTI.Cell(5,3).Range.Text = '80---89��        ��ռ        %';
DTI.Cell(6,2).Range.Text = '70--79��      ��ռ        %';
DTI.Cell(6,3).Range.Text = '60---69��        ��ռ        %';
DTI.Cell(7,1).Range.Text = ['�Ծ���������Ƿ���Ͻ�ѧ��١��Ѷȡ�֪ʶ��'...
    '���桢�༶�����ֲ�������ѧ��������ڵĹ���������֪ʶ�����������ѧ��'...
    '���ڵ����⼰�Ľ���ʩ�����ݣ�'];
DTI.Cell(7,1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(9,2).Range.Text = 'ǩ�� :';
DTI.Cell(9,4).Range.Text = '��    ��    ��';
DTI.Cell(10,1).Range.Text = '���������������';
DTI.Cell(10,1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(10,1).VerticalAlignment = 'wdCellAlignVerticalTop';
DTI.Cell(11,2).Range.Text = '���������Σ�ǩ�֣�:          ��    ��    ��';
DTI.Cell(11,2).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(8,1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(8,1).VerticalAlignment = 'wdCellAlignVerticalTop';
DTI.Cell(9,2).Borders.Item(2).LineStyle = 'wdLineStyleNone';
DTI.Cell(9,2).Borders.Item(4).LineStyle = 'wdLineStyleNone';
DTI.Cell(9,3).Borders.Item(4).LineStyle = 'wdLineStyleNone';
DTI.Cell(11,1).Borders.Item(4).LineStyle = 'wdLineStyleNone';

% �����ǰ�����ĵ�����ͼ�δ��ڣ�ͨ��ѭ����ͼ��ȫ��ɾ��
Shape = Document.Shapes;    % ����Shapes�ӿڵľ��
ShapeCount = Shape.Count;   % �����ĵ���Shape����ĸ���
if ShapeCount ~= 0;
    for i = 1:ShapeCount;
        Shape.Item(1).Delete;    % ɾ����1��Shape����
    end;
end;

% ������׼��̬�ֲ����������ֱ��ͼ��������ͼ������
zft = figure('units','normalized','position',...
 [0.280469 0.553385 0.428906 0.251302],'visible','off');  % �½�ͼ�δ��ڣ���Ϊ���ɼ�
set(gca,'position',[0.1 0.2 0.85 0.75]);    % ��������ϵ��λ�úʹ�С
data = normrnd(0,1,1000,1);    % ������׼��̬�ֲ������
hist(data);    % ���Ʊ�׼��̬�ֲ��������Ƶ��ֱ��ͼ
grid on;       % ��Ӳο�����
xlabel('���Գɼ�');    % ΪX��ӱ�ǩ
ylabel('����');       % ΪY��ӱ�ǩ

% ��ͼ�θ��Ƶ�ճ����
hgexport(zft, '-clipboard');

% ��ͼ��ճ������ǰ�ĵ�����ĵ�8�е�1�еĵ�Ԫ�����������ͼ�ΰ�ʽΪ���������Ϸ�
% Selection.Range.PasteSpecial;
DTI.Cell(8,1).Range.Paragraphs.Item(1).Range.PasteSpecial;
Shape.Item(1).WrapFormat.Type = 3;
Shape.Item(1).ZOrder('msoBringInFrontOfText');   % ����ͼƬ���Ŵ���Ϊ���������Ϸ�
delete(zft);    % ɾ��ͼ�ξ��

Document.ActiveWindow.ActivePane.View.Type = 'wdPrintView';    % ������ͼ��ʽΪҳ��
Document.Save;     % �����ĵ�
