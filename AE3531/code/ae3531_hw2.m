%% Question 4b
sys1 = tf([0.5 1],[1])
sys2 = tf([10],[1 0 4])
sysg = series(sys1,sys2)
sys = feedback(sysg,[1])

%% Question 6 - P controller

figure
index = 1;
for K = [0.1 1 5 10 25]
    cltf = tf([16*K],[1,2.4,(0.8+0.8*K)])
    pole(cltf);
    [y,t] = step(cltf)
    
    subplot(1,5,index)
    plot(t,y)
    grid on
    title(sprintf("K = %f",K))
    xlabel('time')
    ylabel('out')
    
    index = index + 1;
end

%% Question 6e - PD controller
clear
clc

figure
index = 1;
for K = [0.1 1 5 10 25]
    cltf = tf( [(12.8*K),(51.2*K)] , [1,(2.4+0.64*K),(0.8+2.56*K)]);
    pole(cltf)
    [y,t] = step(cltf);
    
    subplot(1,5,index)
    plot(t,y)
    grid on
    title(sprintf("K = %f",K))
    xlabel('time')
    ylabel('out')
    xlim([0,10])
    
    index = index + 1;
end

%% Question 7
clear
clc

% initialize tfs
tfs(1) = tf([25],[1,12,25])
tfs(2) = tf([25],[1,10,25])
tfs(3) = tf([25],[1,8,25])
tfs(4) = tf([25],[1,6,25])
tfs(5) = tf([25],[1,4,25])
tfs(6) = tf([25],[1,2,25])
tfs(7) = tf([25],[1,0,25])
tfs(8) = tf([100],[1,10,25])
tfs(9) = tf([100],[1,8,100])

% initialize data
poles = zeros(9,2)
Tr = zeros(9,1)
Ts = zeros(9,1)
Tp = zeros(9,1)
POS = zeros(9,1)

% loop thru each tf
figure
for i = 1:9
    poles(i,:) = pole(tfs(i))
    S = stepinfo(tfs(i))
    Tr(i) = S.RiseTime;
    Ts(i) = S.SettlingTime;
    Tp(i) = S.PeakTime;
    POS(i) = S.Overshoot;

    [y,t] = step(tfs(i));
    
    plot(t,y)
    hold on

end
grid on
title('Question 7: Step Responses of 2nd order systems')
xlabel('time (sec)')
ylabel('output')
xlim([0,7])
legend('a','b','c','d','e','f','g','h','i')
out = [poles Tr Ts Tp POS]

%% Question 9c
clear
clc

cltf = tf([17],[1,2,17]);
S = stepinfo(cltf);
[wn,zeta] = damp(cltf);

[y,t] = step(cltf);
figure
plot(t,y)
grid on
title('Question 9c')
xlabel('time (sec)')
ylabel('output')

%% Question 9d
clear
clc

figure

cltf = tf([17],[1,2,17]);
[y,t] = step(cltf);
plot(t,y)
hold on

for a = [0.001 0.01 0.1 1 10 100]
    cltf = tf([17],[1,(2+a),(2*a+17),(17*a)]);

    [y,t] = step(cltf);
    plot(t,y)
    hold on
end
grid on
title('Question 9d')
xlabel('time (sec)')
ylabel('output')
xlim([0,8])
legend('2nd order','a=0.001','a=0.01','a=0.1','a=1','a=10','a=100')

%% Question 9e
syms a A B C D
S = solve( A + C + D == 0, A*a + 2*C + D*a + 2*D + B == 0, B*a + 17*C + 2*D*a + 17*D == 0, D == 1/a, [A,B,C,D]);

%% Question 9f
clear
clc

figure

cltf = tf([17],[1,2,17]);
[y,t] = step(cltf);
plot(t,y)
hold on

for a = [0.001 0.01 0.1 1 10 100]
    cltf = tf([17,(17*a)],[1,2,17]);

    [y,t] = step(cltf);
    plot(t,y)
    hold on
end
grid on
title('Question 9f')
xlabel('time (sec)')
ylabel('output')
xlim([0,8])
legend('2nd order','a=0.001','a=0.01','a=0.1','a=1','a=10','a=100')

%% Question 10e
clear
clc

tf_old = tf([1 0],[1,4,13]);
tf_new = tf([1,26],[1 4 13]);

[y,t] = step(tf_old);

figure
plot(t,y)
hold on

[y,t] = step(tf_new);
plot(t,y)
grid on
title('Question 10e')
xlabel('time (sec)')
ylabel('output')
legend('z=0','z=-26')
xlim([0,4])