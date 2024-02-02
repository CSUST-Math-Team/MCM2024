function y=RightRotate(L,n)
%The function can help you for rotate 1*N matrix!
for i=1:length(L)
    y(i)=L(length(L)-mod(n-i,length(L)));
end
