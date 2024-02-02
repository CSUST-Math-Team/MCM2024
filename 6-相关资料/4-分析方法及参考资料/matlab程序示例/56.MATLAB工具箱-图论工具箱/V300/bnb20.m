function [errmsg,Z,X,t,c,fail] = BNB20(fun,x0,xstat,xl,xu,a,b,aeq,beq,nonlc,setts,opts,varargin); 
% BNB20 Finds the constrained minimum of a function of several possibly integer variables. 
% Usage: [errmsg,Z,X,t,c,fail] =  
%        BNB20(fun,x0,xstatus,xlb,xub,A,B,Aeq,Beq,nonlcon,settings,options,P1,P2,...)  
% 
% BNB solves problems of the form: 
% Minimize F(x) subject to: xlb <= x0 <=xub 
%                           A*x <= B  Aeq*x=Beq 
%                           C(x)<=0  Ceq(x)=0 
%                           x(i) is continuous for xstatus(i)=0   
%                           x(i) integer for xstatus(i)= 1 
%                           x(i) fixed for xstatus(i)=2 
% 
% BNB uses: 
% Optimization Toolbox Version 2.0 (R11) 09-Oct-1998 
% From this toolbox fmincon.m is called. For more info type help fmincon. 
% 
% fun is the function to be minimized and should return a scalar. F(x)=feval(fun,x). 
% x0 is the starting point for x. x0 should be a column vector. 
% xstatus is a column vector describing the status of every variable x(i). 
% xlb and xub are column vectors with lower and upper bounds for x. 
% A and Aeq are matrices for the linear constrains. 
% B and Beq are column vectors for the linear constrains. 
% nonlcon is the function for the nonlinear constrains. 
% [C(x);Ceq(x)]=feval(nonlcon,x). Both C(x) and Ceq(x) should be column vectors. 
% 
% errmsg is a string containing an error message if BNB found an error in the input. 
% Z is the scalar result of the minimization, X the values of the accompanying variables.  
% t is the time elapsed while the algorithm BNB has run and c is the number of BNB cycles. 
% fail is the number of nonconvergent leaf sub-problems. 
% 
% settings is a row vector with settings for BNB: 
% settings(1) (standard 0) if 1: if the sub-problem does not converge do not branch it and 
% raise fail by one. Normally BNB will always branch a nonconvergent sub-problem so it can 
% try again to find a solution. 
% A sub-problem that is a leaf of the branch-and-bound-tree cannot be branched. If such 
% a problem does not converge it will be considered infeasible and fail will be raised by one. 
% settings(2) is the handle of main BNB GUI. Leave empty.  
% options is an options structure. For details type help optimset. 
% options.maxSQPiter is a variable used by fmincon (if modified as described in bnb20.m). 
% maxSQPiter cannot be set by optimset because it is not part of the standard options 
% structure. maxSQPiter is 1000 by default. 
% P1,P2,... are parameters to be passed to fun and nonlcon. 
% F(x)=feval(fun,x,P1,P2,...). [C(x);Ceq(x)]=feval(nonlcon,x,P1,P2,...). 
% Type edit BNB20 for more info. 
 
% E.C. Kuipers 
% e-mail E.C.Kuipers@cpedu.rug.nl  
% FI-Lab 
% Applied Physics 
% Rijksuniversiteit Groningen 
 
% To get rid of bugs and to stop fmincon from hanging make the following chances: 
% 
% In optim/private/nlconst.m ($Revision: 1.20 $  $Date: 1998/08/24 13:46:15 $): 
% Get EXITFLAG independent of verbosity. 
% After the lines:                 disp('  less than 2*options.TolFun but constraints are not satisfied.')     
%                               end 
%                               EXITFLAG = -1;    
%                            end 
%                         end 
%                         status=1; 
% add the line: if (strncmp(howqp, 'i',1) & mg > 0), EXITFLAG = -1; end; 
% 
% In optim/private/qpsub.m ($Revision: 1.21 $  $Date: 1998/09/01 21:37:56 $): 
% Stop qpsub from hanging. 
% After the line: %   Andy Grace 7-9-90. Mary Ann Branch 9-30-96. 
% add the line: global maxSQPIter;  
% and changed the line: maxSQPiters = Inf; 
% to the line: if exist('maxSQPiter','var'), maxSQPiters = maxSQPiter; else maxSQPiters=inf; end;  
% I guess there was a reason to put maxSQPiters at infinity, but this works fine for me. 
global maxSQPiter; 

