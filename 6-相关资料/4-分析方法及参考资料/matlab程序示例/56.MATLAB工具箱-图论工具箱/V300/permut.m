function y=permut(n)
maple('with(combinat):');
y1=eval(maple(['permute(',int2str(n),')']));
n1=eval(maple(['numbperm(',int2str(n),')']));
y=reshape(y1,[n,n1])';