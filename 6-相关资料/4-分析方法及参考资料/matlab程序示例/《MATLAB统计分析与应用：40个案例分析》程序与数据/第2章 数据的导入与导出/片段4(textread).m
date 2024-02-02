%--------------------------------------------------------------------------
%                    ����textread������ȡ�ļ��е�����
%--------------------------------------------------------------------------

% ����textread������ȡ�ļ�examp02_01.txt�е����ݣ����ض�ȡ�����ݾ���x1
x1 = textread('examp02_01.txt');
% ����textread������ȡ�ļ�examp02_02.txt�е����ݣ����ض�ȡ�����ݾ���x2
x2 = textread('examp02_02.txt');

% ����textread������ȡ�ļ�examp02_03.txt�е����ݣ��ö���(',')���ָ���
x3 = textread('examp02_03.txt','','delimiter',',');    % ���ض�ȡ�����ݾ���x3

% ����textread������ȡ�ļ�examp02_04.txt�е����ݣ�ָ����ȡ��ʽ��
% ͬʱ�ö��š��ֺź��Ǻ�(',;*')���ָ���
[c1,c2,c3,c4,c5]=textread('examp02_04.txt','%f %f %f %f %f','delimiter',',;*');
c5    % �鿴c5������

% ����textread������ȡ�ļ�examp02_05.txt�е����ݣ����ȳ�������-1����
x5 = textread('examp02_05.txt','','emptyvalue',-1)    % ���ض�ȡ�����ݾ���x5

% ����textread������ȡ�ļ�examp02_06.txt�е����ݣ����ȳ�������-1����
x6 = textread('examp02_06.txt','','emptyvalue',-1)    % ���ض�ȡ�����ݾ���x6

% ����textread������ȡ�ļ�examp02_08.txt�е����ݣ�����ͷ�ļ�����Ϊ7
x8 = textread('examp02_08.txt','','headerlines',7)    % ���ض�ȡ�����ݾ���x8

% ����textread������ȡ�ļ�examp02_09.txt�е����ݣ�
% �ö��źͿո�(', ')��Ϊ�ָ������ѼӺź�i��Ϊ�ո񣬷��ض�ȡ�����ݾ���x9
x9 = textread('examp02_09.txt','','delimiter',', ','whitespace','+i')

% ����textread������ȡ�ļ�examp02_09.txt�е����ݣ�ͬʱ�üӺš�i�Ͷ���('+i,')��Ϊ�ָ���
x9 = textread('examp02_09.txt','','delimiter','+i,')

% ����textread������ȡ�ļ�examp02_09.txt�е����ݣ��趨��ȡ��ʽ
% �ö��źͿո�(', ')��Ϊ�ָ������ѼӺź�i��Ϊ�ո񣬷��ض�ȡ������
[c1,c2,c3,c4,c5,c6,c7,c8] = textread('examp02_09.txt',...
'%f %f %f %f %f %f %f %f','delimiter',', ','whitespace','+i');
x9 = [c1,c2,c3,c4,c5,c6,c7,c8]    % �鿴��ȡ������

% ����textread������ȡ�ļ�examp02_10.txt�е����ݣ��趨��ȡ��ʽ
% ͬʱ�ü��š����ź�ð��('-,:')��Ϊ�ָ��������ض�ȡ������
 [c1,c2,c3,c4,c5,c6,c7] = textread('examp02_10.txt',...
'%4d %d %2d %d %d %6.3f %s','delimiter','-,:');
[c1,c2,c3,c4,c5,c6]    % �鿴��ȡ������

% �趨��ȡ��ʽ
format = '%s %s %s %d %s %d %s %d %s';
% ����textread������ȡ�ļ�examp02_11.txt�е����ݣ�
% ��ð�źͿո�': '��Ϊ�ָ��������ض�ȡ������
[c1,c2,c3,c4,c5,c6,c7,c8,c9] = textread('examp02_11.txt',format,...
'delimiter',': ');
[c4 c6 c8]    % �鿴��ȡ������