%% Question 7
num = [1.151 0.1774];
den = [1 0.739 0.921 0];
pitch_tf = tf(num,den)

A = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0];
B = [0.232; 0.0203; 0];
C = [0 0 1];
D = [0];
pitch_ss = ss(A,B,C,D)

%% Question 8
clear
clc

m = 1;
b = 0;
k = 25;

num = [1];
den = [m b k];
sys = tf(num,den);
p = pole(sys);
z = zero(sys);

system response to impulse
[x,t] = impulse(sys,20);
figure
plot(t,x)
grid on
title('Impulse Response')
xlabel('Time')
ylabel('Position')

system response to unit step
[x,t] = step(sys,20);
figure
plot(t,x)
grid on
title('Step Response')
xlabel('Time')
ylabel('Position')

%% Question 9
clear
clc

m = 1;
b = 3.2;
k = 2.56;

num = [1];
den = [m b k];
sys = tf(num,den);
p = pole(sys)
z = zero(sys);

% system response to unit step
[x,t] = step(sys,20);
figure
plot(t,x)
grid on
title('Step Response')
xlabel('Time')
ylabel('Position')

%% Question 11
clear
clc
close

num = [1];
den = [1 10 25];
Gp = tf(num,den)
p = pole(Gp)
z = zero(Gp)

% Part 11b
figure

Gp1 = 0.1*Gp;
p = pole(Gp1)
z = zero(Gp1)

subplot(3,3,1);
axis off
text(0.5, 0.5, 'poles: (-5, 5), zeros: (none)' , 'FontSize', 12, 'HorizontalAlignment', 'center');

subplot(3,3,2);
pzmap(Gp1);

subplot(3,3,3);
[x,t] = step(Gp1);
plot(t,x)
grid on
title('Step Response - K=0.1')
xlabel('Time')
ylabel('Output')

Gp2 = Gp;
p = pole(Gp2)
z = zero(Gp2)

subplot(3,3,4);
axis off
text(0.5, 0.5, 'poles: (-5, 5), zeros: (none)' , 'FontSize', 12, 'HorizontalAlignment', 'center');

subplot(3,3,5);
pzmap(Gp2);

subplot(3,3,6);
[x,t] = step(Gp2);
plot(t,x)
grid on
title('Step Response - K=1')
xlabel('Time')
ylabel('Output')

Gp3 = 10*Gp;
p = pole(Gp3)
z = zero(Gp3)

subplot(3,3,7);
axis off
text(0.5, 0.5, 'poles: (-5, 5), zeros: (none)' , 'FontSize', 12, 'HorizontalAlignment', 'center');

subplot(3,3,8);
pzmap(Gp3);

subplot(3,3,9);
[x,t] = step(Gp3);
plot(t,x)
grid on
title('Step Response - K=10')
xlabel('Time')
ylabel('Output')

%% Part 11d
zeros = [-2 -5];
poles = [0];
gain = 1;
Gc = zpk(zeros,poles,gain);
K = 1;
sys = feedback(K*Gp*Gc,1);

figure

sys1 = 0.1*sys;
p = pole(sys1)
z = zero(sys1)

subplot(3,3,1);
axis off
text(0.5, 0.5, 'poles: (-0.3542, -5.6458, -5), zeros: (-5,-2)' , 'FontSize', 12, 'HorizontalAlignment', 'center');

subplot(3,3,2);
pzmap(sys1);

subplot(3,3,3);
[x,t] = step(sys1);
plot(t,x)
grid on
title('Step Response - K=0.1')
xlabel('Time')
ylabel('Output')

sys2 = sys;
p = pole(sys2)
z = zero(sys2)

subplot(3,3,4);
axis off
text(0.5, 0.5, 'poles: (-0.3542,-5.6458,-5), zeros: (-5,-2)' , 'FontSize', 12, 'HorizontalAlignment', 'center');

subplot(3,3,5);
pzmap(sys2);

subplot(3,3,6);
[x,t] = step(sys2);
plot(t,x)
grid on
title('Step Response - K=1')
xlabel('Time')
ylabel('Output')

sys3 = 10*sys;
p = pole(sys3)
z = zero(sys3)

subplot(3,3,7);
axis off
text(0.5, 0.5, 'poles: (-0.3542,-5.6458,-5), zeros: (-5,-2)' , 'FontSize', 12, 'HorizontalAlignment', 'center');

subplot(3,3,8);
pzmap(sys3);

subplot(3,3,9);
[x,t] = step(sys3);
plot(t,x)
grid on
title('Step Response - K=10')
xlabel('Time')
ylabel('Output')
