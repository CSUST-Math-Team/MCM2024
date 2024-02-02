clear
clc
[x,y,z] =peaks; 
subplot(2,3,1);
meshz(x,y,z); %曲面加上围裙,即给出曲面和零平面
axis([-inf inf -inf inf -inf inf]); 
subplot(2,3,2);
waterfall(x,y,z); %在x方向产生水流效果
axis([-inf inf -inf inf -inf inf]); 
subplot(2,3,3);
meshc(x,y,z); %同时画出网状图与等高线
axis([-inf inf -inf inf -inf inf]); 
subplot(2,3,4);
surfc(x,y,z); %同时画出曲面图与等高线
axis([-inf inf -inf inf -inf inf]);
subplot(2,3,5)
surfl(x,y,z); %给出带光照效果的彩色表面图
axis([-inf inf -inf inf -inf inf]);
subplot(2,3,6)
contourf(x,y,z);
axis([-inf inf -inf inf -inf inf]);<i