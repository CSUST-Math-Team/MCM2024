function [f,g]=fun(xx)
global M r q p u lemda;
xx=xx(:);len=length(xx);x=xx(1:(len-1));
y=(x>100*eps).*(x<u/M/100).*x*100+(x>=u/M/100).*max(x,u/M);
y=y.*p;
f=lemda*xx(len)-(1-lemda)*sum(r.*x-y);
g(1)=sum(x+y)-1;
g(2:(len-1))=q(1:(len-2)).*x(1:(len-2))-xx(len);g=g(:);
