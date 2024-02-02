function pp = csape(x,y,conds,valconds)
%pp=csape(x,y,'变界类型','边界值'),生成各种边界条件的三次样条插值. 其中,边界类型可为:'complete',给定边界一阶导数.
%             'not-a-knot',非扭结条件,不用给边界值.
%             'periodic',周期性边界条件,不用给边界值.
%             'second',给定边界二阶导数.  
%             'variational',自然样条(边界二阶导数为0)
%  但与spline不同的是,csape的输出是一个结构,可直接用fnplt(pp)画出它的图.
%
%CSAPE Cubic spline interpolation with various end-conditions.
%
%   PP  = CSAPE(X,Y[,CONDS[,VALCONDS]])
%
%   returns the cubic spline interpolant (in ppform) to the given
%   data (X,Y) using the specified end-conditions.
%
%   CONDS may be a *string* whose first character matches one of the
%   following: 'complete' or 'clamped', 'not-a-knot', 'periodic',
%   'second', 'variational', with the following meanings:
%
%   'complete'    : match endslopes (as given in VALCONDS, with
%                   default as under *default*)
%   'not-a-knot'  : make spline C^3 across first and last interior
%                   breakpoint (ignoring VALCONDS if given)
%   'periodic'    : match first and second derivatives at first data
%                   point with those at last data point
%                   (ignoring VALCONDS if given)
%   'second'      : match end second derivatives (as given in VALCONDS,
%                   with default [0 0], i.e., as in variational)
%   'variational' : set end second derivatives equal to zero
%                   (ignoring VALCONDS if given)
%   The *default* : match endslopes to the slope of the cubic which
%                   matches the first four data at the respective end.
%
%   By giving CONDS as a 1-by-2 matrix instead, it is possible to
%   specify *different* conditions at the two endpoints, namely
%   CONDS(i) with value VALCONDS(:,i), with i=1 (i=2) referring to the
%   left (right) endpoint.
%
%   CONDS(i)=j  means that the j-th derivative is being specified to
%   be VALCONDS(:,i) , j=1,2.  CONDS(1)=0=CONDS(2)  means periodic end
%   conditions.
%
%   If CONDS(i) is not specified or is different from 0, 1 or 2, then
%   the default value for CONDS(i) is  1  and the default value of
%   VALCONDS(:,i) is taken.  If VALCONDS is not specified, then the
%   default value for VALCONDS(:,i) is taken to be
%
%    deriv. of cubic interpolant to nearest four points, if   CONDS(i)=1;
%                     0                                  if   CONDS(i)=2.
%
%   It is possible (and, in the case of gridded data required) to specify
%   VALCONDS as part of Y. Specifically, if size(Y) == [d,ny] and ny ==
%   length(X)+2, then VALCONDS is taken to be Y(:,[1 end]), and Y(:,i+1)
%   is matched at X(i), i=1:length(X).
%
%   It is also possible to handle gridded data, by having X be a cell array
%   containing m univariate meshes and, correspondingly, having Y be an
%   m-dimensional array (or an m+1-dimensional array if the function is to be
%   vector-valued). Correspondingly, CONDS is a cell array with m entries, but
%   the information normally specified by VALCONDS is now expected to be part
%   of Y. 
%
%   For example,
%
%      fnplt(csape( [0:4], [1 0 -1 0 1;0 1 0 -1 0], 'periodic')), axis equal
%
%   plots a circle, while
%
%      pp = csape( [0:4]*(pi/2), [0 1 0 -1 0], [1 2], [1 0] );
%
%   gives a good approximation to the sine function on the interval [0 .. 2*pi]
%   (matching its slope at 0 and its second derivative at 2*pi in addition 
%   to its value at 0:pi/2:2*pi).
%
%   As a multivariate vector-valued example, here is a sphere, done as a 
%   parametric bicubic spline, using prescribed slopes in one direction and
%   periodic side conditions in the other:
%
%      x = 0:4; y=-2:2; s2 = 1/sqrt(2);
%      clear v
%      v(3,:,:) = [0 1 s2 0 -s2 -1 0].'*[1 1 1 1 1];
%      v(2,:,:) = [1 0 s2 1 s2 0 -1].'*[0 1 0 -1 0];
%      v(1,:,:) = [1 0 s2 1 s2 0 -1].'*[1 0 -1 0 1];
%      sph = csape({x,y},v,{'clamped','periodic'});
%      values = fnval(sph,{0:.1:4,-2:.1:2});
%      surf(squeeze(values(1,:,:)),squeeze(values(2,:,:)),squeeze(values(3,:,:)))
%      % the previous two lines could have been replaced by: fnplt(sph) 
%      axis equal, axis off
%
%   See also CSAPI, SPAPI, SPLINE.

