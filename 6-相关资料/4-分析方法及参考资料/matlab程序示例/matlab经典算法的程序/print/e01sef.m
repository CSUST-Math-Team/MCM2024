function [fnodes,minnq,rnw,rnq,ifail]=e01sef(x,y,z);%���ֵ�����Ĳ���
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