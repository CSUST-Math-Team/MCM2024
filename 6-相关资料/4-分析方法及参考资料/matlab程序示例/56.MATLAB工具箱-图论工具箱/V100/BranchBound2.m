function [y,fval]=BranchBound2(c,A,b,Aeq,beq)
%%���������÷�֦���編����������Թ滮����
%%[y,fval]=BranchBound2(c,A,b,Aeq,beq)
%%����ı�׼��ʽ��
%%min c'*x
%%s.t. A*x<=b
%%Aeq*x=beq
%%xҪ��������
%%����ı�д�ߣ�������ң��
%%���������޸�ʱ���ǣ�2007-11-24
      
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