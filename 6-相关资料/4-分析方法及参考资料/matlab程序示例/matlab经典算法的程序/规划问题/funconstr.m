x0=[-1;1];
options(13)=1;%g中第一个约束条件为等式约束
[x,options]=constr('fun1',x0,options)
options(8)<i