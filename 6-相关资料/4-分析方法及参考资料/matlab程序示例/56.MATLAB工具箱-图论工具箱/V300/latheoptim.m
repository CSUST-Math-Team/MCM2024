clear;close;
s0=[10,300];
[s,opt]=fmins('latheoptimfun',s0);
n0=s(1),m0=s(2),minfee=opt(8)
