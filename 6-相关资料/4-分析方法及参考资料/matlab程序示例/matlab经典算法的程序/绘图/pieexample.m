clear
clc
x=[11.4 23.5 35.4 15.6];
explode=zeros(size(x));
[c,offset]=min(x);
explode(offset)=c;
pie(x,explode)<i