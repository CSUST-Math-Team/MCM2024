%--------------------------------------------------------------------------
%                         ����fopen�������ļ�
%--------------------------------------------------------------------------

% ����fopen������һ�������ڵ��ļ�xiezhh.txt
[fid, message] = fopen('xiezhh.txt')    % �����ļ���ʶ��fid�������Ϣmessage

fid = fopen('xiezhh.txt')    % ����fopen������һ�������ڵ��ļ�xiezhh.txt
[filename, permission] = fopen(fid)    % �õ������ļ�����Ϣ

% ����fopen������ֻ����ʽ���ļ�examp02_01.txt 
fid = fopen('examp02_01.txt','rt');    % �����ļ���ʶ��fid
tline = fgets(fid, 32)    % ��ȡ�ļ�examp02_01.txt��һ���ϵ�32���ַ�
fclose(fid);    % �ر��ļ�
