function [f,t]=rep(g9,h9)%g9Ϊminroute�����е�S����·�����󣩣�h9Ϊminroute�е���Ȩ�ؾ���
                         %������������minrouteʹ�õ�
m=size(g9,2);
n=size(g9,1);t=zeros(1,m);f=[];
for j=1:m
    for i=1:n-1
         if (g9(i+1,j)==0&g9(i,j)>=1)
            v=g9(i,j);
            t(v)=h9(j);
            f(:,v)=g9(:,j);        
         end
      i=i+1;   
      if (i==n&g9(i,j)>=1)
          v=g9(i,j);
          t(v)=h9(j);
          f(:,v)=g9(:,j);  
      end  
   end
end
