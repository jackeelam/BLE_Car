
/*define the pins for the left motor*/
#define EN1 12
#define IN1 11
#define IN2 10

/*define the pins for the right motor*/
#define EN2 4 //was 7
#define IN4 6
#define IN3 5

/*Driving Functions*/
void reverse()
{
   /*Both motors in reverse*/
   analogWrite(EN1,150);
   digitalWrite(IN1,HIGH);
   digitalWrite(IN2,LOW);

   analogWrite(EN2,150);
   digitalWrite(IN3,HIGH);
   digitalWrite(IN4,LOW);
}

void forward()
{
  /*Both motors forward*/
   analogWrite(EN1,150);  //second parameter is the speed
   digitalWrite(IN1,LOW);
   digitalWrite(IN2,HIGH);

   analogWrite(EN2,150);
   digitalWrite(IN3,LOW);
   digitalWrite(IN4,HIGH);
}

void stop_car()
{
  digitalWrite(EN1,LOW);
  digitalWrite(EN2,LOW);
  analogWrite(IN1,LOW);
  analogWrite(IN2,LOW);
  analogWrite(IN3,LOW);
  analogWrite(IN4,LOW);
}

void turn_right()
{
  //enable the left motor
  analogWrite(EN1,150);
  digitalWrite(IN1,LOW);
  digitalWrite(IN2,HIGH);

  //disable the right motor
  analogWrite(EN2,150);
  digitalWrite(IN3,HIGH);
  digitalWrite(IN4,LOW);
}

void turn_left()
{
  //enable the left motor
  analogWrite(EN1,150);
  digitalWrite(IN1,HIGH);
  digitalWrite(IN2,LOW);

  //enable the right motor
  analogWrite(EN2,150);
  digitalWrite(IN3,LOW);
  digitalWrite(IN4,HIGH);
}


//If connecting to laptop doesnt work, just turn bluetooth on laptop off and redo
#include <SoftwareSerial.h>
int state = 0;
SoftwareSerial mySerial(8,7); //RX,TX
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);
  mySerial.begin(9600); //needs to be 9600, default baudrate of HC05 module
}
void loop() {
  if(mySerial.available() > 0){ // Checks whether data is comming from the serial port
    Serial.println("Received");
    state = mySerial.read(); // Reads the data from the serial port
 }
 //Accelerate
 if (state == 'A') {
  digitalWrite(LED_BUILTIN, LOW); // Turn LED OFF
  mySerial.println("Received Acceleration"); // Send back, to the phone, the String "LED: ON"
  state = 0;
 }
 //Brake
 else if (state == 'S') {
  digitalWrite(LED_BUILTIN, HIGH);
  mySerial.println("Received Stop");
  stop_car();
  state = 0;
 } 
 //Forward
 else if(state == 'F'){
  mySerial.println("Received Forward");
  forward();
 }
 else if(state == 'B'){
  mySerial.println("Received Backward");
  reverse();
 }
 else if(state == 'L'){
  mySerial.println("Received Left");
  turn_left();
 }
 else if(state == 'R'){
  mySerial.println("Received Right");
  turn_right();
 }
 
}
