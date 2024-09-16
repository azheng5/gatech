%% Question 2
clear
clc

A = [-2 179; -0.25 -15];
B = [-27;-45];
C = [1 1];
D=0;

%% Question 2c

p = [-10+17.32i, -10-17.32i];

K = place(A,B,p);
A_cl = A-B*K;
sys_cl = ss(A_cl,B,C,D);
p_cl = pole(sys_cl);

% confirm damping ratio and natural freq
damp(sys_cl);

%% Question 3
clear
clc

A = [-2 -1 -3;0 -2 1; -7 -8 -9];
B = [2;1;2];
C = [4 6 8];

C_M = [B A*B A^2*B];
O_M = [C;C*A;C*A^2];

rank(C_M)
rank(O_M)

%% Question 4
clear
clc

% define state space model
A = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0];
B = [0.232; 0.0203; 0];
C = [0 0 1];
D = [0];

% check for controllability
C_M = [B A*B A^2*B];
controllabillity = rank(C_M)

% compute optimal gain
p = 2;
Q = p*C'*C;
R = 1;
[K] = lqr(A,B,Q,R);

% plot closed loop step response
sys_cl = ss(A-B*K, B, C, D);
% step(0.2*sys_cl)
% ylabel('pitch angle (rad)');
% title('Question 4: Closed-Loop Step Response: LQR');

% plot improved closed loop step response
p = 50;
Q = p*C'*C;
R = 1;
[K] = lqr(A,B,Q,R)
sys_cl = ss(A-B*K, B, C, D);
% step(0.2*sys_cl)
% ylabel('pitch angle (rad)');
% title('Question 4: Closed-Loop Step Response: LQR');

% fix SSE by adding precompensator Nbar
Nbar = rscale(A,B,C,D,K)
sys_cl = ss(A-B*K,B*Nbar,C,D);
% step(0.2*sys_cl)
% ylabel('pitch angle (rad)');
% title('Question 4: Closed-Loop Step Response: LQR with Precompensation');

% try R>>Q, R<<Q, and R~=Q
p = 1;
Q = p*C'*C;
R = 100;
[K] = lqr(A,B,Q,R)
sys_cl = ss(A-B*K, B, C, D);
subplot(1,3,1)
step(0.2*sys_cl)
ylabel('pitch angle (rad)');
title('Question 4: R>>Q');

p = 100;
Q = p*C'*C;
R = 1;
[K] = lqr(A,B,Q,R)
sys_cl = ss(A-B*K, B, C, D);
subplot(1,3,2)
step(0.2*sys_cl)
ylabel('pitch angle (rad)');
title('Question 4: R<<Q');

p = 10;
Q = p*C'*C;
R = 10;
[K] = lqr(A,B,Q,R)
sys_cl = ss(A-B*K, B, C, D);
subplot(1,3,3)
step(0.2*sys_cl)
ylabel('pitch angle (rad)');
title('Question 4: R~=Q');
