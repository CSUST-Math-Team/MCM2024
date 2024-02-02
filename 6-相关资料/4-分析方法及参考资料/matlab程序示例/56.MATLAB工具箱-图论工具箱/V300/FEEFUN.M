function fee=feefun(a,b)
%这里 a 是标定值向量，b是相对容差向量，loss是损失
loss=0;
for i=1:1000
  for j=1:7
    x(j)=a(j)+a(j)*b(j)/3*randn(1,1);
  end;
  y=sqfun0(x);
  if (abs(y-1.5)>0.3)
    loss=loss+9000;
   elseif((abs(y-1.5)>0.1)&(abs(y-1.5)<0.3))
    loss=loss+1000;
  end;
end;
cost=0;
c(1)=25;
if(b(2)==0.1) 
  c(2)=20;
 else 
  c(2)=50;
end;
if (b(3)==0.1)
  c(3)=20;
 elseif (b(3)==0.05)
  c(3)=50; 
 else c(3)=200;
end;
if (b(4)==0.1)
  c(4)=50;
 elseif (b(4)==0.05)
  c(4)=100;
 else c(4)=500;
end;
c(5)=50;
if(b(6)==0.05)
  c(6)=25;
 elseif (b(6)==0.1)
  c(6)=10;
 else 
  c(6)=100;
end;
 if (b(7)==0.05)
  c(7)=25;
 else
 c(7)=100;
end;
for i=1:7
  cost=cost+c(i);
end;
cost=cost*1000;
fee=cost+loss; 
