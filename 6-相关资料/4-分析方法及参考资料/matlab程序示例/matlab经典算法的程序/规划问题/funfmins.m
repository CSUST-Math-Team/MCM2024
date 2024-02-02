options(6)=1;%拟牛顿法的DFP公式
[x,options]=fmins('funrosen',[-1.2,2],options)
y=options(8) %输出在最后极值点的函数值
n=options(10)%给出函数计算次数<i