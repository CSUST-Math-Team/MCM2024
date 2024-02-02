%微积分例5：微分方程（rk4,ode45)
%需用模型函数quadeg5fun.m
clear;close;
[t,y]=rk4('quadeg5fun',[0,7],1,0.03);
plot(t,y); 
hold on;
[t,y]=ode45('quadeg5fun',[0,7],1);
plot(t,y,'r:');
hold off;
