function y = statsfun(beta,x)
%统计例子：非线性模型的函数
 b1 = beta(1);
 b2 = beta(2);
 b3 = beta(3);
 b4 = beta(4);
 b5 = beta(5);
 x1 = x(:,1);
 x2 = x(:,2);
 x3 = x(:,3);
 y = (b1*x2 - x3/b5)./(1+b2*x1+b3*x2+b4*x3);
