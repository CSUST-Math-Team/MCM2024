	function fee=feefun02(a,b)
%这里 a 是标定值向量，b是相对容差向量，loss是损失
loss=0;h=0.001;
for i=1:7
  a1=a;a1(i)=a1(i)+h;
  a2=a;a2(i)=a2(i)-h;
  dy(i)=(sqfun0(a1)-sqfun0(a2))/(2*h);
end;

deltaa=a.*b/3;
s=0;
for i=1:7
  s=s+dy(i)^2*deltaa(i)^2;
end;
deltay=s^0.5;y=sqfun0(a);
phi1=quad8('normal',-5,(1.8-y)/deltay);
phi2=quad8('normal',-5,(1.2-y)/deltay);
phi3=quad8('normal',-5,(1.6-y)/deltay);
phi4=quad8('normal',-5,(1.4-y)/deltay);

loss=loss+(1-phi1+phi2)*9000;
loss=loss+(phi1-phi3+phi4-phi2)*1000;
loss=loss*1000;


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
