function [f]=min_max(C,b,f) 
%最小代价的负回路算法 
% 求给定流值m的流f。(1--> n) 
%给出流值m的初始流f0,如果m不是最大流，可以通过调低边容量的方法用最大流程序得到初始流 
%所以假定初始流f0已知 
%C=[0 15 16 0 0 
%0 0 0 13 14 
%0 11 0 17 0 
%0 0 0 0 8 
%0 0 0 0 0];%容量网络 
%b=[0 4 1 0 0 
%   0 0 0 6 1 
%   0 2 0 3 0 
%   0 0 0 0 2 
%   0 0 0 0 0];%费用网络 
n=length(C); 
while(1)%找到负回路调整流以后重新开始 
     Nf=C-f;Nf=Nf+f';%流量的伴随网络,随着流的调整在改变 
     Nb=b-b'; 
     for i=1:n%流量对应费用的伴随网络,随着流的调整在改变 
        for j=1:n 
           if Nf(i,j)==0 
              b(i,j)=0; 
          end 
        end 
     end 
     for i=1:n%作为起点开始搜索包含这个顶点的回路 
         flag1=1; 
         T=i;%用于搜索还没有归入R的子顶点 
         R=[];%当前点以前被搜索过的点 
         L=[];%标号用于判断是不是回路并确定回路  
         while(flag1)%如果当前生长点有多个子顶点 
              T_R=setdiff(T,R);s=length(T_R); 
              if s==0%没有向后有流量的路了，改变起点 
              break;%跳到外层for 
              end 
              u=T_R(1);%往后搜索有多个生长点取第一个 
              while(1)%向后搜索 
                   Tc=setdiff(1:n,T);Tc=union(Tc,i);%可以搜索i 
                   for k=1:length(Tc) 
                       flag=1;%如果找不到后继顶点，将作为返回的标记 
                       v=Tc(k); 
                       if Nf(u,v)>0 
                          flag=0;%找到了后继顶点 
                          T=union(T,v); 
                          L(v)=u;  
                          if v==i 
                             m=i;t=-m;%先暂时赋值不会等于i的数 
                             q=0;ff=inf; 
                             while(t~=i) %逆向追踪求i-->i的圈 
                                  t=L(m); 
                                  q=q+Nb(m,t);%回路上的费用和，判断是不是负回路 
                                  ff=min(ff,Nf(m,t)); 
                                  m=t; 
                             end 
                             if q<0%是负回路 
                                m=i;t=-m; 
                                while(t~=i) %修改流量 
                                     t=L(m); 
                                     if f(t,m)>0 
                                        f(t,m)=f(m,t)-ff; 
                                     end 
                                     f(m,t)=f(m,t)+ff;  
                                      m=t; 
                                end 
                                flag=1;flag1=0; 
                                break;%跳到最外层的while进行循环 
                             else%不是负回路 
                                T=setdiff(T,i);%不能走向i，退出来找下一个子顶点 
                             end 
                           end 
                       end 
                   end%内层for结束 
                   if flag%找不到后继顶点, 跳到第二层while换顶点（不是起点）搜索 
                   R=union(R,u); 
                   break; 
                   end 
              end%第三个while结束 
       end%第二个while结束 
       if flag1==0 
           break; 
       end 
   end%for结束 
end%第一个while结束  
