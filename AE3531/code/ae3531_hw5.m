%% Question 1
clear
clc
close all

Gp = tf([144000],[1 136 3600 0]);
Gc = 2.38*tf([1,25.19],[1,59.97]);
G = Gc*Gp;
CLTF = feedback(G,1)

% bode(G)
% grid on
% title('Question 1n: Bode plot')

step(CLTF)
title('Question 1n: Step response')
grid on

%% Question 2c
clear
clc
close all

G1 = zpk([],[0,-2,-4],[1])
G2 = zpk([-5],[-2,-4],[1])
G3 = zpk([-3,-5],[0,-2,-4],[1])

%%
subplot(1,2,1)
nyquist(G1)

subplot(1,2,2)
rlocus(G1)

sgtitle('Question 2i')
%%
subplot(1,2,1)
nyquist(G2)

subplot(1,2,2)
rlocus(G2)

sgtitle('Question 2ii')
%%
subplot(1,2,1)
nyquist(G3)

subplot(1,2,2)
rlocus(G3)

sgtitle('Question 2iii')

%% Question 3
clear
clc
close all

K = 1;
G = zpk([],[6,-20,-35],[K]);

% bode(G)
% title('Question 3: Bode diagrams')
% grid on

nyquist(G)
title('Question 3: Nyquist diagram')
grid on

%% Question 4
clear
clc
close all

K=490.174;
G = zpk([],[-2,-4,-6],[K]);

nyquist(G)
title('Question 4: Nyquist diagram')
grid on

%% Question 5
% freq (rad/s)  gain (dB)   phase (deg)
data = [0.1	-13.96899489	2.232170768
0.137586821	-13.95972571	3.068275722
0.218660658	-13.92989288	4.861468336
0.347507728	-13.85551897	7.667575979
0.552278687	-13.67361538	11.95938182
0.877712129	-13.248135	18.17561498
1	-13.05394797	20.28151934
1.195312086	-12.71521688	23.36378103
1.899656715	-11.3424269	31.6816687
2.21686748	-10.70951844	34.17451522
3.019040531	-9.205233111	37.94849931
4.116265993	-7.476595765	39.3554527
6.53419319	-4.869844199	36.08170581
10	-2.883180301	27.97947439
14.14213562	-1.760912591	19.16545573
22.47547165	-0.964198458	6.233562827
35.7192746	-0.835615513	-7.220959632
56.76706579	-1.340468889	-21.60946243
90.21739089	-2.637075511	-37.00087884
100	-3.051776864	-40.4351697
122.8625356	-4.023431896	-47.1366953
195.2600024	-6.834760315	-60.53637971
310.3180993	-10.26955046	-70.66201387
493.1748519	-14.03671845	-77.60840143
783.7810141	-17.95470017	-82.14433109
1000	-20.04363064	-83.83105957
1067.392016	-20.60479716	-84.21838263
1696.358996	-24.60556611	-86.35612832
2695.948443	-28.62026023	-87.70569944
4284.551811	-32.64049582	-88.5559976
5000	-33.98115359	-88.76256407
10000	-40.00043844	-89.3812247];

%% Question 5a

subplot(2,1,1)
semilogx(data(:,1),data(:,2))
title('Question 5a: Gain Plot from SysID')
xlabel('frequency (rad/s)')
ylabel('gain (dB)')
grid on

subplot(2,1,2)
semilogx(data(:,1),data(:,3))
title('Question 5a: Phase Plot from SysID')
xlabel('frequency (rad/s)')
ylabel('phase(deg)')
grid on

%% Question 5b
G = zpk([-1],[-30,-10],[50]);
bode(G,{0.1,10000})
title('Question 5c: Estimated bode diagram')
grid on