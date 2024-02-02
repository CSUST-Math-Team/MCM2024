function m=gra2adj(ma)
%  m=gra2adj(ma)

n=max(ma(1:(length(ma)*2)));
m=ones(n,n)*inf;
for i=1:length(ma)
    m(ma(i,1),ma(i,2))=ma(i,3);
    m(ma(i,2),ma(i,1))=ma(i,3);
end
for i=1:n
    m(i,i)=0;
end
