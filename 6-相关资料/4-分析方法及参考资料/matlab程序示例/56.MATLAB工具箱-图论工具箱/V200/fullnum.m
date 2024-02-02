function b=fullnum(n)
%  b=fullnum(n)

if n~=floor(n)||n<=0||n>9999
    fprintf('Error:The number is not allowed float-point,less than 0 or large 9999!\n');
    return;
end
b={};
for i=1:n
    if i<10^floor(log10(n))
        b{i}=strcat(char(ones(1,floor(log10(n))-floor(log10(i)))*48),int2str(i));
    else
        b{i}=int2str(i);
    end
end
end