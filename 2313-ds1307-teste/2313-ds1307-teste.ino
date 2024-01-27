#include <TinyWireM.h>

#define ARDUINO_ADDR  0b11010011
#define DS1307_ADDR   0x68
#define LED 6

//bool passou = 0; 

void setup() {
  TinyWireM.begin();

//  TinyWireM.beginTransmission(DS1307_ADDR);
//  TinyWireM.send(0x00);  // Seconds Register
//  TinyWireM.send(0x00); //Ativa o clock
//  TinyWireM.endTransmission();
}

void loop() {

//  data = 0;


//  if(!passou) {
    digitalWrite(LED, HIGH);  // turn the LED on (HIGH is the voltage level)
  
    getData();

   delay(100);
 
    digitalWrite(LED, LOW);   // turn the LED off by making the voltage LOW
//  }

  delay(1000);

}

void getData() {
  TinyWireM.beginTransmission(DS1307_ADDR); // reset DS1307 register pointer 
//  TinyWireM.send(0); //Recupera a partir dos segundos
  TinyWireM.send(1); //Recupera a partir dos minutos
  TinyWireM.endTransmission(); //TODO: Check error

  
  TinyWireM.requestFrom(DS1307_ADDR, 2); //TODO: Check error]
  delay(10);
  sendArduino(TinyWireM.receive());
  sendArduino(TinyWireM.receive());
}

void sendArduino(byte data) {
  TinyWireM.beginTransmission(ARDUINO_ADDR);
  TinyWireM.send(data);
  TinyWireM.endTransmission();
}