% STEP 0 CHECKING INPUT
Z=[]; X=[]; t=0; c=0; fail=0; 
if nargin<2, errmsg='BNB needs at least 2 input arguments.'; return; end;
if isempty(fun), errmsg='No fun found.'; return; 
elseif ~ischar(fun), errmsg='fun must be a string.'; return; end; 
if isempty(x0), errmsg='No x0 found.'; return; 
elseif ~isnumeric(x0) | ~isreal(x0) | size(x0,2)>1 
   errmsg='x0 must be a real column vector.'; return; 
end; 
xstatus=zeros(size(x0)); 
if nargin>2 & ~isempty(xstat) 
   if isnumeric(xstat) & isreal(xstat) & all(size(xstat)<=size(x0)) 
      if all(xstat==round(xstat) & 0<=xstat & xstat<=2) 
         xstatus(1:size(xstat))=xstat; 
      else errmsg='xstatus must consist of the integers 0,1 en 2.'; return; end; 
   else errmsg='xstatus must be a real column vector the same size as x0.'; return; end; 
end; 
xlb=zeros(size(x0)); 
xlb(find(xstatus==0))=-inf; 
if nargin>3 & ~isempty(xl) 
   if isnumeric(xl) & isreal(xl) & all(size(xl)<=size(x0)) 
      xlb(1:size(xl,1))=xl; 
   else errmsg='xlb must be a real column vector the same size as x0.'; return; end; 
