%--------------------------------------------------------------------------
%               ����һ��Microsoft Word������������ͼƬ
%--------------------------------------------------------------------------

% ����һ��Microsoft Word�����������ؾ��Word
Word = actxserver('Word.Application'); 

% ����Word������Ϊ�ɼ�״̬
set(Word, 'Visible', 1);     %��Word.Visible = 1;
Document = Word.Documents.Add;    % �½�һ���հ��ĵ�
Selection = Word. Selection;    % ����Word��������Selection�ӿڵľ��


%********************************�����ⲿͼƬ*******************************
filename = [matlabroot '\toolbox\images\imdemos\football.jpg'];  % ͼƬ����·��
% �ڹ��λ�ô�����һ��ͼƬ����ʽΪǶ��ʽ
handle1 = Selection.InlineShapes.AddPicture(filename);
% ��ָ��λ�ô�����һ��ͼƬ����ʽΪ���������Ϸ�
handle2 = Document.Shapes.AddPicture(filename, [], [], 180, 50, 200, 170);


%********************************�����ڲ�ͼƬ*******************************
Document = Word.Documents.Add;    % �½�һ���հ��ĵ�
Selection = Word. Selection;    % ����Word��������Selection�ӿڵľ��
% ����normrnd��������1000�����ӱ�׼��̬�ֲ��������
data = normrnd(0,1,1000,1);
% �½�һ��ͼ�δ��ڣ�����Ϊ���ɼ�״̬
zft = figure('units','normalized','position',...
                [0.280469 0.553385 0.428906 0.251302],'visible','off');
% ��������ϵ��λ�úʹ�С
set(gca,'position',[0.1 0.2 0.85 0.75]);
hist(data);    % ����Ƶ��ֱ��ͼ
grid on;    % ��Ӳο�����
xlabel('���Գɼ�');    % ΪX��ӱ�ǩ
ylabel('����');       % ΪY��ӱ�ǩ
hgexport(zft, '-clipboard');    %��ͼ�θ��Ƶ�������
Selection.Paste;    % �ڵ�ǰ���λ�ô�����������ϵ�ͼƬ����ʽΪǶ��ʽ
Selection.TypeParagraph;    % �س�������һ��
Selection.PasteSpecial;    % �ڵ�ǰ���λ�ô�����������ϵ�ͼƬ����ʽΪ���������Ϸ