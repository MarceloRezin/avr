#include <TinyWireM.h>

#define SLAVE_ADDR 0b11010001
#define LED 6

void setup() {
  TinyWireM.begin();
}

void loop() {

  digitalWrite(LED, HIGH);  // turn the LED on (HIGH is the voltage level)
  
  TinyWireM.beginTransmission(SLAVE_ADDR);
  TinyWireM.send(0b10010011);
  TinyWireM.endTransmission(); 

  delay(200);

  digitalWrite(LED, LOW);   // turn the LED off by making the voltage LOW
  
  delay(1000);
}
