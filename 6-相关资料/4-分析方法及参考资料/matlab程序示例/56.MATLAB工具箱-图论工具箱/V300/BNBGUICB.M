function BNBGUICB(action,file);
% BNBGUICB Callback function for BNBGUI.
% Do not run this file from the Matlab prompt.
persistent data;

if nargin<1, help bnbguicb; action=''; end;

switch action
  
case('init')
   data.id='BNBGUI10 BNB18';
   data.fun='';
   data.x0=[];
   data.xstatus=[];
   data.xlb=[];
   data.xub=[];
   data.A=[];
   data.B=[];
   data.Aeq=[];
   data.Beq=[];
   data.nonlcon='';
   data.settings=[0 0 0];
   data.maxSQPiter=1000;
   data.options1=optimset('fmincon');
   data.options2=optimset('fmincon');
   data.par=[];
   data.numx=0;
   data.numpar=0;
   data.selx=0;
   data.selpar=0;
   data.selopt=2;
   data.seloptpar=1;
   data.optliststring={'DerivativeCheck' 'Diagnostics' 'DiffMaxChange' ...
         'DiffMinChange' 'Display' 'GradConstr' 'GradObj' ...
         'LargeScale' 'MaxFunEvals' 'MaxIter' 'MaxPCGIter' 'PrecondBandWidth' ...
         'TolCon' 'TolFun' 'TolPCG' 'TolX'};
   data.results.errmsg='';
   data.results.Z=inf;
   data.results.X=[];
   data.results.t=0;
   data.results.c=0;
   data.results.fail=0;
   data.results.msg='BNB GUI for BNB18';
