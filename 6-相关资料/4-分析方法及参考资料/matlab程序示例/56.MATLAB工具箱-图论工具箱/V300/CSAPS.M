function output = csaps(x,y,p,xx,w)
%pp=csaps(x,y,p)实现光滑拟合,其中,p为权因子,0<p<1,p值越大,与数据越接近.
%特别地,若p=0, 则为线性拟合,若p=1,则为自然样条.
%
%CSAPS Cubic smoothing spline.
%
%   VALUES  = CSAPS( X, Y, P [, XX [, W ]])
%
%   Returns the values at XX of the cubic smoothing spline for the
%   given data (X,Y)  and depending on the smoothing parameter P from
%   [0 .. 1] .  This smoothing spline  f  minimizes
%
%   P * sum_i W(i)(Y(i) - f(X(i)))^2  +  (1-P) * integral (D^2 f)^2
%
%   For  P=0, the smoothing spline is the least-squares straight line fit to
%   the data, while, on the other extreme, i.e., for  P=1, it is
%   the `natural' or variational cubic spline interpolant.  The
%   transition region between these two extremes is usually only a
%   rather small range of values for P and its location strongly
%   depends on the data.
%
%   If the argument XX is missing or is empty, the ppform of the cubic
%   smoothing spline is returned instead, for later use with FNVAL, FNDER,
%   etc.
%
%   The default for the weight vector W is ONES(LENGTH(X),1);
%
%   For example, 
%
%      x = linspace(0,2*pi,21); y = sin(x)+(rand(1,21)-.5)*.1;
%      pp = csaps(x,y,.4,[],[ones(1,11), repmat(5,1,10)]);
%
%   returns a smoothed version of the data which is much closer to the data
%   in the right half, because of the much larger weight there.
%
%   It is in general difficult to choose the parameter P without
%   experimentation. For that reason, use of SPAPS is recommended instead
%   since there P is chosen so as to produce the smoothest spline within a
%   specified tolerance of the data.
%
%   It is also possible to smooth data on a rectangular grid and
%   obtain smoothed values on a rectangular grid or at scattered
%   points, by the calls
%
%   VALUES = CSAPS( {X1, ...,Xm}, Y, P, XX [, W ])
%   or
%   PP = CSAPS( {X1, ...,Xm}, Y, P, [, [], W ])
%
%   in which Y is expected to have size [d,length(X1),...,.length(Xm)]
%   (or [length(X1),...,.length(Xm)] if the function is to be scalar-valued),
%   and P is either a scalar or an m-vector,
%   and XX is either a list of m-vectors XX(:,j) or else a cell-array 
%   {XX1, ..., XXm} specifying the m-dimensional grid at which to evaluate
%   the interpolant, and, correspondingly, W, if given, is a cell array of
%   weight sequences for the m dimensions (with an empty Wi indicating the
%   default choice).
%
%   See also SPAPS, CSAPSDEM.

%   Carl de Boor 2 sep 89
%   cb :  9 may '95 (use .' instead of ')
%   cb : 23 oct '95 (use sparse matrices, handle vector-valued ordinates)
%   cb : 09 mar 96 (correct mistake in sparse matrix formula for R)
%   cb : 03 mar 97 (optionally provide a weight vector)
%   cb : 06oct97 (improve the help)
%   cb : 26oct97 (also handle gridded data
%   Copyright (c) 1987-98 by C. de Boor and The MathWorks, Inc.
%   $Revision: 1.5 $

if nargin<4, xx = []; end
if nargin<5, w = []; end
   
if iscell(x)     % we are to handle gridded data

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
   
   if length(p)~=m, p = repmat(p(1),1,m); end
   if isempty(w), w = cell(1,m); end

   v = y; sizev = sizey;
   for i=m:-1:1   % carry out coordinatewise smoothing
      [b,v,l,k] = ppbrk(csaps1(x{i}, reshape(v,prod(sizev(1:m)),sizev(m+1)),...
                        p(i), [], w{i} ));
      breaks{i} = b;
      sizev(m+1) = l*k; v = reshape(v,sizev);
      if m>1
         v = permute(v,[1,m+1,2:m]); sizev(2:m+1) = sizev([m+1,2:m]);
      end
   end
   % At this point, V contains the tensor-product pp coefficients;
   % It remains to make up the formal description:
   if isempty(xx)
      output = ppmak(breaks, v);
   else
      output = fnval(ppmak(breaks,v),xx);
   end

else             % we have univariate data

   output = csaps1(x,y,p,xx,w);

end


function output = csaps1(x,y,p,xx,w)
n=length(x);[xi,ind]=sort(x);xi=xi(:);
output=[];
if n<2, error('There should be at least two data points.'), end
if all(diff(xi))==0, error('The data abscissae should be distinct.'), end

[yd,yn] = size(y); % if y happens to be a one-column matrix, change it to
                   % a one-row matrix.
if yn==1, yn=yd; y=reshape(y,1,yn); yd=1; end

if n~=yn
   error('Abscissa and ordinate vector should be of the same length.')
end

yi=y(:,ind).'; dd = ones(1,yd);
dx=diff(xi); divdif=diff(yi)./dx(:,dd);
if n==2 % the smoothing spline is the straight line interpolant
   pp=ppmak(xi.',[divdif.' yi(1,:).'],yd);
else % set up the linear system for solving for the 2nd derivatives at  xi .
     % this is taken from (XIV.6)ff of the `Practical Guide to Splines'
     % with the diagonal matrix  D = eye(n,n) .
     % Make use of sparsity of the system.
   R = spdiags([dx(2:n-1), 2*(dx(2:n-1)+dx(1:n-2)), dx(1:n-2)],...
                                         -1:1, n-2,n-2);
   odx=ones(n-1,1)./dx;
   Qt = spdiags([odx(1:n-2), -(odx(2:n-1)+odx(1:n-2)), odx(2:n-1)], ...
                                                0:2, n-2,n);
   % solve for the 2nd derivatives
   if isempty(w), w = ones(n,1); end
   W = spdiags(ones(n,1)./w(:),0,n,n);
   u=(6*(1-p)*Qt*W*Qt.'+p*R)\diff(divdif);
   % ... and convert to pp form
   % Qt.'*u=diff([0;diff([0;u;0])./dx;0])
   yi = yi - ...
    (6*(1-p))*W*diff([zeros(1,yd)
                 diff([zeros(1,yd);u;zeros(1,yd)])./dx(:,dd)
                 zeros(1,yd)]);
   c3 = [zeros(1,yd);p*u;zeros(1,yd)];
   c2=diff(yi)./dx(:,dd)-dx(:,dd).*(2*c3(1:n-1,:)+c3(2:n,:));
   pp=ppmak(xi.',...
     reshape([(diff(c3)./dx(:,dd)).',3*c3(1:n-1,:).',c2.',yi(1:n-1,:).'],...
                                                            (n-1)*yd,4),yd);
end

if isempty(xx)
   output=pp;
else
   output=ppual(pp,xx);
end
