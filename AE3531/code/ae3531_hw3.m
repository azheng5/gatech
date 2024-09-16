%% Question 3
clear
clc

% find s at intersection point of damping ratio line and root locus
datacursormode 'on'
sys = tf([1],[1 5 4 0]);
rlocus(sys)
sgrid(0.6,1)

% solve for K
s = -0.42 + 0.56i; % determined from sgrid plot
K = abs(s*(s^2 + 5*s + 4));

% find Closed loop poles at K = 2.045
cltf = tf([2.045],[1 5 4 2.045]);
p = pole(cltf);

[y,t] = step(feedback(sys,K));
figure
plot(t,y)
grid on
xlabel('time (sec)')
ylabel('output')
title('Question 3 Step Response')
%% Question 7
clear
clc

datacursormode 'on'
sys = tf([1 0.3],[1 8 21 -82 0]);

rlocus(sys)
sgrid

%% Question 8a
clear
clc

sys = tf([311.52],[1 16.097 311.52]);
pole(sys)
%% Question 8b
clear
clc

sys = tf([1 8],[1 19 108 180]);
rlocus(sys)