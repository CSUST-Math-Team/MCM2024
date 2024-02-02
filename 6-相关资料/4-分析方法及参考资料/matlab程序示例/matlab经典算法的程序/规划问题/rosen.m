[x,y]=meshgrid(-2:0.1:2,-1:0.1:3);
z=100*(y-x.^2).^2+(1-x).^2;
figure(1);
mesh(x,y,z)
figure(2);
contour(x,y,z,20)
drawnow
hold on
plot(-1.2,2,'o');
text(-1.2,2,'start point')
plot(1,1,'o')
text(1,1,'solution')<i