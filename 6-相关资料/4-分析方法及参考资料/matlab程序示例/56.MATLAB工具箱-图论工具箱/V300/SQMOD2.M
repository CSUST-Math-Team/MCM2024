clear;
vlb=[0.075,0.225,0.075,0.075,1.125,12,0.5625];
vub=[0.125,0.375,0.125,0.125,1.875,20,0.935];
option=[];
a0=[0.1,0.3,0.1,0.1,1.5,16,0.75];
[a,options]=constr('sqfun',a0,option,vlb,vub);
a


cc=[0.05,0.05,0.05;
0.1,0.05,0.05;
0.1,0.05,0.01;
0.1,0.05,0.01;
0.1,0.1,0.1;
0.1,0.05,0.01;
0.05,0.05,0.01]

minfee=feefun02(a0,cc(:,1)')
minb=[1,1,1,1,1,1,1];
    c(1)=cc(1,2); c(5)=cc(5,1);
      for j2=1:2
        c(2)=cc(2,j2);
          for j3=1:3
            c(3)=cc(3,j3);
              for j4=1:3
                c(4)=cc(4,j4);
                     for j6=1:3
                        c(6)=cc(6,j6);
                           for j7=2:3
                             c(7)=cc(7,j7);
                           
                           fe=feefun02(a,c);
                           if (minfee>fe )
                             minfee=fe;
                             minb= [2,j2,j3,j4,1,j6,j7];
                            end;end;
end;end;end;end;

minfee
minb