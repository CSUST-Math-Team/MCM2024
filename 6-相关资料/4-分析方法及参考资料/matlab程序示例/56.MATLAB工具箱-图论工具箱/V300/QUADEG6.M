%微积分例6：刚性微分方程组（ode15s)
%需用模型函数quadeg6fun.m
clear;close;
[t,y]=ode45('quadeg6fun',[0,10],[2,1]');
plot(t,y);
text(1,1.1,'y1');
text(1,0.1,'y2');

pause

[t,y]=ode45('quadeg6fun',0,400,[2,1]');
tstep=length(t), minh=min(diff(t)), maxh=max(diff(t))

pause

[t,y]=ode15s('quadeg6fun',[0,400],[2,1]');
plot(t,y);
text(100,0.5,'y1');
text(1,0.1,'y2');
length(t), min(diff(t)),max(diff(t))


