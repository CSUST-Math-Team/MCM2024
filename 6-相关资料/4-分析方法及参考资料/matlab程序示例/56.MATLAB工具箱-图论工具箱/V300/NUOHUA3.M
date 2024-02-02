clear;load mktptn;
data=[people gdp wags consume ads 1./cpm];
w=[30 20 15 20 10 5];
tdata=trim(data,3);
tm=mean(tdata);tsig=std(tdata);
ndata=(data-ones(84,1)*tm)./(ones(84,1)*tsig);
t=ndata*w'