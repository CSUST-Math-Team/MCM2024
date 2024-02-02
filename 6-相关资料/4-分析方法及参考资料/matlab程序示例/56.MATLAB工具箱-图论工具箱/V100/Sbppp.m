function [result,msum]=Sbppp(cost,m)
%  [result,msum]=Sbppp(cost,m)
%  [result,msum]=Sbppp(cost,m)
            
            if nargin==1
                dd=cost;
            else
                dd=max(max(cost))-cost;
            end
            [nop,nop]=size(cost);msum=0;
            for i=1:nop
                dd(i,:)=dd(i,:)-min(dd(i,:));
            end
            for j=1:nop
                dd(:,j)=dd(:,j)-min(dd(:,j));
            end
            backup=dd;
            for z=1:nop
                bh=nop;bl=nop;result=[];
                for k=1:nop
                    for i=1:nop
                        h=find(dd(i,:)==0);
                        if length(h)~=0&length(h)<bh
                            bh=length(h);
                            ch=i;
                        end
                    end
                    L=find(dd(ch,:)==0);
                    for j=1:length(L)
                        l=find(dd(:,L(j))==0);
                        if length(l)<bl
                            bl=length(l);
                            cl=L(j);
                        end
                    end
                    result(1,k)=ch;result(2,k)=cl;
                    dd(ch,:)=1;dd(:,cl)=1;
                    bl=nop;bh=nop;
                    if length(find(dd==0))==0
                        break
                    end
                end
                if length(result(1,:))==nop
                    break
                end
                dd=backup;DD=dd;d=zeros(nop);
                for i=1:length(result(1,:))
                    d(result(1,i),result(2,i))=1;
                end
                D=~(d+dd);
                p=[];q=[];k=1;zx=inf;
                for i=1:nop
                    if sum(d(i,:))==0
                        p(k)=i;
                        k=k+1;
                    end
                end
                for j=1:length(p)
                    q=find(D(p(j),:)==1);
                    for e=1:length(q)
                        pp=find(d(:,q(e))==1);
                        if pp~=0
                            p(k)=pp;
                            k=k+1;
                        end
                     end
                 end
                 for l=1:length(p)
                     q=find(D(p(l),:)==1);
                     for u=1:length(q)
                         DD(:,q(u))=inf;
                     end
                 end
                 for l=1:length(p)
                     if min(DD(p(l),:))<zx
                             zx=min(DD(p(l),:));
                     end
                 end
                 for l=1:length(p)
                     q=find(D(p(l),:)==1);
                     for u=1:length(q)
                         dd(:,q(u))=dd(:,q(u))+zx;
                     end
                 end
                 for l=1:length(p)
                     dd(p(l),:)=dd(p(l),:)-zx;
                 end
                 backup=dd;
            end
              for i=1:length(result(1,:))
                 msum=msum+cost(result(1,i),result(2,i));
            end