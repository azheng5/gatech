clf
close all
num_oltf=[1 -4 20];
den_oltf=poly([-2 -4]);
'OLTF G(s)H(s)'
OLTF = tf(num_oltf,den_oltf)
p=pole(OLTF)
z=zero(OLTF)

pause

subplot(2,1,1)
rlocus(OLTF)
z=.2:.1:.9;  %damping ratios from .2 to .9 in steps of .1
wn=0:1:10;  %wn from 1 to 10 in incraments of 1
sgrid(z,wn)  %makes a damping ratio and nautural frequency grid for root locus
title('Root Locus') 

pause
subplot(2,1,2)
rlocus(OLTF)
axis([-3 1 -4 4])
title('Close-up of RL')
z=.45
wn=0;
sgrid(z,wn)

%k is the number of points you will test. This will return gain and closed
%loop poles for your chosen point
for k=1:3
    [K,p]=rlocfind(OLTF)
    
end 
pause
