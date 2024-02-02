function Fitness=Fitness(x,FARM,e,q,w) 
%����һ������200��01���߱����Ķ�Ŀ������������滮����д�Ż���Ŀ�꺯�����£�
%���н���Ŀ��ת��Ϊ��Ŀ����ü򵥵ļ�Ȩ���� 
%  Fitness=Fitness(x,FARM,e,q,w) 
%% ��Ӧ�Ⱥ��� 
% ��������б� 
% x ���߱������ɵ�4��50��0-1���� 
% FARM ϸ���ṹ�洢�ĵ�ǰ��Ⱥ���������˸���x 
% e 4��50��ϵ������ 
% q 4��50��ϵ������ 
% w 1��50��ϵ������ 

                  gamma=0.98; 
                  N=length(FARM);%��Ⱥ��ģ 
                  F1=zeros(1,N); 
                  F2=zeros(1,N); 
                  for i=1:N 
                  xx=FARM{i}; 
                  ppp=(1-xx)+(1-q).*xx; 
                  F1(i)=sum(w.*prod(ppp)); 
                  F2(i)=sum(sum(e.*xx)); 
                  end 
                  ppp=(1-x)+(1-q).*x; 
                  f1=sum(w.*prod(ppp)); 
                  f2=sum(sum(e.*x)); 
Fitness=gamma*sum(min([sign(f1-F1);zeros(1,N)]))+(1-gamma)*sum(min([sign(f2-F2);zeros(1,N)])); 

