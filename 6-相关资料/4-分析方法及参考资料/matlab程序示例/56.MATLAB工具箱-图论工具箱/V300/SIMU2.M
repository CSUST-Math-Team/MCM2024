clear;
data=normrnd(600,196.6292,1,10000);
out=find((data>1200)|(data<=0));
data(out)=[];
minfee=inf;
for n=20
   for m=315
      f=mean(test2fun(data,n,m));
      if f<minfee
         minfee=f;
         n0=n;m0=m;
      end
   end
end
n0,m0,minfee

      