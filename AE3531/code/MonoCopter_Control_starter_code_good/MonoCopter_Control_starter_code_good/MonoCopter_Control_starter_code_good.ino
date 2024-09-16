#include <Servo.h>

#define servoPin 9 // signal pin for the ESC.
#define potentiometerPin A0 // analog input pin for the potentiometer.
#define trigPin 4
#define echoPin 5
Servo servo;

//Define Variables:
long duration;
float distance;

// PUT YOUR VARIABLES HERE
float e; //error
float e_prev;
float d_e = 0; // derivative of error
float i_e = 0; // integral of error
float z_d = 0.15; // desired height in m
float z; // actual height
const float g = 9.81; // gravity
const int c = 1400;
float Kp = 12;
float Kd = 0;
float Ki = 4;
int delta = 10;
bool first = true;
float v;


float u;
int u_const;
int u_ant;
int control;

float incomingByte = 0;
float value = 0;

bool start = false;

void setup() {

  // Define inputs and outputs:
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  
  servo.attach(servoPin);
  servo.writeMicroseconds(1100); // send "stop" signal to ESC. Also necessary to arm the ESC.
  
  delay(3000); // delay to allow the ESC to recognize the stopped signal.
  Serial.setTimeout(10);
  Serial.begin(9600);
  
}

void loop() {

  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  // Trigger the sensor by setting the trigPin high for 10 microseconds:
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  // Read the echoPin, pulseIn() returns the duration (length of the pulse) in microseconds:
  duration = pulseIn(echoPin, HIGH);
  // Calculate the distance:
  distance = duration * 0.0343 / 2;
  z = distance/100;


// PUT YOUR CONTROL LOGIC HERE
  e = z_d - z;

  if(first) {
    e_prev = e;
    first = false;
  }
  d_e = 1000*(e-e_prev)/delta;
  i_e = i_e + e*delta/1000;
  e_prev = e;

  v = Kp*e + Kd*d_e + Ki*i_e;


  u = c/g*(g+v); // scale PID output to be in correct range for ESC

  
  u_const = constrain(u,1100,1900);
  int potVal = u_const;//analogRead(potentiometerPin); // read input from potentiometer.
  int pwmVal = map(potVal,0, 1023, 1100, 1900); // maps potentiometer values to PWM value.
  float z_aux = map(potVal,500,1023,2,30);
  //z_d = z_aux/100;
    

  if(potVal<500){
    u_ant = 1100;
    servo.writeMicroseconds(1100);
    i_e = 0;
  }
  else{
    if(u_ant+10<u_const){
      u_const = u_ant + 10;
      }
    servo.writeMicroseconds(u_const); // Send signal to ESC.
    u_ant = u_const;
  }
Serial.print("v: ");
Serial.print(v);
Serial.print("u: ");
Serial.print(u);
Serial.print("Value: ");
Serial.print(u_const);
Serial.print("z: ");
Serial.print(z);
//Serial.print("       Distance: ");
//Serial.println(distance);
Serial.print("       Error: ");
Serial.print(e);
Serial.print("       potVal: ");
Serial.print(potVal);
Serial.print("       z_d: ");
Serial.println(z_d);
    
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.parseFloat();
    if (incomingByte > 2 && incomingByte < 28){
      z_d = incomingByte/100;
      }
    // say what you got:
//    Serial.print("I received: ");
//    Serial.println(incomingByte, DEC);
  }
  delay(delta);
}
