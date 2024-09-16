Notes that are worth noting that aren't directly easily observable in the class notes.

### Modeling dynamic systems

- The solution to differential equations is a combination of two forms (sinusoidal and exponential)
- LTI systems are linear and time invariant. Linear systems follow the principle of homogeneity and superposition, and time invariant means system responds the same way no matter when the input is given
- num of states = order of diff eq = min num of variables
- linear systems can be converted between transfer functions, state space models, and systems of differential equations using matlab
- Airtcraft are modeled by a set of six nonlinear coupled diffeqs, but under certain assumptions they can be linearized into longitudinal and lateral equations
  - pitch is governed by longitudinal dynamics

### Block diagrams

- Blocks are just transfer functions
- A closed loop system can be simplified into a singular block known as the closed loop transfer function, which takes in a desired state and outputs the system state
- If a signal splits off into two paths, an equivalent representation is to generate the signal twice the same way, and source them from two different places

### Transient response analysis

- poles of open loop transfer function tell us abt natural response
- poles of input function tell us abt forced response
- poles of closed loop transfer function tell us abt total response
- zeros give insight abt amplitudes of forced and natural responses
- 1st order systems only have an exponential component, while 2nd order systems are a combination of sinusoidal and exponential components
- There are 4 types of responses: overdamped, underdamped, critically damped, undamped
  - overdamped - 2 real poles, initially fast rise but long time to reach s.s
  - underdamped - 2 complex poles, damped exponentially decaying sinusoid
  - undamped - 2 purely imaginary poles, purely sinusoidal response
  - critically damped - double real poles, has shortest time to ss with no overshoot and is average of under and overdamped
- 

### PID

- increasing P gain: reduce time to steady state
- increasing I gain: reduce steady state error
- increasing D gain: reduce oscillations and overshoot
- 

### Root locus

### Steady state error

- A velocity control system is just a position control system with a ramp input

### Lead lag compensators

- When to use PD vs lead controller:

### Feedback controller

![1714578759406](image/ae3531/1714578759406.png)

- Feedback controllers are often nested in the inner loop. Ie inner loop is ailerons and outer loop is rudder

### Bode diagrams

### Nyquist plots

### State space control
