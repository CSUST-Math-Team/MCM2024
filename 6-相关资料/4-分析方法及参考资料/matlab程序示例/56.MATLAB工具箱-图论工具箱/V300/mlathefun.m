function mf=mlathefun(n)
%x=0.001:0.1:1200;
mf=(6000+200*n(1))*quad8('mintfun',0.001,n(2)-n(1)/2,[],[],n(1));
mf=mf-200/n(2)*quad8('mintfun2',n(2)-n(1)/2,n(2));
mf=mf+(3000/n(2)+200)*(normcdf(n(2),600,196.6292)-normcdf(n(2)-n(1)/2,600,196.6292));
mf=mf+1000/n(2)*(1-normcdf(n(2),600,196.6292));
mf=mf+10/n(1);


