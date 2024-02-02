function varargout=DemoILP(varargin)

f=[-1 -1]
A=[-4 2;4 2;0 -2]
b=[-1;11;-1]
lb=[0;0]
ub=[inf;inf]
lints=[1;1]
ltimes=10
lerr=1e-3

[x,fval]=ILP(f,A,b,[],[],lb,ub,lints,ltimes,lerr)