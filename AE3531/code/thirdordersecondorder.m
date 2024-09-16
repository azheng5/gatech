figure
num1=[24.542];
den1=[1 4 24.542];
sys1=tf(num1,den1)
pole(sys1)
a=1;
num2=[24.542*a];
den2=[1 (4+a) 24.542+a*4 24.542*a];
sys2=tf(num2,den2)
pole(sys2)
subplot(2,1,1)
step(sys2,sys1)
legend("second order","third order")
subplot(2,1,2)
title("Second order system")
pzmap(sys2,sys1)
