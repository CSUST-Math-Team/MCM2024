%--------------------------------------------------------------------------
%                    ����load������ȡ�ļ��е�����
%--------------------------------------------------------------------------

load examp02_01.txt    % ��load���������ļ�examp02_01.txt�е�����
load  -ascii  examp02_01.txt    % ��-asciiѡ��ǿ�����ı��ļ���ʽ��ȡ����
x1 = load('examp02_02.txt')    % ��load���������ļ�examp02_02.txt�е�����

x1 = load('examp02_02.txt', '-ascii');    % ��-asciiѡ��ǿ�����ı��ļ���ʽ��ȡ����
% ����dlmread������ȡ�ļ�examp02_01.txt�е�����
x2 = dlmread('examp02_01.txt');
% ����textread������ȡ�ļ�examp02_01.txt�е�����
x3 = textread('examp02_01.txt');
load examp02_03.txt    % ��load���������ļ�examp02_03.txt�е�����
load examp02_04.txt    % ��load���������ļ�examp02_04.txt�е�����

% ��load���������ļ�examp02_05.txt�е����ݣ����ִ���
load examp02_05.txt

% ��load���������ļ�examp02_07.txt�е����ݣ����ִ���
load examp02_07.txt

% ��load���������ļ�examp02_10.txt�е����ݣ����ִ���
load examp02_10.txt

% ��load���������ļ�examp02_11.txt�е����ݣ����ִ���
load examp02_11.txt

x = load('examp02_12.txt')    % ��load���������ļ�examp02_12.txt�е�����