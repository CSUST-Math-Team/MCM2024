m=5;n=5; 
A=[0 1 1 0 0 
    1 1 0 1 1 
    0 1 1 0 0 
    0 1 1 0 0 
    0 0 0 1 1]; 
M(m,n)=0; 
for (i=1:m) 
    for (j=1:n) 
        if (A(i,j)) 
            M(i,j)=1; 
            break; 
        end 
    end%���ʼƥ��M 
    if (M(i,j)) 
        break; 
    end 
end%��ý���һ���ߵĳ�ʼƥ��M 
while(1) 
    for(i=1:m) 
        x(i)=0;%����¼X�е�ı�źͱ��* 
    end 
    for(i=1:n) 
        y(i)=0;%����¼Y�еı�źͱ��* 
    end  
    for(i=1:m) 
        pd=1;%Ѱ��X��M�����зǱ��͵� 
        for(j=1:n) 
            if(M(i,j)) 
                pd=0; 
            end 
        end 
        if(pd) 
            x(i)=-n-1;%��X��M�����зǱ��͵㶼���Ա��O�ͱ��*����������n+1��ʾO��ţ����Ϊ����ʱ��ʾ���* 
        end 
    end 
    pd=0; 
    while(1) xi=0; 
        for(i=1:m) 
            if(x(i)<0) xi=i;%����X�д���һ�����б�����б��*�ĵ㣬����ȡX��һ�����б�����б��*�ĵ�xi 
                break; 
            end 
        end 
        if(xi==0) pd=1; 
            break;%����X�������б�ŵĵ㶼�Ѿ�ȥ���˱��*���㷨��ֹ 
        end 
        x(xi)=x(xi)*(-1); 
        k=1; 
        for(j=1:n) 
            if(A(xi,j)&y(j)==0) 
                y(j)=xi;yy(k)=j;k=k+1; 
            end 
        end%����xi�ڽ�����δ����ŵ�yj�����Ա��i 
        if(k>1) k=k-1; 
            for(j=1:k) pdd=1; 
                for(i=1:m) 
                    if(M(i,yy(j))) 
                        x(i)=-yy(j);pdd=0;%��yj��M����֮���ڽӵĵ�xk(��xkyj����M)�����Ա��j�ͱ��* 
                        break; 
                    end 
                end 
                if(pdd) break; 
                end 
            end 
            if(pdd) k=1;j=yy(j);%yj����M�ı��͵� 
                while(1) 
                    p(k,2)=j;p(k,1)=y(j);j=abs(x(y(j)));%��ȡM��һ���Ǳ��͵�yj�����򷵻� 
                    if(j==n+1) break; 
                    end%�ҵ�X�б��Ϊ0�ĵ�ʱ���������M-����·P 
                    k=k+1; 
                end 
                for(i=1:k) 
                    if(M(p(i,1),p(i,2))) 
                        M(p(i,1),p(i,2))=0;%��ƥ��M������·P�г��ֵı�ȥ�� 
                    else M(p(i,1),p(i,2))=1;%������·P��û����ƥ��M�г��ֵı߼��뵽ƥ��M�� 
                    end 
                end 
                break; 
            end 
        end 
    end 
    if(pd) break;%����X�����б�ŵĵ㶼��ȥ���˱��*���㷨��ֹ 
    end 
end 
M%��ʾ���ƥ��M���������
