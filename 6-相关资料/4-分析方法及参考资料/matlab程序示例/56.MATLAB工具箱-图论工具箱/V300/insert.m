function f=insert(x0,y0,x)
n=length(x0);
s=0.0;
for i=1:n
    p=1.0;
    for j=1:n
        if j~=i
            p=p.*((x-x0(j))/(x0(i)-x0(j)));
        end
    end
    s=s+y0(i).*p;
end
f=s;
        
    