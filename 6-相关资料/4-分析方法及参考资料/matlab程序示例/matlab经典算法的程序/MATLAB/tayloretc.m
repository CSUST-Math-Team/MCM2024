clear
clc
syms x; 
f='x^2*(sin(x))^2';
diff(f); 
f1=simple(ans)
diff(f,x,2); 
f2=simple(ans)
diff(f,x,3); 
f3=simple(ans)
diff(f,x,4); f4=simple(ans)
int(f4,x)
taylor(x^2*(sin(x))^2,15,x)<i