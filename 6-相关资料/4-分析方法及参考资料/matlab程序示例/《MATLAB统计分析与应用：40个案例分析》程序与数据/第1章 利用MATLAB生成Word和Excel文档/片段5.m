%--------------------------------------------------------------------------
%               ����һ��Microsoft Excel�������������ڲ�ͼƬ
%--------------------------------------------------------------------------

% ����һ��Microsoft Excel�����������ؾ��Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % ���÷�����Ϊ�ɼ�״̬
Workbook = Excel.Workbooks.Add;    % �½�һ������������������
Sheet1 = Workbook.Sheets.Item(1);    % ���ص�1��������ľ��Sheet1

data = normrnd(75,4,1000,1);    % ����1000����ֵΪ75����׼��Ϊ4����̬�ֲ������
% �½�һ��ͼ�δ��ڣ�����ͼ�δ���Ϊ���ɼ���������ͼ�δ��ھ��
zft = figure('units','normalized','position',...
                [0.280469 0.553385 0.428906 0.251302],'visible','off');
set(gca,'position',[0.1 0.2 0.85 0.75]);    % ���õ�ǰ����ϵ��λ�úʹ�С
hist(data);    % ������̬�ֲ��������Ƶ��ֱ��ͼ
grid on;       % ��Ӳο�����
xlabel('���Գɼ�');    % ΪX��ӱ�ǩ
ylabel('����');       % ΪY��ӱ�ǩ
hgexport(zft, '-clipboard');    % ��ֱ��ͼ���Ƶ�������

% ѡ�й�����Sheet1��A2��Ԫ�񣬲�����MATLAB����������ֱ��ͼ
Sheet1.Range('A2').Select;
Sheet1.Paste

% ѡ�й�����Sheet1��E11��Ԫ�񣬲�����MATLAB����������ֱ��ͼ
Sheet1.Range('E11').Select;
Sheet1.PasteSpecial;

% �ڹ�����Sheet1��I20��Ԫ�񴦲�����MATLAB����������ֱ��ͼ
Sheet1. Range('I20').PasteSpecial;