%--------------------------------------------------------------------------
%               ����һ��Microsoft Excel�������������ⲿͼƬ
%--------------------------------------------------------------------------

% ����һ��Microsoft Excel�����������ؾ��Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % ���÷�����Ϊ�ɼ�״̬
Workbook = Excel.Workbooks.Add;    % �½�һ������������������
PicturePath = which('peppers.png');    % ����ͼƬ�ļ�peppers.png������·��
% �ڵ�ǰ�������ָ��λ�ô�����һ��ָ����С��ͼƬ�����ؾ��h1
h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,50,60,400,300);
% �ڵ�ǰ�������ָ��λ�ô�����һ��ָ����С��ͼƬ�����ؾ��h2
h2 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,500,60,200,150);
% �ڵ�ǰ�������ָ��λ�ô�����һ��ָ����С��ͼƬ�����ؾ��h3
h3 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,650,180,200,150);