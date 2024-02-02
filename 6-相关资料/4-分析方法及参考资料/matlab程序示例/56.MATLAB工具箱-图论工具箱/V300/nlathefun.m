function f=lathefun(x,n,m)
%n--examing interval
%m--Max number of products
%x--Living 
%y--average loss

num_prod=min((n*ceil(x/n)),m);
exam_times=fix(num_prod/n);
bad_prod=max(num_prod-x+1,0);
knife_fee=3000*(x<num_prod)+3000*(x==num_prod).*(num_prod~=m)+1000*(x>num_prod)+1000*(x==num_prod).*(num_prod==m);
loss=bad_prod*200+exam_times*10+knife_fee;
f=loss./num_prod;



