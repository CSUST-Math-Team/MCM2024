%--------------------------------------------------------------------------
%                ����importdata������ȡ�ļ��е�����
%--------------------------------------------------------------------------

% ����importdata������ȡ�ļ�examp02_04.txt�е�����
importdata('examp02_04.txt')

% ����importdata������ȡ�ļ�examp02_07.txt�е����ݣ����ؽṹ�����x
x = importdata('examp02_07.txt')
x.data    % �鿴��ȡ����ֵ������
x.textdata    % �鿴��ȡ���ı�����

% ����importdata������ȡ�ļ�examp02_03.txt�е����ݣ���';'���ָ����������ַ���Ԫ������x
x = importdata('examp02_03.txt',';')
x{1}    % �鿴x�ĵ�1��Ԫ���е��ַ�

% ����importdata������ȡ�ļ�examp02_08.txt�е����ݣ��ÿո����ָ���������ͷ�ļ�����Ϊ2
x = importdata('examp02_08.txt',' ',2)    % ���ؽṹ�����x

% ����importdata������ȡ�ļ�examp02_07.txt�е�����
% ���ؽṹ�����x���ָ���s��ͷ�ļ�����h
[x, s, h] = importdata('examp02_07.txt')

% ����importdata������ȡ�ļ�examp02_10.txt�е�����
FileContent = importdata('examp02_10.txt')    % �����ַ���Ԫ������FileContent
FileContent = char(FileContent)    % ���ַ���Ԫ������תΪ�ַ�����
t = str2num(FileContent(:, 8:9))    % ��ȡ�ַ�����ĵ�8��9�У���תΪ����