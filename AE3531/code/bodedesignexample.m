clear all
close all

OS=9.5
z=(-log(OS/100))/(sqrt(pi^2+log(OS/100)^2))
PM=atan(2*z/(sqrt(-2*z^2+sqrt(1+4*z^4))))*180/pi

%% Set up system
K=3.6;    % 3.6*K from the preamplifier constant, assume K = 1
G1=tf([100],[1 100]);
G2=tf([1],[1 36]);
G3=tf([1],[1 0]);
GP=K*G1*G2*G3;

figure
bode(GP)

%turn on grid and add stability margins! 

%Note that we can right click and add a grid, and in the charateristics
%menu, we can get it to show our stability margins.  

%Our goal is a tune the gain to achieve a 9.5% overshoot.  



%Using the above equations: 
%We want a damping ratio of .6.  This is achieved when the phase margin is
%59.2.  

%So we need to find the frequency that, if it were the crossover frequency,
%would yield a phase margin of 59.2. In other words, we need to find the
%frequency at which the phase is -180+59.2, or -120.8.  We can look at our
%Bode plot to find that the frequency at this point is 14.8 rad/s.  

%Now, we need to see what the current gain is at the 14.8 frequency mark.
%This will be the amount we need to shift our Bode Plot up by in order to
%meet our 9.5% overshoot goal.  This is found to be -44.2 dB.  We need to
%move this point to 0dB in order to get our required phase margin.
%Therefore, so we need a -44.2 dB increase from where we are.  -20log(K_extra)=-44.2.  K_extra=162.2.  Since we
%started with K=3.6,we need our gain to be K=3.6*162.2 = 583.9  

hold
pause
%% Gain adjusted to get desired %OS
K=583.9;
G1=tf([100],[1 100]);
G2=tf([1],[1 36]);
G3=tf([1],[1 0]);
GP2=K*G1*G2*G3;

bode(GP2)
hold
pause
%turn on grid and add stability margins! 
%So we have a phase margin of 59.2 deg, our %OS is 9.48%, and our Kv=16.22
%We'd like to improve this by a factor of 10 ==>  our target Kv is 162.2

%%  Now let's adjust SSE
% if we want to improve SSE by 10, we can simply multiply the gain by 10.
% So....

K=5839;

G1=tf([100],[1 100]);
G2=tf([1],[1 36]);
G3=tf([1],[1 0]);
GP3=K*G1*G2*G3
figure
bode(GP3)

%So now we have a phase margin problem.  We wanted 59.2, but we got 4.37.
%So we need to add a lag compensator.  Now, we have to recognize that a lag
%compensator is going to change the phase of the system, and experience
%tells us that they will add -5 to -12 degrees of phase margin. So we need
%to add phase lag to our design goal to compensate for this.  



%We want to hit 9.5% on the system, so we'll add 10 deg of phase margin to
%our goal to make sure we can still hit our design target with the lag
%compensator added.  This is generally good rule of thumb, and it can
%always be adjusted at the end to get exactly where we want to be.  

PM_new=PM+10

%With that in mind, we are going to now target a phase margin of 69.2 deg.
%This will occur at the frequency corresponding to -180+69.2=-110.8 deg

Ph=-180+PM_new  %required phase angle

%Now let's actually search for the required frequency.  

w=.01:.01:100;
[M,P]=bode(GP3,w);  %This will give us a vector of gains and phases for all the freqeuncies in w
hold

for k=1:1:length(P);
    if P(k)-Ph<=0;  %Search until we find the frequency in the table closest to our required angle
        M=M(k)  %report the corresponding gain and frequency
        wf=w(k)
        break
    end
end

%So now we know that at 9.81 rad/s, the magnitude plot must go through 0.
%But it currently is at 15.87, which in db is 24.  So the lag compensator
%must provide -24db attenuation at 9.8 rad/s.  In other words, we need the
%high frequency asymptote at -24 dB.  

%So let's start by setting our high frequency break a decade before our 9.8
%frequency where we need to make an impact.  That will be our zero for our
%compensator

wh=wf/10

%From there, we need to find our pole by taking this line at a -20db/dec
%slope all the way back to 0 (where our low freq asymptote is), and find
%the frequency where it intersects with 0 to get our low frequency break
%point, and Kc is chosen to put the high freq asymptote at -24dB  

wl=wh/M

Kc=1/M;

%So let's now write the transfer function for our controller

Gc=zpk(-.98,-.062,.063)

Gfinal=Gc*GP3

%And let's apply it to our system.  
pause

bode(Gfinal,w)

%add grids and margins to plot

figure
step(feedback(Gfinal,1))
