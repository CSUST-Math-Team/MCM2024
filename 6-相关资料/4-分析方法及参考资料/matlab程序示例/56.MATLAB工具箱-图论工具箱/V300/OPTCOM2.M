%非线性优化
clear;
%无约束优化fmins(需用M文件optfun1.m)
x=[-1.2,1];
[x,options]=fmins('optfun1',x);
x,options(8)

%约束优化constr (需用M文件optfun2.m)
x0=[20,10,16];
options(13)=1;
[x,options]=constr('optfun2',x0,options,...  
    [-inf,10,-inf]',[inf,20,inf]);
x,-options(8)

