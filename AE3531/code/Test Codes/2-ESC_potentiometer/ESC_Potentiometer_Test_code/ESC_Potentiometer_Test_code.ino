#include <Servo.h>

byte servoPin = 9; // signal pin for the ESC.
byte potentiometerPin = A0; // analog input pin for the potentiometer.
Servo servo;

void setup() {
servo.attach(servoPin);
servo.writeMicroseconds(1100); // send "stop" signal to ESC. Also necessary to arm the ESC.

delay(7000); // delay to allow the ESC to recognize the stopped signal.
Serial.begin(9600);
}

void loop() {

int potVal = analogRead(potentiometerPin); // read input from potentiometer.

int pwmVal = map(potVal,0, 1023, 1100, 1900); // maps potentiometer values to PWM value.
Serial.print("Value: ");
Serial.println(pwmVal);
servo.writeMicroseconds(pwmVal); // Send signal to ESC.

delay(20);
}
