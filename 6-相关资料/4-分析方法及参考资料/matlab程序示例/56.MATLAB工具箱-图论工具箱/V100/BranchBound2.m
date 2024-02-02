function [y,fval]=BranchBound2(c,A,b,Aeq,beq)
%%本程序是用分枝定界法求解整数线性规划问题
%%[y,fval]=BranchBound2(c,A,b,Aeq,beq)
%%问题的标准形式：
%%min c'*x
%%s.t. A*x<=b
%%Aeq*x=beq
%%x要求是整数
%%程序的编写者：快乐逍遥侠
%%程序的最后修改时间是：2007-11-24
      
      NL=length(c);
      UB=inf;
      LB=-inf;
      FN=[0];
      AA(1)={A};
      BB(1)={b};
      k=0;
      flag=0;
      while flag==0;
      [x,fval,exitFlag]=linprog(c,A,b,Aeq,beq);
      if (exitFlag == -2) | (fval >= UB) 
      FN(1)=[];
      if isempty(FN)==1
      flag=1;
      else
      k=FN(1);
      A=AA{k};
      b=BB{k};
      end
      else
       for i=1:NL
       if abs(x(i)-round(x(i)))>1e-7
       kk=FN(end);
       FN=[FN,kk+1,kk+2];
       temp_A=zeros(1,NL);
       temp_A(i)=1;
       temp_A1=[A;temp_A];
       AA(kk+1)={temp_A1};
       b1=[b;fix(x(i))];
       BB(kk+1)={b1};
       temp_A2=[A;-temp_A];
       AA(kk+2)={temp_A2};
       b2=[b;-(fix(x(i))+1)];
       BB(kk+2)={b2};
       FN(1)=[];
       k=FN(1);
       A=AA{k};
       b=BB{k};
       break;
       end
       end
       if (i==NL) & (abs(x(i)-round(x(i)))<=1e-7)
       UB=fval;
       y=x;
       FN(1)=[];
       if isempty(FN)==1
       flag=1;
       else
       k=FN(1);
       A=AA{k};
       b=BB{k};
       end
       end
       end
      end
      y=round(y);
      fval=c*y; 
%Feedback