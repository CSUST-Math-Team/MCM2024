function flag=reside(x,a)
%  flag=reside(x,a)
%  flag=reside(x,a)

flag=0;
for i=1:length(a)
    if x==a(i)
        flag=1;
        break;
    end
end