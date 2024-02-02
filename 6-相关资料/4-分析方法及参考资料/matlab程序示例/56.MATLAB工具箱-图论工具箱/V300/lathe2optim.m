clear;close;
s0=[170,400];
[s,opt]=fmins('lathe2optimfun',s0);
n0=s(1),m0=s(2),minfee=opt(8)
