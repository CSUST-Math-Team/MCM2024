%微积分例3:一元函数积分（trape,quad)
%使用模型函数quadeg3fun.m

clear;
x=-1:0.1:1;
y=exp(-x.^2);
trapz(x,y)

quad8('quadeg3fun',-1,1)