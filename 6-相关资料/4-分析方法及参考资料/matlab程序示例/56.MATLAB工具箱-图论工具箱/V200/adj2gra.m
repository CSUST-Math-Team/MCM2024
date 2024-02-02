function Gra=adj2gra(Adj)
%  Gra=adj2gra(Adj)
%The function using is designed for transforming Graph Matrix from Adjanency Matrix!
%  Gra=adj2gra(Adj)
%The function using is designed for transforming Graph Matrix from Adjanency Matrix!

Gra=[];
if(issymmetry(Adj))
    for i=1:length(Adj)
        for j=i+1:length(Adj)
            if(i~=j&Adj(i,j)~=inf)
                Gra=[Gra;i j Adj(i,j)];
            end
        end
    end
else
    for i=1:length(Adj)
        for j=1:length(Adj)
            if(i~=j&Adj(i,j)~=inf)
                Gra=[Gra;i j Adj(i,j)];
            end
        end
    end
end