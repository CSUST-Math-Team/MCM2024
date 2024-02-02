%数据分析fourier变换例子
clear;N=128;%为提高速度选择2的幂
t=linspace(0,5,N);
f=6*exp(-2*t);subplot(1,2,1);plot(t,f);hold on;
DF=fft(f);subplot(1,2,2);plot(DF,'ko');hold on;
df=ifft(DF);
subplot(1,2,1);plot(t,real(df),'r.');hold off;
w=linspace(0,2*pi,N);
F=6./(2+i*w)*N/(2*pi);
subplot(1,2,2);
plot(F);hold off;
