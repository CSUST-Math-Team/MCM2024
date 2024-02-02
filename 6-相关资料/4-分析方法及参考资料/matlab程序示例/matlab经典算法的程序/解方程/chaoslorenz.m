clear
clc
t_final=100;
x0=[0;0;1e-10];
[t,x]=ode45('lorenzeq',[0,t_final],x0);
plot(t,x)
figure; 
plot3(x(:,1),x(:,2),x(:,3)); 
axis([10 40 -20 20 -20 20]);
figure;
comet3(x(:,1),x(:,2),x(:,3)); 
axis([10 40 -20 20 -20 20]);<i