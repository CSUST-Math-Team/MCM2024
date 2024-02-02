function [x,val]=ilinprog(n,f,a,b,aeq,beq,lb,ub)
%整数规划分支定界算法matlab通用源程序
%  [x,val]=ilinprog(n,f,a,b,aeq,beq,lb,ub)
%各参数的意义同matlab优化工具箱的线性规划函数linprog
%调用前，输入参数要化成matlab的标准形式
                        
                        x=zeros(n,1);
                        x1=zeros(n,1);
                        m1=2;
                        m2=1;
                        [x1,val1]=linprog(f,a,b,aeq,beq,lb,ub);
                        if (x1==0)
                        x=x1;
                        val=val1;
                        elseif (round(x1)==x1)
                        x=x1;
                        val=val1;
                        else
                        e1={0,a,b,aeq,beq,lb,ub,x1,val1};
                        e(1,1)={e1};
                        zl=0;
                        zu=-val1;
                        while (zu~=zl)
                        for c=1:1:m2
                        if (m1~=2)
                        if (cell2mat(e{m1-1,c}(1))==1)
                        e1={1,[],[],[],[],[],[],[],0};
                        e(m1,c*2-1)={e1};
                        e(m1,c*2)={e1};
                        continue;
                        end;
                        end;
                        x1=cell2mat(e{m1-1,c}(8));
                        x2=zeros(n,1);
                        s=0;
                        s1=1;
                        s2=1;
                        lb1=cell2mat(e{m1-1,c}(6));
                        ub1=cell2mat(e{m1-1,c}(7));
                        lb2=cell2mat(e{m1-1,c}(6));
                        ub2=cell2mat(e{m1-1,c}(7));
                        for d=1:1:n
                        if (abs((round(x1(d))-x1(d)))>0.0001)&(s==0)
                        s=1;
                        lb1(d)=fix(x1(d))+1;
                        if (a*lb1<=b)
                        s1=0;
                        end;
                        ub2(d)=fix(x1(d));
                        if (a*lb2<=b)
                        s2=0;
                        end;
                        end;
                        end;
                        e1={s1,a,b,aeq,beq,lb1,ub1,[],0};
                        e2={s2,a,b,aeq,beq,lb2,ub2,[],0};
                        e(m1,c*2-1)={e1};
                        e(m1,c*2)={e2};
                        end;
                        m1=m1+1;
                        m2=m2*2;
                        for c=1:1:m2
                        if (cell2mat(e{m1-1,c}(1))==0)
[x1,val1]=linprog(f,cell2mat(e{m1-1,c}(2)),cell2mat(e{m1-1,c}(3)),cell2mat(e{m1-1,c}(4)),cell2mat(e{m1-1,c}(5)),cell2mat(e{m1-1,c}(6)),cell2mat(e{m1-1,c}(7)));
e1={cell2mat(e{m1-1,c}(1)),cell2mat(e{m1-1,c}(2)),cell2mat(e{m1-1,c}(3)),cell2mat(e{m1-1,c}(4)),cell2mat(e{m1-1,c}(5)),cell2mat(e{m1-1,c}(6)),cell2mat(e{m1-1,c}(7)),x1,val1};
                        e(m1-1,c)={e1};
                        end;
                        z=val1;
                        if ((-z)<(-zl))
                        e1={1,[],[],[],[],[],[],[],0};
                        e(m1-1,c)={e1};
                        elseif (abs(round(x1)-x1)<=0.0001)
                        zl=z;
                        end;
                        end;
                        for c=1:1:m2
                        if (cell2mat(e{m1-1,c}(1))==0) 
                        zu=cell2mat(e{m1-1,c}(9));
                        end;
                        end;
                        for c=1:1:m2
                        if (-cell2mat(e{m1-1,c}(9))>(-zu))
                        zu=cell2mat(e{m1-1,c}(9));
                        end;
                        end;
                        end;
                        for c=1:1:m2
                        if (cell2mat(e{m1-1,c}(1))==0)&(cell2mat(e{m1-1,c}(9))==zu)
                        x=cell2mat(e{m1-1,c}(8));
                        end;
                        end;
                        val=zu;
                        end; 
                        