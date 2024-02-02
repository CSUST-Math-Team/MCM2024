%M hanshu ILp.m
function [x,f]=ILp(c,A,b,vlb,vub,x0,neqcstr,pre)
if nargin<8,pre=0;
   if nargin<7,neqcstr=0;
      if nargin<6,x0=[];
         if nargin<5,vub=[];
            if nargin<4,vlb=[];
            end,end,end,end,end
x0=x0(:);c=c(:);b=b(:);vub=vub(:);vlb=vlb(:);
mm=1;j=1;nvars=length(c');
fvub=inf;xall=[];fall=[];x_f_b=[];
[xtemp,ztemp,how]=lp(c,A,b,vlb,vub,x0,neqcstr,-1);
ftemp=c'*xtemp;
if strcmp(how,'ok'),
   temp0=round(xtemp);temp1=floor(xtemp);
   temp2=find(abs(xtemp-temp0)>pre);
   mtemp=length(temp2);
   if ~isempty(temp2)
      x_f_b=[xtemp;ftemp;vlb;vub];
      while j<=mm
         i=1;
         while i<mtemp
            if x_f_b(nvars+1,j)<fvub
               vlbl=x_f_b(nvars+2:2*nvars+1,j);
               vubl=x_f_b(2*nvars+2:3*nvars+1,j);
               vubl(temp2(i))=temp1(temp2(i));
               [xtemp z,how]=lp(c,[A;c'],[b;fvub],vlbl,vubl,x0,neqcstr,-1);
               ftemp=c'*xtemp;
               if strcmp(how,'ok'),
                  temp10=round(xtemp);
                  temp11=floor(xtemp);
                  temp12=find(abs(xtemp-temp10)>pre);
                  if isempty(temp12),
                     xall=[xall,xtemp];fall=[fall,ftemp];
                     fvub=min([fvub,fall]);
                  elseif ftemp<=fvub
                     x_f_b=[x_f_b,[xtemp;ftemp;vlbl;vubl]];
                  end,end,end
            if x_f_b(nvars+1,j)<=fvub
               vlbr=x_f_b(nvars+2:2*nvars+1,j);
               vlbr(temp2(i))=temp1(temp2(i))+1;
               vubr=x_f_b(2*nvars+2:3*nvars+1,j);
               [xtemp z,how]=lp(c,[A;c'],[b;fvub],vlbr,vubr,x0,neqcstr,-1);
               ftemp=c'*xtemp;
               if strcmp(how,'ok'),
                  tempr0=round(xtemp);
                  tempr1=floor(xtemp);
                  tempr2=find(abs(xtemp-tempr0)>pre);
                  if isempty(tempr2),
                     xall=[xall,xtemp];fall=[fall,ftemp];
                     fvub=min([fvub,fall]);
                  elseif ftemp<=fvub
                     x_f_b=[x_f_b,[xtemp;ftemp;vlbr;vubr]];
                  end,end,end
            i=i+1;end
         xint=x_f_b(1:nvars,:);[m,mm]=size(xint);j=j+1;
         if j>mm,break,end
         temp0=round(xint(:,j));
         temp1=floor(xint(:,j));
         temp2=find(abs(xint(:,j)-temp0)>pre);
         mtemp=length(temp2);end,
   else,x=xtemp;f=ftemp;end,
   if ~isempty(fall)
      fmin=min(fall);
      nmin=find(fall==fmin);
      x=xall(:,nmin);f=fmin;end,
   else,x=nan*ones(1,nvars);end


