tdata=linspace(100,1000,10);
cdata=1e-05.*[459 499 535 565 590 610 626 639 650 659];
x0=[0.2,0.05,0.05];
x=curvefit('curvefun',x0,tdata,cdata)<i