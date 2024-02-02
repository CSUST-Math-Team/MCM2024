function f=lathefun(x,n,m)
%n--examing interval
%m--Max number of products
%x--Living 
%y--average loss

num_prod=min((n*ceil(x/n)),m);
exam_times=[num_prod/n];

%num_prod=min(x+n,m);
%exam_times=num_prod/n;
bad_prod=max(num_prod-x+1,0);
knife_fee=3000*(x<=num_prod)+1000*(x>=num_prod+0.1)+(3000-20000*(x-num_prod)).*(x>num_prod).*(x<num_prod+0.1);
loss=bad_prod*200+exam_times*10+knife_fee;
f=loss/num_prod;



