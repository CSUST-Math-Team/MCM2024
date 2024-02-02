function f=listopt(x,y,z)
%form f=listopt(x,y,z)
%the z:
%union——交集
%Intersection——并集
%Complement——差集
switch z
    case 'union'
          k=length(x)+1;b=x;
      for i=1:length(y)
          for j=1:length(x)
              if y(i)==x(j)
                  break;
              else
                  b(k)=y(i);
              end
          end
      end
          f=sort(b)
    case 'intersection'
           k=1;b=[];
      for i=1:length(y)
          for j=1:length(x)
              if y(i)==x(j)
                  break;
              end
          end
          if j<=length(x)
              b(k)=y(i);
              k=k+1;
          end
      end
     f=sort(b)
    case 'complement'
        k=1;b=[];
        for i=1:length(x)
            for j=1:length(y)
                if x(i)==y(j)
                    break;
                end
            end      
            if j+1>length(x)
                b(k)=x(i);
                k=k+1
            end
        end
        f=sort(b);
    otherwise
        fprintf('There''s no ''%s'' in this functon!\n',z)
end
