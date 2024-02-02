x = rand(100,1)*16 - 8;
y = rand(100,1)*16 - 8;
r = sqrt(x.^2 + y.^2) + eps;
z = sin(r)./r;
xlin = linspace(min(x),max(x),33);
ylin = linspace(min(y),max(y),33);
[X,Y] = meshgrid(xlin,ylin);
Z = griddata(x,y,z,X,Y,'cubic');
mesh(X,Y,Z) %interpolated
axis tight; hold on
plot3(x,y,z,'.','MarkerSize',15) %nonuniform<i