%   Carl de Boor 3 dec 90
%   cb : February 22, 1991 (added comments)
%   cb : 12 April 1992 (added periodic case and comments)
%   cb : 19 February 1994 (convert to sparse matrix use
%                                            and to vector-valued ordinates)
%   cb : 9 may '95 (use .' instead of ')
%   cb : 24 nov '95 (permit CONDS to be string; rewrite the help)
%   cb : 03 nov '96 (handle warning about empties of incorrect size when n=2)
%   cb : 29mar97 (correct help, re `periodic')
%   cb : 06oct97 (improve help, add examples)
%   cb : 25oct97 (permit gridded data, and the specification of VALCONDS as
%                 part of Y; add example of a sphere done as a parametric
%                 bicubic spline )
%   Copyright (c) 1987-98 by C. de Boor and The MathWorks, Inc.
%   $Revision: 1.6 $

%     Generate the cubic spline interpolant in pp form.

if nargin<3, conds = [1 1]; end

if iscell(x)       % we are dealing with gridded data

   m = length(x);
   sizey = size(y);
   switch length(sizey)
     case m  % grid values of a scalar-valued function
        sizey = [1 sizey]; y = reshape(y, sizey); 
     case m+1
     otherwise
        error(['If X is a cell-array of length m, then Y must be an ', ...
               'm- or (m+1)-dimensional array.'])
   end
   if ~iscell(conds), conds = num2cell(repmat(conds,m,1),2); end
   
   v = y; sizev = sizey;
   for i=m:-1:1   % carry out coordinatewise interpolation
      [b,v,l,k] = ppbrk(csape1(x{i}, ...
                   reshape(v,prod(sizev(1:m)),sizev(m+1)),conds{i}));
      breaks{i} = b;
      sizev(m+1) = l*k; v = reshape(v,sizev);
      if m>1
         v = permute(v,[1,m+1,2:m]); sizev(2:m+1) = sizev([m+1,2:m]);
      end
   end
   % At this point, V contains the tensor-product pp coefficients;
   % It remains to make up the formal description:
   pp = ppmak(breaks, v);

else         % we are dealing with univariate data

   if nargin<4
      pp = csape1(x,y,conds);
   else
      pp = csape1(x,y,conds,valconds);
   end
end

function pp = csape1(x,y,conds,valconds)
%     Generate the cubic spline interpolant in pp form.

n = length(x); [xi,ind] = sort(x); xi = xi(:);
pp = [];
if n<2, error('There should be at least two data points.'), end

if all(diff(xi))==0, error('The data abscissae should be distinct.'), end

[yd,yn] = size(y); % if y happens to be a one-column matrix, change it to
                   % the expected one-row matrix.
if yn==1, yn=yd; y=reshape(y,1,yn); yd=1; end

switch yn
   case n
   case n+2, valconds = y(:,[1 end]); y(:,[1 end]) = [];
   otherwise
      error('Number of data sites and data values should match.')
end

yi=y(:,ind).'; dd = ones(1,yd);

valsnotgiven=0;
if ~exist('valconds'), valsnotgiven=1;  valconds = zeros(yd,2); end
if isstr(conds)
   if     conds(1)=='c', conds = [1 1];
   elseif conds(1)=='n', pp = csapi(x,y); return
   elseif conds(1)=='p', conds = [0 0];
   elseif conds(1)=='s', conds = [2 2];
   elseif conds(1)=='v', conds = [2 2]; valconds = zeros(yd,2);
   else, error(['Unknown end condition *',conds,'* specified.'])
   end
end

   % set up the linear system for solving for the slopes at XI.
dx = diff(xi); divdif = diff(yi)./dx(:,dd);
c = spdiags([ [dx(2:n-1,1);0;0] ...
            2*[0;dx(2:n-1,1)+dx(1:n-2,1);0] ...
              [0;0;dx(1:n-2,1)] ], [-1 0 1], n, n);
b = zeros(n,yd);
b(2:n-1,:)=3*(dx(2:n-1,dd).*divdif(1:n-2,:)+dx(1:n-2,dd).*divdif(2:n-1,:));
if ~any(conds)
   c(1,1)=1; c(1,n)=-1;
elseif conds(1)==2
   c(1,1:2)=[2 1]; b(1,:)=3*divdif(1,:)-(dx(1)/2)*valconds(:,1).';
else
   c(1,1:2) = [1 0]; b(1,:) = valconds(:,1).';
   if (valsnotgiven|conds(1)~=1)  % if endslope was not supplied,
                              % get it by local interpolation
     b(1,:)=divdif(1,:);
     if n>2, ddf=(divdif(2,:)-divdif(1,:))/(xi(3)-xi(1));
       b(1,:) = b(1,:)-ddf*dx(1); end
     if n>3, ddf2=(divdif(3,:)-divdif(2,:))/(xi(4)-xi(2));
       b(1,:)=b(1,:)+(ddf2-ddf)*(dx(1)*(xi(3)-xi(1)))/(xi(4)-xi(1)); end
   end
end
if ~any(conds)
   c(n,1:2)=dx(n-1)*[2 1]; c(n,n-1:n)= c(n,n-1:n)+dx(1)*[1 2];
   b(n,:) = 3*(dx(n-1)*divdif(1,:) + dx(1)*divdif(n-1,:));
elseif conds(2)==2
   c(n,n-1:n)=[1 2]; b(n,:)=3*divdif(n-1,:)+(dx(n-1)/2)*valconds(:,2).';
else
   c(n,n-1:n) = [0 1]; b(n,:) = valconds(:,2).';
   if (valsnotgiven|conds(2)~=1)  % if endslope was not supplied,
                              % get it by local interpolation
      b(n,:)=divdif(n-1,:);
      if n>2, ddf=(divdif(n-1,:)-divdif(n-2,:))/(xi(n)-xi(n-2));
        b(n,:) = b(n,:)+ddf*dx(n-1); end
      if n>3, ddf2=(divdif(n-2,:)-divdif(n-3,:))/(xi(n-1)-xi(n-3));
        b(n,:)=b(n,:)+(ddf-ddf2)*(dx(n-1)*(xi(n)-xi(n-2)))/(xi(n)-xi(n-3));
      end
   end
end

  % solve for the slopes ..  (protect current spparms setting)
mmdflag = spparms('autommd');
spparms('autommd',0); % suppress pivoting
s=c\b;
spparms('autommd',mmdflag);

  %                          .. and convert to pp form
c4 = (s(1:n-1,:)+s(2:n,:)-2*divdif(1:n-1,:))./dx(:,dd);
c3 = (divdif(1:n-1,:)-s(1:n-1,:))./dx(:,dd) - c4;
pp = ppmak(xi.', ...
 reshape([(c4./dx(:,dd)).' c3.' s(1:n-1,:).' yi(1:n-1,:).'],(n-1)*yd,4),yd);
