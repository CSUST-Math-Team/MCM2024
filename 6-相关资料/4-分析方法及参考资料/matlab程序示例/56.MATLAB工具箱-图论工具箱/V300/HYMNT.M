function y=hymnt(r,e)
mincost=500;minorder=8;
for i=1:1000
    order=[randperm(5),6];
    cost=hycostf(order,r,e);
  if cost<mincost
    mincost=cost;
    minorder=order  ;
  end;
end;
mincost
minorder
