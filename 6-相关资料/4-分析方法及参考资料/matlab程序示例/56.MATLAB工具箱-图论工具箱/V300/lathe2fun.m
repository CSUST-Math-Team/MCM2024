function mf=lathe2fun(x,n,m)
%n--examing interval
%m--Max number of products
%x--Living 
%y--theory Examing times till fail
%f--average loss

y=0:10;
p=0.4.^y*0.6;
mf=0;
for i=1:length(y)
   num_prod=min((n*ceil(x/n)+n*y(i)),m);
   exam_times=fix(num_prod/n);
   bad_prod=max(num_prod-x+1,0);
   not_quali=bad_prod*0.6+min(x,m)*0.02;
   %mean(not_quali)
   %knife_fee=3000*(x<=num_prod)+1000*(x>num_prod);
   knife_fee=3000*(x<num_prod)+3000*(x==num_prod).*(num_prod~=m)+1000*(x>num_prod)+1000*(x==num_prod).*(num_prod==m);
   loss=not_quali*200+exam_times*10+knife_fee+fix(min(x,m)/n)*0.02*1500;
   f=loss./num_prod;
   mf=mf+f*p(i);
end


