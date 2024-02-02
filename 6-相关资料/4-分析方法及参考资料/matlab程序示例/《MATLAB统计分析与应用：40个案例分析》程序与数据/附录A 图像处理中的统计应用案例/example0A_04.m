%--------------------------------------------------------------------------
%                       ���ڱ�Ҷ˹�б����д������ʶ��
%--------------------------------------------------------------------------

%***********************��ȡѵ������ͼƬ��������Ԥ����***********************
% ����uigetfile��������ʽѡȡѵ������ͼƬ
geshi = {'*.jpg','JPEG image (*.jpg)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'�����ⲿ����',...
    '*.jpg','MultiSelect','on');
% ���ѡ����ͼƬ�ļ�������ͼƬ�ļ�������·���������˳����򣬲������к�������
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % ѡ���ͼƬ�ļ�����
% ����I��BW��training��group�ĳ�ֵ
I = zeros(50);
BW = zeros(16);
training = zeros(1,256);
group = [];
% ͨ��ѭ����ÿһ��ͼƬ���б�׼������������ѵ���������ݾ���training�ͷ�������group
for i = 1:n
    I = imread(FileFullName{i});  % ����һ��ͼƬ
    I = 255-I;  % ͼ��ɫ����    
    I = im2bw(I,0.4);  % �趨��ֵ���ѷ�ɫ��ͼ��ת�ɶ�ֵͼ��
    [y,x] = find(I == 1);  % �������������ص���б�y���б�x
    BW = I(min(y):max(y),min(x):max(x));  % ��ȡ�������ֵ��������ͼ��
    % ����ȡ�İ������ֵ��������ͼ��ת��16��16�ı�׼��ͼ��
    BW = imresize(BW,[16, 16]);
    % ����׼��ͼ��������������50��256��ѵ����������training
    training(i,:) = double(BW(:)');
    % ��ͼƬ�ļ����ַ����ֳ������֣��ļ�·����������չ�����ļ�������չ���ַ���
    [pathstr,namestr,ext] = fileparts(FileName{i});
    % ��ȡ������չ�����ļ����ַ����ĵ�4���ַ����õ���ͼƬ��Ӧ�����֣�����ͼƬ���ڵ���
    group = [group;str2num(namestr(4))];
end


%***************************�������ر�Ҷ˹����������*************************
% �������ر�Ҷ˹����������ObjBayes
ObjBayes = NaiveBayes.fit(training,group,'Distribution','mn')


%*****************************��ѵ������ͼƬ�����б�*************************
% ���������������ر�Ҷ˹����������ObjBayes����ѵ������ͼƬ�����б�
pre0 = ObjBayes.predict(training);
isequal(pre0, group)  % �ж��б���pre0���������group�Ƿ����


%***********************��ȡ��������ͼƬ��������Ԥ����***********************
% ����uigetfile��������ʽѡȡ��������ͼƬ
geshi = {'*.jpg','JPEG image (*.jpg)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'�����ⲿ����',...
    '*.jpg','MultiSelect','on');
% ���ѡ����ͼƬ�ļ�������ͼƬ�ļ�������·���������˳����򣬲������к�������
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % ѡ���ͼƬ�ļ�����
% ����I��BW��sampledata��samplegroup�ĳ�ֵ
I = zeros(50);
BW = zeros(16);
sampledata = zeros(1,256);
samplegroup = [];
% ͨ��ѭ����ÿһ��ͼƬ���б�׼������
% �����ɼ����������ݾ���sampledata�ͷ�������samplegroup
for i = 1:n
    I = imread(FileFullName{i});  % ����һ��ͼƬ
    I = 255-I;  % ͼ��ɫ����    
    I = im2bw(I,0.4);  % �趨��ֵ���ѷ�ɫ��ͼ��ת�ɶ�ֵͼ��
    [y,x] = find(I == 1);  % �������������ص���б�y���б�x
    BW = I(min(y):max(y),min(x):max(x));  % ��ȡ�������ֵ��������ͼ��
    % ����ȡ�İ������ֵ��������ͼ��ת��16��16�ı�׼��ͼ��
    BW = imresize(BW,[16, 16]);
    % ����׼��ͼ��������������30��256�ļ�����������sampledata
    sampledata(i,:) = double(BW(:)');
    % ��ͼƬ�ļ����ַ����ֳ������֣��ļ�·����������չ�����ļ�������չ���ַ���
    [pathstr,namestr,ext] = fileparts(FileName{i});
    % ��ȡ������չ�����ļ����ַ����ĵ�4���ַ����õ���ͼƬ��Ӧ�����֣�����ͼƬ���ڵ���
    samplegroup = [samplegroup; str2num(namestr(4))];
end


%*****************************�Լ�������ͼƬ�����б�*************************
% ���������������ر�Ҷ˹����������ObjBayes���Լ�������ͼƬ�����б�
pre1 = ObjBayes.predict(sampledata);
% �鿴�б���
[samplegroup, pre1]    % ��һ��Ϊ��ʵ�飬�ڶ���Ϊ�й����