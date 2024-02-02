%例子：样条插值
%非扭结样条
%任意边界样条

clear;close;
%非扭结样条
x=[1 2 4 5];y=[1 3 4 2];
subplot(2,2,1);p=spline(x,y);
xi=1:0.1:5;yi=ppval(p,xi);
subplot(2,2,1);
plot(x,y,'o',xi,yi,'k')
title('not-a-knot');
[b,c]=unmkpp(p)

%任意边界样条
pp=csape(x,y,'complete',[1,2])    %  s'(1)=1,s'(5)=2.
subplot(2,2,2); fnplt(pp,'k'); 
title('complete');
pp=csape(x,y,'variational')        %  s''(1)=0,s''(5)=0.
subplot(2,2,3);
fnplt(pp,'k'); 
title('variational');  
