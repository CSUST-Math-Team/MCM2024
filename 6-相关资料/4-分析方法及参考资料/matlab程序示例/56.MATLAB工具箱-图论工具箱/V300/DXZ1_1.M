clear;close;
n=4;
r=[28 21 23 25 5]'/100;
q=[2.5 1.5 5.5 2.6 0]'/100;
p=[1 2 4.5 6.5 0]'/100;
u=[103 198 52 40 100]';
lemda=0;
for i=1:11
  c=[(1-lemda)*(p-r);lemda];
  A1=[(1+p)', 0];
  A2=[diag(q(1:n)),zeros(n,1),-ones(n,1)];
  A=[A1;A2];
  b=[1;zeros(n,1)];
  vlb=zeros(n+2,1);
  x=lp(c,A,b,vlb,[],[],1);
  y=-(p-r)'*x(1:(n+1));
  goal=[y x(n+2)];
  lemda=lemda+0.1;
  s(:,i)=[x(1:(n+1));goal'];
end
s
plot(0:0.1:1,s(n+2,:),'w-',0:0.1:1,s(n+3,:),'w*');hold on;
plot(0:0.1:1,s(n+2,:),'w-',0:0.1:1,s(n+3,:),'w:');
title('投资目标曲线(n=4)');
xlabel('谨慎程度');ylabel('最佳目标');
legend('-w','收益 ','*w','风险');