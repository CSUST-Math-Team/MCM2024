function f=quadeg5fun(t,y)
%微积分例5模型函数
%ode45等使用

f=y-2*t./y;
f=f(:);			%保证f为一个列向量
