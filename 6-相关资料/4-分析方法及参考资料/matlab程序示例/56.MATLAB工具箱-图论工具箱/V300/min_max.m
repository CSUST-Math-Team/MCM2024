function [f]=min_max(C,b,f) 
%��С���۵ĸ���·�㷨 
% �������ֵm����f��(1--> n) 
%������ֵm�ĳ�ʼ��f0,���m���������������ͨ�����ͱ������ķ��������������õ���ʼ�� 
%���Լٶ���ʼ��f0��֪ 
%C=[0 15 16 0 0 
%0 0 0 13 14 
%0 11 0 17 0 
%0 0 0 0 8 
%0 0 0 0 0];%�������� 
%b=[0 4 1 0 0 
%   0 0 0 6 1 
%   0 2 0 3 0 
%   0 0 0 0 2 
%   0 0 0 0 0];%�������� 
n=length(C); 
while(1)%�ҵ�����·�������Ժ����¿�ʼ 
     Nf=C-f;Nf=Nf+f';%�����İ�������,�������ĵ����ڸı� 
     Nb=b-b'; 
     for i=1:n%������Ӧ���õİ�������,�������ĵ����ڸı� 
        for j=1:n 
           if Nf(i,j)==0 
              b(i,j)=0; 
          end 
        end 
     end 
     for i=1:n%��Ϊ��㿪ʼ���������������Ļ�· 
         flag1=1; 
         T=i;%����������û�й���R���Ӷ��� 
         R=[];%��ǰ����ǰ���������ĵ� 
         L=[];%��������ж��ǲ��ǻ�·��ȷ����·  
         while(flag1)%�����ǰ�������ж���Ӷ��� 
              T_R=setdiff(T,R);s=length(T_R); 
              if s==0%û�������������·�ˣ��ı���� 
              break;%�������for 
              end 
              u=T_R(1);%���������ж��������ȡ��һ�� 
              while(1)%������� 
                   Tc=setdiff(1:n,T);Tc=union(Tc,i);%��������i 
                   for k=1:length(Tc) 
                       flag=1;%����Ҳ�����̶��㣬����Ϊ���صı�� 
                       v=Tc(k); 
                       if Nf(u,v)>0 
                          flag=0;%�ҵ��˺�̶��� 
                          T=union(T,v); 
                          L(v)=u;  
                          if v==i 
                             m=i;t=-m;%����ʱ��ֵ�������i���� 
                             q=0;ff=inf; 
                             while(t~=i) %����׷����i-->i��Ȧ 
                                  t=L(m); 
                                  q=q+Nb(m,t);%��·�ϵķ��úͣ��ж��ǲ��Ǹ���· 
                                  ff=min(ff,Nf(m,t)); 
                                  m=t; 
                             end 
                             if q<0%�Ǹ���· 
                                m=i;t=-m; 
                                while(t~=i) %�޸����� 
                                     t=L(m); 
                                     if f(t,m)>0 
                                        f(t,m)=f(m,t)-ff; 
                                     end 
                                     f(m,t)=f(m,t)+ff;  
                                      m=t; 
                                end 
                                flag=1;flag1=0; 
                                break;%����������while����ѭ�� 
                             else%���Ǹ���· 
                                T=setdiff(T,i);%��������i���˳�������һ���Ӷ��� 
                             end 
                           end 
                       end 
                   end%�ڲ�for���� 
                   if flag%�Ҳ�����̶���, �����ڶ���while�����㣨������㣩���� 
                   R=union(R,u); 
                   break; 
                   end 
              end%������while���� 
       end%�ڶ���while���� 
       if flag1==0 
           break; 
       end 
   end%for���� 
end%��һ��while����  