case('main')
   handle=findobj('Tag','main BNB GUI');
   if isempty(handle)
      mlock;
      guimain;
      handle=findobj('Tag','main BNB GUI');
      CloseRequestFcn='BNBGUICB(''quit main''); closereq;';
      set(handle,'CloseRequestFcn',CloseRequestFcn);
   end;
   if data.numx>0
      onoffx('on');
      handle=findobj('Tag','xlist');
      set(handle,'String',num2str([1:data.numx]'));
      set(handle,'Value',data.selx);
      updatex(data);
   else onoffx('off'); end;
   if data.numpar>0
      onoffpar('on');
      handle=findobj('Tag','parlist');
      set(handle,'String',num2str([1:data.numpar]'));
      set(handle,'Value',data.selpar);
      updatepar(data);
   else onoffpar('off'); end;
   showresults(data.results.msg);
case('resultsslider')
   showresults(data.results.msg)
case('X -> x0')
   if all(size(data.results.X)==size(data.x0)),
      data.x0=data.results.X;
      if data.numx>0, updatex(data); end;
   end;
case('Z X t c fail -> workspace')
   assignin('base','Z',data.results.Z);
   assignin('base','X',data.results.X);
   assignin('base','t',data.results.t);
   assignin('base','c',data.results.c);
   assignin('base','fail',data.results.fail);
   disp('The variables Z, X, t, c and fail are loaded in the workspace.');
case('clc workspace')
   clc;
case('copyright')
   errmsg={'E.C. Kuipers' 'e-mail:' 'E.C.Kuipers@cpedu.rug.nl' 'FI-Lab' ...
         'Applied Physics' 'Rijksuniversiteit Groningen'};
   handle1=guierr;
   set(handle1,'UserData',errmsg);
   handle2=findobj('Tag','error');
   set(handle2,'String','Copyright:');
   bnbguicb('errorslider');
case('xlist')
   data.selx=selectx;
   updatex(data);
case('x0')
   data.selx=selectx;
   data.x0(data.selx)=strtonum(get(gcbo,'String'));
case('xlb')
   data.selx=selectx;
   data.xlb(data.selx)=strtonum(get(gcbo,'String'));
case('xub')
   data.selx=selectx;
   data.xub(data.selx)=strtonum(get(gcbo,'String'));
case('continuous')
   data.selx=selectx;
   data.xstatus(data.selx)=0;
   updatex(data);
case('integer')
   data.selx=selectx;
   data.xstatus(data.selx)=1;
   updatex(data);
case('fixed')
   data.selx=selectx;
   data.xstatus(data.selx)=2;
   updatex(data);
case('parlist')
   data.selpar=selectpar;
   updatepar(data);
case('par')
   data.selpar=selectpar;
   data.par(data.selpar)=strtonum(get(gcbo,'String'));
case('save')
   [file,path]=uiputfile('bnb.mat','Select mat-file to save data.');
   if file~=0
      BNBdata=data;
      eval(['save ',fullfile(path,file),' BNBdata;'],'uierror(''Data has not been saved.'')');
   end;
case('load')
   if ~exist('file'), file=uigetfile('bnb.mat','Select mat-file to load settings.'); end;
   if file~=0
      check=1;
      eval(['load ',file,' BNBdata;'],'uierror(''File not found.''); check=0;');
      if check==1
         if exist('BNBdata') & isstruct(BNBdata) ...
               & isfield(BNBdata,'id') & strcmp(BNBdata.id,'BNBGUI10 BNB18')
            data=BNBdata;
            bnbguicb('main');
            handle=findobj('Tag','function BNB GUI');
            if ~isempty(handle), bnbguicb('function'); end;
            handle=findobj('Tag','settings BNB GUI');
            if ~isempty(handle), bnbguicb('settings'); end;
         else uierror('Data has not been updated.'); end;
      end;
   end;
case('help')
   edit bnbhelp.txt;
case('function')
   handle=findobj('Tag','function BNB GUI');
   if isempty(handle), guifun; end;
   set(findobj('Tag','fun'),'String',data.fun);
   set(findobj('Tag','nonlcon'),'String',data.nonlcon);
   set(findobj('Tag','numx'),'String',num2str(data.numx));
   set(findobj('Tag','numpar'),'String',num2str(data.numpar));
case('settings')
   handle=findobj('Tag','settings BNB GUI');
   if isempty(handle), guiset; end;
   set(findobj('Tag','set1'),'Value',data.settings(1));
   set(findobj('Tag','set2'),'Value',data.settings(2));
   set(findobj('Tag','set3'),'Value',data.settings(3));
   set(findobj('Tag','maxSQPiter'),'String',data.maxSQPiter);
   set(findobj('Tag','opt1'),'Value',data.selopt==1);
   set(findobj('Tag','opt2'),'Value',data.selopt==2);
   set(findobj('Tag','optlist'),'String',data.optliststring);
   set(findobj('Tag','optlist'),'Value',data.seloptpar);
   updateopt(data);
case('optimize')
   par=num2cell(data.par);
   [data.results.errmsg,data.results.Z,data.results.X,...
      data.results.t,data.results.c,data.results.fail]=...
      bnb18(data.fun,data.x0,data.xstatus,data.xlb,data.xub,...
      data.A,data.B,data.Aeq,data.Beq,data.nonlcon,...
      data.settings,data.options1,data.options2,data.maxSQPiter,par{:});
   data.results.msg=updateresults(data.results);
   showresults(data.results.msg);
case('quit main')
   handle=findobj('Tag','function BNB GUI');
   if ~isempty(handle), close(handle); end;
   handle=findobj('Tag','settings BNB GUI');
   if ~isempty(handle), close(handle); end;
   munlock;
case('fun')
   fun=uigetfile('*.m','Select m-file for fun(x).');
   if fun~=0
      if all(fun(size(fun,2)-1:size(fun,2))=='.m')
         data.fun=fun(1:size(fun,2)-2);
         set(findobj('Tag','fun'),'String',data.fun(1:min(12,size(data.fun,2))));
      else uierror({'No m-file.' 'fun has not been updated.'}); end;
   end; 
case('funedit')
   if ~isempty(data.fun), eval(['edit ',data.fun]); else edit; end;
case('A')
   [succes,A]=loadmatrix('A');
   if succes==1, data.A=A; end;
case('B')
   [succes,B]=loadmatrix('B');
   if succes==1, data.B=B; end;
case('Aeq')
   [succes,Aeq]=loadmatrix('Aeq');
   if succes==1, data.Aeq=Aeq; end;
case('Beq')
   [succes,Beq]=loadmatrix('Beq');
   if succes==1, data.A=A; end;
case('lincon')
   file=uigetfile('*.mat','Select mat-file for matrixes A,B, Aeq and Beq.');
   if file~=0
      if all(file(size(file,2)-3:size(file,2))=='.mat')
         foundfile=1;
         eval(['load ',file,' A B Aeq Beq;'],'foundfile=0; uierror(''File not found.'');');
         if foundfile==1
            errmsg={};
            if exist('A'), data.A=A; 
            else errmsg{size(errmsg,2)+1}='A has not been updated'; end; 
            if exist('B'), data.B=B;
            else errmsg{size(errmsg,2)+1}='B has not been updated'; end;
            if exist('Aeq'), data.Aeq=Aeq;
            else errmsg{size(errmsg,2)+1}='Aeq has not been updated'; end;
            if exist('Beq'), data.Beq=Beq;
            else errmsg{size(errmsg,2)+1}='Beq has not been updated'; end;
            if size(errmsg,2)>0, uierror(errmsg); end;
         end;
      else uierror({'No mat-file.' 'lincon has not been updated.'}); end;
   end;
case('nonlcon')
   nonlcon=uigetfile('*.m','Select m-file for nonlcon(x).');
   if nonlcon~=0
      if all(nonlcon(size(nonlcon,2)-1:size(nonlcon,2))=='.m')
         data.nonlcon=nonlcon(1:size(nonlcon,2)-2);
         set(findobj('Tag','nonlcon'),'String',data.nonlcon(1:min(12,size(data.nonlcon,2))));
      else uierror({'No m-file.' 'nonlincon has not been updated.'}); end;
   end;
case('nonlconedit')
   if ~isempty(data.nonlcon), eval(['edit ',data.nonlcon]); else edit; end;
case('numx')
   numx=strtonum(get(gcbo,'String'));
   if numx>=0 & numx==round(numx)
      data.numx=numx;
      if numx==0
         data.x0=[];
         data.xstatus=[];
         data.xlb=[];
         data.xub=[];
         onoffx('off');
      else
         lx=size(data.x0,1);
         if numx>lx
            data.x0=[data.x0;zeros(numx-lx,1)];
            data.xstatus=[data.xstatus;zeros(numx-lx,1)];
            data.xlb=[data.xlb;zeros(numx-lx,1)];
            data.xub=[data.xub;ones(numx-lx,1)];
         else
            data.x0=data.x0(1:numx);
            data.xstatus=data.xstatus(1:numx);
            data.xlb=data.xlb(1:numx);
            data.xub=data.xub(1:numx);
         end;
         data.selx=selectx;
         handle=findobj('Tag','xlist');
         if numx<data.selx, set(handle,'Value',numx); data.selx=selectx; end;
         set(handle,'String',num2str([1:numx]'));
         updatex(data);
         onoffx('on');
      end;
   end;
case('numpar')
   numpar=strtonum(get(gcbo,'String'));
   if numpar>=0 & numpar==round(numpar)
      data.numpar=numpar;
      if numpar==0
         data.par=[];
         onoffpar('off');
      else
         lpar=size(data.par,1);
         if numpar>lpar
            data.par=[data.par;zeros(numpar-lpar,1)];
         else
            data.par=data.par(1:numpar);
         end;
         data.selpar=selectpar;
         handle=findobj('Tag','parlist');
         if numpar<data.selpar, set(handle,'Value',numpar); data.selpar=selectpar; end;
         set(handle,'String',num2str([1:numpar]'));
         updatepar(data);
         onoffpar('on');
      end;
   end;
case('to workspace')
   assignin('base','fun',data.fun);
   assignin('base','A',data.A);
   assignin('base','B',data.B);
   assignin('base','Aeq',data.Aeq);
   assignin('base','Beq',data.Beq);
   assignin('base','nonlcon',data.nonlcon);
   disp('The variables fun, A, B, Aeq, Beq and nonlcon are loaded in the workspace for editing.');
case('from workspace')
   data.fun=evalin('base','fun','disp(''fun not found in workspace.'');');
   data.A=evalin('base','A','data.A');
   data.B=evalin('base','B','data.B');
   data.Aeq=evalin('base','Aeq','data.Aeq');
   data.Beq=evalin('base','Beq','data.Beq');
   data.nonlcon=evalin('base','nonlcon','data.nonlcon');
   disp('The variables fun, A, B, Aeq, Beq and nonlcon are loaded from the workspace.');   
   set(findobj('Tag','fun'),'String',data.fun);
   set(findobj('Tag','nonlcon'),'String',data.nonlcon);
case('set1')
   data.settings(1)=get(gcbo,'Value');
case('set2')
   data.settings(2)=get(gcbo,'Value');
case('set3')
   data.settings(3)=get(gcbo,'Value');
case('maxSQPiter')
   data.maxSQPiter=strtonum(get(gcbo,'String'));
case('opt1')
   set(findobj('Tag','opt2'),'Value',0);
   data.selopt=1;
   updateopt(data);
case('opt2')
   set(findobj('Tag','opt1'),'Value',0);
   data.selopt=2;
   updateopt(data);
case('optlist')
   [data.selopt data.seloptpar]=selectopt;
   updateopt(data);
case('optedit')
   optparval=get(gcbo,'String');
   number=strtonum(optparval);
   if number~=0 | optparval=='0', optparval=number; end;
   eval(['data.options',num2str(data.selopt),'.',data.optliststring{data.seloptpar},'=optparval;']);
case('errorslider')
   handle=findobj('Tag','error BNB GUI');
   errmsg=get(handle,'UserData');
   handle=findobj('Tag','errorslider');
   errorslider=get(handle,'Value');
   handle=findobj('Tag','errormessage');
   errmsg=textwrap(handle,errmsg);
   errmsg=scrolltext(errmsg,errorslider,4);
   set(handle,'String',errmsg);
end;

function selx=selectx;
handle=findobj('Tag','xlist');
selx=get(handle,'Value');

function updatex(data);
handle=findobj('Tag','xub');
set(handle,'String',num2str(data.xub(data.selx)));
handle=findobj('Tag','x0');
set(handle,'String',num2str(data.x0(data.selx)));
handle=findobj('Tag','xlb');
set(handle,'String',num2str(data.xlb(data.selx)));
handle=findobj('Tag','continuous');
set(handle,'Value',data.xstatus(data.selx)==0);
handle=findobj('Tag','integer');
set(handle,'Value',data.xstatus(data.selx)==1);
handle=findobj('Tag','fixed');
set(handle,'Value',data.xstatus(data.selx)==2);

function onoffx(onoff);
handle=findobj('Tag','xlist');
set(handle,'Enable',onoff);
handle=findobj('Tag','xub');
set(handle,'Enable',onoff);
handle=findobj('Tag','x0');
set(handle,'Enable',onoff);
handle=findobj('Tag','xlb');
set(handle,'Enable',onoff);
handle=findobj('Tag','continuous');
set(handle,'Enable',onoff);
handle=findobj('Tag','integer');
set(handle,'Enable',onoff);
handle=findobj('Tag','fixed');
set(handle,'Enable',onoff);

function selpar=selectpar;
handle=findobj('Tag','parlist');
selpar=get(handle,'Value');

function updatepar(data);
handle=findobj('Tag','par');
set(handle,'String',num2str(data.par(data.selpar)));

function onoffpar(onoff);
handle=findobj('Tag','parlist');
set(handle,'Enable',onoff);
handle=findobj('Tag','par');
set(handle,'Enable',onoff);

function [selopt,seloptpar]=selectopt;
handle=findobj('Tag','opt1');
tmp=get(handle,'Value');
if tmp==1, selopt=1; else selopt=2; end;
handle=findobj('Tag','optlist');
seloptpar=get(handle,'Value');

function updateopt(data);
handle=findobj('Tag','opt1');
set(handle,'Value',data.selopt==1);
handle=findobj('Tag','opt2');
set(handle,'Value',data.selopt==2);
eval(['optparval=optimget(data.options',num2str(data.selopt),',''',data.optliststring{data.seloptpar},''');']);
handle=findobj('Tag','optedit');
set(handle,'String',optparval);

function num=strtonum(string)
tmp=str2num(string);
if isempty(tmp), num=0; else num=tmp; end;
if any(size(num)>1), num=0; end;

function uierror(errmsg)
handle=guierr;
if ischar(errmsg), errmsg=cellstr(errmsg); end;
set(handle,'UserData',errmsg);
bnbguicb('errorslider');

function resultsmsg=updateresults(results)
if isempty(results.errmsg)
   line1='Results BNB18:';
   line2=sprintf('Z    is %12.4g',results.Z);
   line3='X    is ';
   line4=sprintf('%12.4g',results.X);
   line5=sprintf('t    is %12.1f seconds',results.t);
   line6=sprintf('c    is %12d cycles',results.c);
   line7=sprintf('fail is %12d cycles',results.fail);
   resultsmsg={line1 line2 line3 line4 line5 line6 line7};
else
   line1='Results BNB18:';
   line2='Error.';
   line3=results.errmsg;
   resultsmsg={line1 line2 line3};
end;

function showresults(resultsmsg);
if ischar(resultsmsg), resultsmsg=cellstr(resultsmsg); end;
handle=findobj('Tag','resultsslider');
resultsslider=get(handle,'Value');
handle=findobj('Tag','results');
resultsmsg=textwrap(handle,resultsmsg);
resultsmsg=scrolltext(resultsmsg,resultsslider,8);
set(handle,'String',resultsmsg);

function disptext=scrolltext(text,slidervalue,visiblelines);
if ischar(text), text=cellstr(text); end;
if visiblelines<1, disptext={''}; return; end;
textlines=size(text,1);
if textlines<1, disptext={''}; return; end;
hiddenlines=max(0,textlines-visiblelines);
hiddenlinesabove=round((1-slidervalue)*hiddenlines);
disptext=text(hiddenlinesabove+1:hiddenlinesabove+min(visiblelines,textlines));

function [succes,matrix]=loadmatrix(matrixname);
succes=0; matrix=[];
file=uigetfile('*.mat',['Select mat-file for matrix ',matrixname,'.']);
if file~=0 
   if all(file(size(file,2)-3:size(file,2))=='.mat')
      foundfile=1;
      eval(['load ',file,' ',matrixname,';'],'foundfile=0; uierror(''File not found.'');');
      if foundfile==1
         if exist(matrixname), matrix=matrixname; succes=1;
         else uierror([matrixname,' has not been updated']); end;
      end;
   else uierror({'No mat-file.' [matrixname,' has not been updated.']}); end;
end;
