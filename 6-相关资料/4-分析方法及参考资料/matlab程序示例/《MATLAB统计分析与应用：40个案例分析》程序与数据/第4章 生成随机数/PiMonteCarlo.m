function  piva = PiMonteCarlo(n)
%   PiMonteCarlo(n)�������Ͷ�㷨ģ��Բ����pi������ģ��ͼ. nΪͶ������������ǷǸ���������
%   ������.

%   piva = PiMonteCarlo(n)�������Ͷ�㷨ģ��Բ����pi������ģ��ֵpiva. ��nΪ��������
%   ��������pivaҲΪ������������.

x = 0;y = 0;d = 0;
m = length(n);  % �����n�ĳ���
pivalue = zeros(m,1);  % Ϊ����pivalue����ֵ
% ͨ��ѭ����Ͷ�㷨ģ��Բ����pi
for i = 1:m
   x = 2*rand(n(i),1)-1;  % ���Ͷ��ĺ�����
   y = 2*rand(n(i),1)-1;  % ���Ͷ���������
   d = x.^2+y.^2;
   pivalue(i) = 4*sum(d <= 1)/n(i);  % Բ���ʵ�ģ��ֵ
end

if nargout == 0
    % �����Բ���ʵ�ģ��ֵ������ģ��ͼ
    if m > 1
        % ���nΪ�������򷵻�Բ���ʵ�ģ��ֵ��Ͷ�������ɢ��ͼ
        figure;  % �½�һ��ͼ�δ���
        plot(n,pivalue,'k.');  % ����ɢ��ͼ
        h = refline(0,pi);   % ��Ӳο���
        set(h,'linewidth',2,'color','k');  % ���òο�������
        text(1.05*n(end),pi,'\pi','fontsize',15);  % ����ı���Ϣ
        xlabel('Ͷ�����');  ylabel('\pi��ģ��ֵ'); % ����������ǩ
    else
        % ���nΪ�������򷵻�Ͷ�㷨ģ��Բ���ʵ�ʾ��ͼ
        figure;  % �½�һ��ͼ�δ���
        plot(x,y,'k.');  % ����ɢ��ͼ
        hold on;
        % ���Ʊ߳�Ϊ2��������
        h = rectangle('Position',[-1 -1 2 2],'LineWidth',2);
        t = linspace(0,2*pi,100);  % ����һ���Ƕ�����
        plot(cos(t),sin(t),'k','linewidth',2);  % ���Ƶ�λԲ
        xlabel('X');  ylabel('Y');  % ����������ǩ
        title(['Pi��ģ��ֵ�� ' num2str(pivalue)]); % ��ӱ���
        axis([-1.1 1.1 -1.1 1.1]); axis equal;  % ��������������
    end
else    
    piva = pivalue;  % ���Բ���ʵ�ģ��ֵ
end