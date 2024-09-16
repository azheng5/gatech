%% Question 2

% define tf for plant
s = tf('s');
P_pitch = (1.151*s+0.1774)/(s^3+0.739*s^2+0.921*s);

controlSystemDesigner('rlocus', P_pitch)

%% Question 3a
clear
clc

oltf = tf([1],[1 6 11 6]);
cltf = feedback(oltf,1)

rlocus(oltf)
title('Question 3: root locus')

step(cltf)
title('Question 3: step response')

%% Question 3b
clear
clc

% find s at intersection point of damping ratio line and root locus
datacursormode 'on'
oltf = tf([1],[1 6 11 6]);
rlocus(oltf)
sgrid(0.78,10)

%% Question 3g
clear
clc

Gp = tf([1],[1 6 11 6]);
K = 1.3;
Gc = tf([K 2*K],[1]);
G = Gp*Gc;
CLTF = feedback(G,1);
step(CLTF)
title('Question 3g: step response')

% test to see if 2nd order approx is appropriate
% by removing the 3rd open loop pole s=-3
Gp_new = tf([1],[1 3 2]);
K = 1.3;
Gc = tf([K 2*K],[1]);
G = Gp_new*Gc;
CLTF = feedback(G,1);
step(CLTF)

%% Question 4a
clear
clc

Gp_inner = tf([25],[1 1 25]);


% find s at intersection point of damping ratio line and root locus
datacursormode 'on'
rlocus(Gp_inner)
sgrid(0.46,100)

%% Question 4b
clear
clc

Gp = tf([25],[1 30 1200 0]);


%% Question 5
clear
clc

Gp = tf([1],[1 7 0]);

% find s at intersection point of damping ratio line and root locus
datacursormode 'on'
rlocus(Gp)
sgrid(0.52,10)

%% Question 5b
clear
clc

Gc = tf([1 0.02],[1 0.01]);
Gp = tf([1],[1 7 0]);
G = Gc * Gp;
rlocus(G)
title("Question 5b: root locus")

CLTF = feedback(G,1);
step(CLTF)
title("Question 5b: step response")

%% Question 6
clear
clc

Gc = tf([1 10],[1 25.57]);
Gp = tf([1],[1 7 0]);
G = Gc * Gp;

datacursormode 'on'
rlocus(G)
sgrid(0.52,500)
title('Question 6: root locus')

CLTF = feedback(186.8*G,1);
step(CLTF)
title("Question 6: step response")