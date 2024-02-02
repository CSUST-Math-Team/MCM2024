clear;global M r q p u g lemda;
M=100;lemda=0.9;
r=[28 21 23 25 5]'/100;
q=[2.5 1.5 5.5 2.6 0]'/100;
p=[1 2 4.5 6.5 0]'/100;
u=[103 198 52 40 1]'/100;
x0=0.5*ones(length(r)+1,1)/6;
vlb=zeros(6,1);
[x options]=constr('dxz2f',x0,[],vlb,[])