end; 
if any(x04 & ~isempty(xu) 
   if isnumeric(xu) & isreal(xu) & all(size(xu)<=size(x0)) 
      xub(1:size(xu,1))=xu; 
   else errmsg='xub must be a real column vector the same size as x0.'; return; end; 
end; 
if any(x0>xub), errmsg='x0 must be in the range x0 <=xub.'; return; 
elseif any(xstatus==1 & (~isfinite(xub) | xub~=round(xub))) 
   errmsg='xub(i) must be an integer if x(i) is an integer variabale.'; return; 
end; 
xub(find(xstatus==2))=x0(find(xstatus==2)); 
A=[]; 
if nargin>5 & ~isempty(a) 
   if isnumeric(a) & isreal(a) & size(a,2)==size(x0,1), A=a; 
   else errmsg='Matrix A not correct.'; return; end; 
end; 
B=[]; 
if nargin>6 & ~isempty(b) 
   if isnumeric(b) & isreal(b) & all(size(b)==[size(A,1) 1]), B=b; 
   else errmsg='Column vector B not correct.'; return; end; 
end; 
if isempty(B) & ~isempty(A), B=zeros(size(A,1),1); end; 
Aeq=[]; 
if nargin>7 & ~isempty(aeq) 
   if isnumeric(aeq) & isreal(aeq) & size(aeq,2)==size(x0,1), Aeq=aeq; 
   else errmsg='Matrix Aeq not correct.'; return; end; 
end; 
Beq=[]; 
if nargin>8 & ~isempty(beq) 
   if isnumeric(beq) & isreal(beq) & all(size(beq)==[size(Aeq,1) 1]), Beq=beq; 
   else errmsg='Column vector Beq not correct.'; return; end; 
end; 
if isempty(Beq) & ~isempty(Aeq), Beq=zeros(size(Aeq,1),1); end; 
nonlcon=''; 
if nargin>9 & ~isempty(nonlc) 
   if ischar(nonlc), nonlcon=nonlc;  
   else errmsg='fun must be a string.'; return; end; 
end; 
settings = [0 0];
if nargin>10 & ~isempty(setts) 
   if isnumeric(setts) & isreal(setts) & all(size(setts)<=size(settings)) 
      settings(setts~=0)=setts(setts~=0); 
   else errmsg='settings should be a row vector of length 1 or 2.'; return; end; 
end; 
maxSQPiter=1000; 
options=optimset('fmincon'); 
if nargin>11 & ~isempty(opts) 
   if isstruct(opts) 
      if isfield(opts,'MaxSQPIter') 
         if isnumeric(opts.MaxSQPIter) & isreal(opts.MaxSQPIter) & ... 
               all(size(opts.MaxSQPIter)==1) & opts.MaxSQPIter>0 & ... 
               round(opts.MaxSQPIter)==opts.MaxSQPIter 
            maxSQPiter=opts.MaxSQPIter; 
            opts=rmfield(opts,'MaxSQPIter'); 
         else errmsg='options.maxSQPiter must be an integer >0.'; return; end; 
      end; 
      options=optimset(options,opts); 
   else errmsg='options must be a structure.'; return; end; 
end; 
evalreturn=0; 
eval(['z=',fun,'(x0,varargin{:});'],'errmsg=''fun caused error.''; evalreturn=1;'); 
if evalreturn==1, return; end; 
if ~isempty(nonlcon) 
   eval(['[C, Ceq]=',nonlcon,'(x0,varargin{:});'],'errmsg=''nonlcon caused error.''; evalreturn=1;'); 
   if evalreturn==1, return; end; 
   if size(C,2)>1 | size(Ceq,2)>1, errmsg='C en Ceq must be column vectors.'; return; end; 
end; 
 
% STEP 1 INITIALISATION
currentwarningstate=warning; 
warning off; 
tic;
lx = size(x0,1);
z_incumbent=inf;
x_incumbent=inf*ones(size(x0));
I = ceil(sum(log2(xub(find(xstatus==1))-xlb(find(xstatus==1))+1))+size(find(xstatus==1),1)+1);
stackx0=zeros(lx,I);
stackx0(:,1)=x0; 
stackxlb=zeros(lx,I);
stackxlb(:,1)=xlb;
stackxub=zeros(lx,I);
stackxub(:,1)=xub; 
stackdepth=zeros(1,I); 
stackdepth(1,1)=1;
stacksize=1;
xchoice=zeros(size(x0)); 
if ~isempty(Aeq) 
   j=0; 
   for i=1:size(Aeq,1) 
      if Beq(i)==1 & all(Aeq(i,:)==0 | Aeq(i,:)==1) 
         J=find(Aeq(i,:)==1); 
         if all(xstatus(J)~=0 & xchoice(J)==0 & xlb(J)==0 & xub(J)==1) 
            if all(xstatus(J)~=2) | all(x0(J(find(xstatus(J)==2)))==0) 
               j=j+1; 
               xchoice(J)=j; 
               if sum(x0(J))==0, errmsg='x0 not correct.'; return; end; 
            end; 
         end; 
      end; 
   end; 
end; 
errx=optimget(options,'TolX'); 
handleupdate=[]; 
if ishandle(settings(2)) 
   taghandlemain=get(settings(2),'Tag'); 
   if strcmp(taghandlemain,'main BNB GUI') 
      handleupdate=guiupd; 
      handleupdatemsg=findobj(handleupdate,'Tag','updatemessage'); 
      bnbguicb('hide main'); 
      drawnow; 
   end; 
end; 
optionsdisplay=getfield(options,'Display'); 
if strcmp(optionsdisplay,'iter') | strcmp(optionsdisplay,'final') 
   show=1; 
else show=0; end; 

% STEP 2 TERMINIATION
while stacksize>0
   c=c+1; 
   
   % STEP 3 LOADING OF CSP
   x0=stackx0(:,stacksize);
   xlb=stackxlb(:,stacksize);
   xub=stackxub(:,stacksize);
   x0(find(x0xub))=xub(find(x0>xub)); 
   depth=stackdepth(1,stacksize);
   stacksize=stacksize-1;
   percdone=round(100*(1-sum(0.5.^(stackdepth(1:(stacksize+1))-1)))); 
   
   % UPDATE FOR USER 
   if ishandle(handleupdate) & strcmp(get(handleupdate,'Tag'),'update BNB GUI') 
      t=toc; 
      updatemsg={ ... 
            sprintf('searched %3d %% of three',percdone) ... 
            sprintf('Z    : %12.4e',z_incumbent) ... 
            sprintf('t    : %12.1f secs',t) ... 
            sprintf('c    : %12d cycles',c-1) ... 
            sprintf('fail : %12d cycles',fail)}; 
      set(handleupdatemsg,'String',updatemsg); 
      drawnow; 
   else 
      disp(sprintf('*** searched %3d %% of three',percdone)); 
      disp(sprintf('*** Z    : %12.4e',z_incumbent)); 
      disp(sprintf('*** t    : %12.1f secs',t)); 
      disp(sprintf('*** c    : %12d cycles',c-1)); 
      disp(sprintf('*** fail : %12d cycles',fail)); 
   end; 
    
   % STEP 4 RELAXATION 
   [x z convflag]=fmincon(fun,x0,A,B,Aeq,Beq,xlb,xub,nonlcon,options,varargin{:}); 
   
   % STEP 5 FATHOMING
   K = find(xstatus==1 & xlb~=xub);
   separation=1;
   if convflag<0 | (convflag==0 & settings(1)) 
      % FC 1 
      separation=0; 
      if show, disp('*** branch pruned'); end; 
      if convflag==0, 
         fail=fail+1; 
         if show, disp('*** not convergent'); end; 
      elseif show, disp('*** not feasible'); 
      end; 
   elseif z>=z_incumbent & convflag>0 
      % FC 2
      separation=0; 
      if show 
         disp('*** branch pruned'); 
         disp('*** ghosted');  
      end; 
      
   elseif all(abs(round(x(K))-x(K))0 
      % FC 3
      z_incumbent = z;
      x_incumbent = x; 
      separation = 0; 
      if show 
         disp('*** branch pruned'); 
         disp('*** new best solution found');
      end;    
   end;
   
   % STEP 6 SELECTION 
   if separation == 1 & ~isempty(K) 
      dzsep=-1;
      for i=1:size(K,1)
         dxsepc = abs(round(x(K(i)))-x(K(i)));
         if dxsepc>=errx | convflag==0 
            xsepc = x; xsepc(K(i))=round(x(K(i)));
            dzsepc = abs(feval(fun,xsepc,varargin{:})-z);
            if dzsepc>dzsep
               dzsep=dzsepc;
               ixsep=K(i);
            end;
         end;
      end;
         
      % STEP 7 SEPARATION 
      if xchoice(ixsep)==0 
         
         % XCHOICE==0 
         branch=1;
         domain=[xlb(ixsep) xub(ixsep)];
         sepdepth=depth;
         while branch==1
            xboundary=(domain(1)+domain(2))/2;
            if x(ixsep)<xboundary
               domainA=[domain(1) floor(xboundary)];
               domainB=[floor(xboundary+1) domain(2)];
            else
               domainA=[floor(xboundary+1) domain(2)];
               domainB=[domain(1) floor(xboundary)];
            end;
            sepdepth=sepdepth+1; 
            stacksize=stacksize+1;
            stackx0(:,stacksize)=x;
            stackxlb(:,stacksize)=xlb;
            stackxlb(ixsep,stacksize)=domainB(1);
            stackxub(:,stacksize)=xub;
            stackxub(ixsep,stacksize)=domainB(2); 
            stackdepth(1,stacksize)=sepdepth;
            if domainA(1)==domainA(2)  
               stacksize=stacksize+1;
               stackx0(:,stacksize)=x;
               stackxlb(:,stacksize)=xlb;
               stackxlb(ixsep,stacksize)=domainA(1);
               stackxub(:,stacksize)=xub;
               stackxub(ixsep,stacksize)=domainA(2); 
               stackdepth(1,stacksize)=sepdepth;
               branch=0;
            else
               domain=domainA;
               branch=1;
            end;
         end;
      else
         
         % XCHOICE~=0
         L=find(xchoice==xchoice(ixsep));
         M=intersect(K,L);
         [dummy,N]=sort(x(M));
         part1=M(N(1:floor(size(N)/2))); part2=M(N(floor(size(N)/2)+1:size(N)));
         sepdepth=depth+1; 
         stacksize=stacksize+1;
         stackx0(:,stacksize)=x; 
         O = (1-sum(stackx0(part1,stacksize)))/size(part1,1); 
         stackx0(part1,stacksize)=stackx0(part1,stacksize)+O; 
         stackxlb(:,stacksize)=xlb;
         stackxub(:,stacksize)=xub;
         stackxub(part2,stacksize)=0;
         stackdepth(1,stacksize)=sepdepth; 
         stacksize=stacksize+1;
         stackx0(:,stacksize)=x; 
         O = (1-sum(stackx0(part2,stacksize)))/size(part2,1); 
         stackx0(part2,stacksize)=stackx0(part2,stacksize)+O; 
         stackxlb(:,stacksize)=xlb;
         stackxub(:,stacksize)=xub;
         stackxub(part1,stacksize)=0;
         stackdepth(1,stacksize)=sepdepth; 
      end; 
   elseif separation==1 & isempty(K) 
      fail=fail+1; 
      if show 
         disp('*** branch pruned'); 
         disp('*** leaf not convergent'); 
      end; 
   end; 
end; 
 
% STEP 8 OUTPUT   
t=toc;
Z = z_incumbent;
X = x_incumbent; 
errmsg=''; 
 
if ishandle(handleupdate) 
   taghandleupdate=get(handleupdate,'Tag'); 
   if strcmp(taghandleupdate,'update BNB GUI') 
      close(handleupdate); 
   end; 
end; 
 
%eval(['warning ',currentwarningstate]);
