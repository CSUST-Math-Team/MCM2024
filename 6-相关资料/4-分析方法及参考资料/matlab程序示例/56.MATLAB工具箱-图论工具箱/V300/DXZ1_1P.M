clear;close;
n=4;
r=[28 21 23 25 5]'/100;
q=[2.5 1.5 5.5 2.6 0]'/100;
p=[1 2 4.5 6.5 0]'/100;
u=[103 198 52 40 100]';

for lemda=linspace(0,1,300)
  c=[(1-lemda)*(p-r);lemda];
  A1=[(1+p)', 0];
  A2=[diag(q(1:n)),zeros(n,1),-ones(n,1)];
  A=[A1;A2];
  b=[1;zeros(n,1)];
  vlb=zeros(n+2,1);
  x=lp(c,A,b,vlb,[],[],1);
  y=-(p-r)'*x(1:(n+1));
  goal=[y x(n+2)];
  plot(goal(2),goal(1),'ow');hold on;
end
title('有效投资曲线(n=4)');
xlabel('风险');ylabel('收益');