function [Xp,LC1,LC2,LC3,LC4]=MYGA(M,N,Pm) 
%%���������Ƶ��Ŵ��㷨���£����ж�ģ��Լ���Ĵ������ص㿼�ǵĵط�
%% ���01�����滮���Ŵ��㷨 
%% ��������б� 
% M �Ŵ������������� 
% N ��Ⱥ��ģ 
% Pm ������� 
%% ��������б� 
% Xp ���Ÿ��� 
% LC1 ��Ŀ��1���������� 
% LC2 ��Ŀ��2���������� 
% LC3 ƽ����Ӧ�Ⱥ������������� 
% LC4 ������Ӧ�Ⱥ������������� 
%% �ο����ø�ʽ[Xp,LC1,LC2,LC3,LC4]=MYGA(50,40,0.3) 

                  %% ��һ�����������ݺͱ�����ʼ�� 
                  load eqw;%��������ϵ������e,q,w 
                  %���������ʼ�� 
                  Xp=zeros(4,50); 
                  LC1=zeros(1,M); 
                  LC2=zeros(1,M); 
                  LC3=zeros(1,M); 
                  LC4=zeros(1,M); 
                  Best=inf; 

                  %% �ڶ��������������ʼ��Ⱥ 
                  farm=cell(1,N);%���ڴ洢��Ⱥ��ϸ���ṹ 
                  k=0; 
                  while k %������һ���Ϸ�����Ĳ������� 
                  x=zeros(4,50);%xÿһ�е�1�ĸ���������� 
                  for i=1:50 
                  R=rand; 
                  Col=zeros(4,1); 
                  if R<0.7 
                  RP=randperm(4);%1��λ��Ҳ������� 
                  Col(RP(1))=1; 
                  elseif R>0.9 
                  RP=randperm(4); 
                  Col(RP(1:2))=1; 
                  else 
                  RP=randperm(4); 
                  Col(RP(1:3))=1; 
                  end 
                  x(:,i)=Col; 
                  end 
                  %�����Ǽ���к��Ƿ�����Լ���Ĺ��̣����ڲ�����Լ������������ 
                  Temp1=sum(x,2); 
                  Temp2=find(Temp1>20); 
                  if length(Temp2)==0 
                  k=k+1; 
                  farm{k}=x; 
                  end 
                  end 

                  %% �����ǽ����������� 
                  counter=0;%���õ��������� 
                  while counter 

                  %% ������������ 
                  %�������˫��˫�ӵ��㽻�� 
                  newfarm=cell(1,2*N);%���ڴ洢�Ӵ���ϸ���ṹ 
                  Ser=randperm(N);%���������Ե���Ա� 
                  A=farm{Ser(1)};%ȡ������A 
                  B=farm{Ser(2)};%ȡ������B 
                  P0=unidrnd(49);%���ѡ�񽻲�� 
                  a=[A(:,10),B(:,(P0+1):end)];%�����Ӵ�a 
                  b=[B(:,10),A(:,(P0+1):end)];%�����Ӵ�b 
                  newfarm{2*N-1}=a;%�����Ӵ���Ⱥ 
                  newfarm{2*N}=b; 
                  %����ѭ�����ظ��������� 
                  for i=1N-1) 
                  A=farm{Ser(i)}; 
                  B=farm{Ser(i+1)}; 
                  P0=unidrnd(49); 
                  a=[A(:,10),B(:,(P0+1):end)]; 
                  b=[B(:,10),A(:,(P0+1):end)]; 
                  newfarm{2*i-1}=a; 
                  newfarm{2*i}=b; 
                  end 
                  FARM=[farm,newfarm];%�¾���Ⱥ�ϲ� 

                  %% ���Ĳ���ѡ���� 
                  FLAG=ones(1,3*N);%��־���������Ƿ�����Լ�����б�� 
                  %���¹����Ǽ���¸����Ƿ�����Լ�� 
                  for i=13*N) 
                  x=FARM{i}; 
                  sum1=sum(x,1); 
                  sum2=sum(x,2); 
                  flag1=find(sum1==0); 
                  flag2=find(sum1==4); 
                  flag3=find(sum2>20); 
                  if length(flag1)+length(flag2)+length(flag3)>0 
                  FLAG(i)=0;%���������Լ������0���Ա�� 
                  end 
                  end 
                  NN=length(find(FLAG)==1);%����Լ���ĸ�����Ŀ����һ�����ڵ���N 
                  NEWFARM=cell(1,NN); 
                  %���¹������޳�������Լ���ĸ��� 
                  kk=0; 
                  for i=13*N) 
                  if FLAG(i)==1 
                  kk=kk+1; 
                  NEWFARM{kk}=FARM{i}; 
                  end 
                  end 
                  %���¹����Ǽ��㲢�洢��ǰ��Ⱥÿ���������Ӧֵ 
                  SYZ=zeros(1,NN); 
                  syz=zeros(1,N); 
                  for i=1:NN 
                  x=NEWFARM{i}; 
                  SYZ(i)=FITNESS2(x,NEWFARM,e,q,w);%������Ӧֵ�Ӻ��� 
                  end 
                  k=0; 
                  %������ѡ���ƣ�ѡ����ŵ�N�����帴�Ƶ���һ�� 
                  while k minSYZ=min(SYZ); 
                  posSYZ=find(SYZ==minSYZ); 
                  POS=posSYZ(1); 
                  k=k+1; 
                  farm{k}=NEWFARM{POS}; 
                  syz(k)=SYZ(POS); 
                  SYZ(POS)=inf; 
                  end 
                  %��¼�͸��£��������Ÿ��壬��¼�������ߵ����� 
                  minsyz=min(syz); 
                  meansyz=mean(syz); 
                  pos=find(syz==minsyz); 
                  LC3(counter+1)=meansyz; 
                  if minsyz Best=minsyz; 
                  Xp=farm{pos(1)}; 
                  end 
                  LC4(counter+1)=Best; 
                  ppp=(1-Xp)+(1-q).*Xp; 
                  LC1(counter+1)=sum(w.*prod(ppp)); 
                  LC2(counter+1)=sum(sum(e.*Xp)); 

                  %% ���岽������ 
                  for i=1:N 
                  if Pm>rand%�Ƿ�����ɱ������Pm���� 
                  AA=farm{i};%ȡ��һ������ 
                  POS=unidrnd(50);%���ѡ�����λ 
                  R=rand; 
                  Col=zeros(4,1); 
                  if R<0.7 
                  RP=randperm(4); 
                  Col(RP(1))=1; 
                  elseif R>0.9 
                  RP=randperm(4); 
                  Col(RP(1:2))=1; 
                  else 
                  RP=randperm(4); 
                  Col(RP(1:3))=1; 
                  end 
                  %�������жϱ���������¸����Ƿ�����Լ������������㣬�˴α�����Ч 
                  AA(:,POS)=Col; 
                  Temp1=sum(AA,2); 
                  Temp2=find(Temp1>20); 
                  if length(Temp2)==0 
                  farm{i}=AA; 
                  end 
                  end 
                  end 

                  counter=counter+1 
                  end 

                  %���߲�������������ͼ 
                  figure(1); 
                  plot(LC1); 
                  xlabel('��������'); 
                  ylabel('��Ŀ��1��ֵ'); 
                  title('��Ŀ��1����������'); 
                  figure(2); 
                  plot(LC2); 
                  xlabel('��������'); 
                  ylabel('��Ŀ��2��ֵ'); 
                  title('��Ŀ��2����������'); 
                  figure(3); 
                  plot(LC3); 
                  xlabel('��������'); 
                  ylabel('��Ӧ�Ⱥ�����ƽ��ֵ'); 
                  title('ƽ����Ӧ�Ⱥ�������������'); 
                  figure(4); 
                  plot(LC4); 
                  xlabel('��������'); 
                  ylabel('��Ӧ�Ⱥ���������ֵ'); 
                  title('������Ӧ�Ⱥ�������������'); 
