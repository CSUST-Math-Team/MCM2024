clear;load mktptn;
data=[people gdp wags consume ads 1./cpm];
w=[25 20 20 20 10 5];
tdata=trim(data,3);
tm=mean(tdata);tsig=std(tdata);
ndata=(data-ones(84,1)*tm)./(ones(84,1)*tsig);
t=ndata*w'