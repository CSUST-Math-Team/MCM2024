function f=Warshell(w)
%  f=Warshell(w)
%  f=Warshell(w)

n=length(w);
for k=1:n
    for i=1:n
        for j=1:n
            w(i,j)=min(w(i,j),(w(i,k)+w(k,j)));
        end
    end
end
f=w;