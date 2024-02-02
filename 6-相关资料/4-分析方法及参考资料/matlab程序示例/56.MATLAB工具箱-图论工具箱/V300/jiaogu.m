function jiaogu(n)
if n<1
    fprintf('Input error!\n');
elseif floor(n)~=n
    fprintf('Input error!\n');
else
    if n==1
        fprintf('%d\n',n);
    elseif floor(n/2)==n/2
        fprintf('%d/2=%d\n',n,n/2);
        jiaogu(n/2);
    else
        fprintf('%d*3+1=%d\n',n,3*n+1);
        jiaogu(3*n+1);
      
    end
end

        
        
    