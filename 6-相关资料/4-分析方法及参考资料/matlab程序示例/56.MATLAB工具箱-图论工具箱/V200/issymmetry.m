function y=issymmetry(M)
%  y=issymmetry(M)

if(length(unique(size(M)))~=1)
    error('Error:The matrix must be an aquare matrix!');
end
y=1;
for i=1:length(M)
    for j=i+1:length(M)
        if(M(i,j)~=M(j,i))
            y=0;
            break;
        end
    end
end
