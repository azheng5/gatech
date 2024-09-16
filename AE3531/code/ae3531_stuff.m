%%nyquist ex 2
clear all
close all
K=17.1;
num=[1 3];
den= [1 -1 11 -51];
G=tf(num,den)
subplot(1,3,1)
pzmap(K*G)
subplot(1,3,2)
nyquist(K*G)
subplot(1,3,3)
rlocus(G)
hold on
pole=rlocus(G, K);
plot(real(pole),imag(pole),'rx','Markersize',10)
hold off
