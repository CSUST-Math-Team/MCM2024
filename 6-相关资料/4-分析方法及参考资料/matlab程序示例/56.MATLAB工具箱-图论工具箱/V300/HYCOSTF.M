function y=hycostf(order,r,e)
x=[10,14.5,19];
l=[6,7,6];
k=[1,5.5,9];
y=0;
i=1;
if order(i)==1
  x(1)=x(1)-l(1);
  l(1)=0;
  y=y+x(2)*x(3);
 
elseif  order(i)==2
  x(1)=x(1)-k(1);
  k(1)=0;
  y=y+x(2)*x(3);
 
elseif order(i)==3
  x(2)=x(2)-l(2);
  l(2)=0;
  y=y+x(1)*x(3);
 
elseif order(i)==4
  x(2)=x(2)-k(2);
  k(2)=0;
  y=y+x(1)*x(3);
  
elseif order(i)==5
  x(3)=x(3)-l(3);
  l(3)=0;
  y=y+x(1)*x(2)*r;

elseif order(i)==6
  x(3)=x(3)-k(3);
  k(3)=0;
  y=y+x(1)*x(2)*r;
end;


i=2;
if order(i)==1
  x(1)=x(1)-l(1);
  l(1)=0;
  y=y+x(2)*x(3);
  if(order(i-1)==3)|(order(i-1)==4)
   y=y+e;
  end;
elseif  order(i)==2
  x(1)=x(1)-k(1);
  k(1)=0;
  y=y+x(2)*x(3);
  if (order(i-1)==3)|(order(i-1)==4)
   y=y+e;
  end;
elseif order(i)==3
  x(2)=x(2)-l(2);
  l(2)=0;
  y=y+x(1)*x(3);
 if(order(i-1)==1)|(order(i-1)==2)
   y=y+e; 
 end;
elseif order(i)==4
  x(2)=x(2)-k(2);
  k(2)=0;
  y=y+x(1)*x(3);
  if(order(i-1)==1)|(order(i-1)==2)
   y=y+e; 
  end;
elseif order(i)==5
  x(3)=x(3)-l(3);
  l(3)=0;
  y=y+x(1)*x(2)*r;

elseif order(i)==6
  x(3)=x(3)-k(3);
  k(3)=0;
  y=y+x(1)*x(2)*r;
end;



for i=3:6
if order(i)==1
  x(1)=x(1)-l(1);
  l(1)=0;
  y=y+x(2)*x(3);
  if(order(i-1)==3)|(order(i-1)==4)
     y=y+e;
  elseif(order(i-1)==5)&((order(i-2)==3)|(order(i-2)==4))
     y=y+e;
   end;
elseif  order(i)==2
  x(1)=x(1)-k(1);
  k(1)=0;
  y=y+x(2)*x(3);
  if (order(i-1)==3)|(order(i-1)==4)
   y=y+e;
   elseif(order(i-1)==5)&((order(i-2)==3)|(order(i-2)==4))
     y=y+e;
   end;
elseif order(i)==3
  x(2)=x(2)-l(2);
  l(2)=0;
  y=y+x(1)*x(3);
 if(order(i-1)==1)|(order(i-1)==2)
   y=y+e; 
  elseif(order(i-1)==5)&((order(i-2)==1)|(order(i-2)==2))
     y=y+e;
  end;
elseif order(i)==4
  x(2)=x(2)-k(2);
  k(2)=0;
  y=y+x(1)*x(3);
  if(order(i-1)==1)|(order(i-1)==2)
   y=y+e; 
  elseif(order(i-1)==5)&((order(i-2)==1)|(order(i-2)==2))
     y=y+e;
  end;
elseif order(i)==5
  x(3)=x(3)-l(3);
  l(3)=0;
  y=y+x(1)*x(2)*r;

elseif order(i)==6
  x(3)=x(3)-k(3);
  k(3)=0;
  y=y+x(1)*x(2)*r;
end;
end;
  