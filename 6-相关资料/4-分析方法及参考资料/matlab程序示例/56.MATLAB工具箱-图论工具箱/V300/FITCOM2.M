%例子
%非单调节点插值interp的使用%第7节 最小二乘拟合 leastsq(调用M函数fitfun.m)
%最小二乘拟合 curvfit(调用M函数fitfun2.m)
%多项式插值与拟合 polyfit 
%多项式插值与拟合 lagrange (调用M函数lagrange.m)


clear;close;
%非单调节点插值interp的使用
x=[0.1,0.2,0.15,0,-0.2,0.3];
y=[0.95,0.84,0.86,1.06,1.50,0.72];
xi=-0.2:0.01:0.3;
yi=interp(x,y,xi,'spline');
subplot(2,2,1)
plot(x,y,'o',xi,yi,'k')
title('spline');

%最小二乘拟合 leastsq(调用M函数fitfun.m)
c=leastsq('fitfun',[1,1])
f='a*exp(b*t)';
a=c(1);b=c(2);t=xi;
yi=eval(f);
subplot(2,2,2);
plot(x,y,'o',xi,yi,'k')
title('leastsq');    

%最小二乘拟合 curvfit(调用M函数fitfun2.m)
x=[0.1,0.2,0.15,0,-0.2,0.3];
y=[0.95,0.84,0.86,1.06,1.50,0.72];
c=curvefit('fitfun2',[1,1],x,y) 

%多项式插值与拟合 polyfit 
p=polyfit(x,y,2)
yi=polyval(p,xi);subplot(2,2,3);
plot(x,y,'o',xi,yi,'k');
title('polyfit');

%多项式插值与拟合 lagrange (调用M函数lagrange.m)
yi=lagrange(x,y,xi);
subplot(2,2,4);
plot(x,y,'o',xi,yi,'k');
title('lagrange');


