function f=myrand(n,m,t)
%  f=myrand(n,m,t)

switch t
    case 'integer'
        f=n+floor(rand(1,1)*(m+1-n));
    case 'real'
        f=n+rand(1,1)*(m+1-n);
end