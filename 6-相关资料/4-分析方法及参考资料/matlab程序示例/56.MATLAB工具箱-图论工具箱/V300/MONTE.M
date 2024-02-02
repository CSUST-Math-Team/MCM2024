%MonteCarlo法解最优化的例
clear;
vmax=-inf;
x2=specrnd(10:20,[],1,5);
x3=specrnd(-5:16,[],1,5);
for i=1:5
   for j=1:5
      if x2(i)+2*x3(j)>=10&3*x2(i)+2*x3(j)<=62,
         v=(x2(i)+10)*x2(i)*x3(j);
         if v>vmax,
            vmax=v;x20=x2(i);x30=x3(j);
         end
      end
   end
end
x1=x20+10,x2=x20,x3=x30
vmax
