% MATLAB��ѧ��ģ������
% Version 1.2 28-March-2001
% Copyright (c) 2000
% ������ѧ��ά����о�����
% �Ϻ����Ӱ���·1882��
% Email: ljhu@dhu.edu.cn
%
% ����������Ҫ��������������
%       (֧��ƽ̨MATLAB5.3��5.2,Symbolic math,optim,spline,stats)
% 1. MATLAB������ѧ��ģ���ߵ����İ���
% 2. ����MATLAB��ѧ��ģ����(��*��)
% 3. �й���ѧ����ѧ��ģ������������MATLAB����
%
% ��װ����
% 1. ��MATHMODL.zip��ѹ����matlab11\toolbox\;
% 2. ����Matlab,����Path Browser�е�Add path�˵���
%    matlab11\toolbox\mathmodl����path��,������ǰ�棬���������ã�
% 3. �ص���Ĺ���Ŀ¼������MATHMODL�ѳ�Ϊһ����ͨ�Ĺ������ˡ�
%
% ����ʹ������help mathmodl�鿴���ݻ�ֱ��������mathmodlѧϰ�̡̳�
%
% �������
%   interp1    - һԪ������ֵ
%   spline     - ������ֵ
%   polyfit    - ����ʽ��ֵ�����    
%   curvefit   - �������
%   caspe      - ���ֱ߽�������������ֵ
%   casps      - �������
%   interp2    - ��Ԫ������ֵ
%   griddata   - ���������ݵĶ�Ԫ������ֵ
%  *interp     - �������ڵ��ֵ
%  *lagrange   - �������ղ�ֵ��
%
% �������
%   inv        - �����
%   roots      - ����ʽ�ĸ�
%   fzero      - һԪ�������
%   fsolve     - �����Է�����
%   solve      - ���ŷ��̽�
%  *newton     - ţ�ٵ�����������Է���
%  
%΢���ֺ�΢�ַ���
%   diff       - ���
%   diff       - ���ŵ�����
%   trapz      - ���λ��ַ�
%   quad8      - �߾�����ֵ����
%   int        - ���Ż���
%   dblquad    - ��������ػ���
%   ode45      - ��΢�ַ���
%   dsolve     - ����΢�ַ���
%  *polyint    - ����ʽ���ַ�
%  *quadg      - ��˹���ַ�
%  *quad2dg    - �������˹���ػ���
%  *dblquad2      - �Ǿ�������ػ���    
%  *rk4        - ��΢�ַ���RungeKutta��
%
%���ģ���ͳ�Ʒ���
%   max,min    - �����Сֵ
%   sum        - ���
%   mean       - ��ֵ
%   std        - ��׼��
%   sort       - ��������
%   sortrows   - ��ĳһ������(����)
%   rand       - [0��1]������ȷֲ������
%   randn      - ��׼��̬�ֲ������
%   randperm   - 1...n �������
%   regress    - ���Իع�
%   classify   - ͳ�ƾ���
%  *trim       - ���������
%  *specrnd    - �����ֲ������������
%  *randrow    - �����������
%  *randmix    - ����û�
%  *chi2test   - �ֲ���϶ȿ�������
%
% ��ѧ�滮
%   lp            - ���Թ滮
%   linprog       - ���Թ滮(��MATLAB5.3ʹ��)
%   fmin          - һԪ������ֵ
%   fminu         - ��Ԫ������ֵ��ţ�ٷ�
%   fmins         - ��Ԫ������ֵ������������
%   constr        - �����Թ滮
%   fmincon       - �����Թ滮(��MATLAB5.3ʹ��)
%
% ��ɢ�Ż�
%  *enum       - ö�ٷ�
%  *monte      - ���ؿ��巨
%  *lpint      - ���������滮
%  *L01p_e     - 0-1�����滮ö�ٷ�
%  *L01p_ie    - 0-1�����滮��ö�ٷ�
%  *bnb18      - �����������滮(��MATLAB5.3ʹ��)
%  *bnbgui     - �����������滮ͼ�ι���(��MATLAB5.3ʹ��)
%  *mintreek   - ��С������kruskal�㷨
%  *minroute   - ���·dijkstra�㷨
%  *krusk      - ��С������kruskal�㷨mex����
%  *dijkstra   - ���·dijkstra�㷨mex����
%  *dynprog    - ��̬�滮
%
%
% ͼ��
%   plot       - ƽ�����ߣ�һԪ������
%   plot3      - �ռ�����
%   mesh       - �ռ����棨��Ԫ������
%  *meshf      - �Ǿ�������ͼ
%  *draw       - ����껮�⻬����
%
%�й���ѧ����ѧ��ģ�������
%   jm96a      - �������
%   jm96b      - ��ˮϴ�»�
%   jm96bfun   - ��ˮϴ�»��Ż�����
%   jm97a      - ����������
%   jm97afun   - �����������  
%   jm97aoptim - �����������Ż�����
%   jm97b      - �ض��и�
%   jm97bcount - �ض��и�ö�ٷ�
%   jm97brule  - �ض��и��Ż�׼��   
%   jm98a1     - ����Ͷ��ģ�����
%   jm98a2     - ����Ͷ��ģ������
%   jm98a3     - ��������շ�����ģ�����
%   jm98a3fun  - ��������շ�����ģ���Ż�����
%   jm98b      - ����Ѳ��·�ߣ�C����
%   jm99a1     - �Զ�������ģ��һ
%   jm99a1fun   - �Զ�������ģ��Ŀ�꺯��
%   jm99a1simu  - �Զ�������ģ�����ģ��
%   jm99asmfun  - �Զ�������ģ�ͷ��ú���
%
% ��ʾ����
%   funtool     - ����������
%   tutdemo     - MATLAB�Ż�������̳�
%   mathmodl    - ��ѧ��ģ��������ʾ
