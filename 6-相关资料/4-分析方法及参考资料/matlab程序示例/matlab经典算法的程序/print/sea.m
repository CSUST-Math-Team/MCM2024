clear;
x=[129 140 103.5 88 185.5 195 105.5 157.5 107.5 77 81 162 162 117.5];
y=[7.5 141.5 23 147 22.5 137.5 85.5 -6.5 -81 3 56.5 -66.5 84 -33.5];
plot(x,y,'+');
z=[-4 -8 -6 -8 -6 -8 -8 -9 -9 -8 -8 -9 -4 -9];
[fnodes,minnq,rnw,rnq,ifail]=e01sef(x,y,z);%���ֵ�����Ĳ���
nx=100;
px=linspace(75,200,nx);
ny=200;
py=linspace(-50,150,ny);
for i=1:ny
   for j=1:nx
      [pf(i,j),ifail]=e01sff(x,y,z,rnw,fnodes,px(j),py(i));%���ֵֵ
   end
end
figure(2)
meshz(px,py,pf+5)%�����׵�òͼ
figure(3)
contour(px,py,pf,[-5 -5]) %�����Ϊ5�ĺ��׵�ֵ��ͼ
grid
[i1,j1]=find(pf<-5);
for k=1:length(1)
   pf(i1(k),j1(k))=-5;
end
figure(4)
meshc(px,py,pf) %��ˮ�����5Ӣ�ߵĲ��ֺ�������ͼ
rotate3d  <i