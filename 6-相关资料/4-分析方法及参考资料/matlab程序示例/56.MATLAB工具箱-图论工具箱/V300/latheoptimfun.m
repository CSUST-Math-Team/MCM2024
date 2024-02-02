function f=latheoptimfun(n)
x=0.1:0.1:1200;
y=lathefun(x,n(1),n(2)).*normpdf(x,600,196.6292);
f=trapz(x,y);

