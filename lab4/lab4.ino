#include <CapacitiveSensor.h>

CapacitiveSensor   cs_4_2 = CapacitiveSensor(5,6);        // 10 megohm resistor between pins 4 & 2, pin 5 is sensor pin, add wire, foil
CapacitiveSensor   cs_4_6 = CapacitiveSensor(5,11);        // 10 megohm resistor between pins 4 & 6, pin 6 is sensor pin, add wire, foil
CapacitiveSensor   cs_4_8 = CapacitiveSensor(5,12);        // 10 megohm resistor between pins 4 & 8, pin 11 is sensor pin, add wire, foil
CapacitiveSensor   cs_4_9 = CapacitiveSensor(5,13);        // 10 megohm resistor between pins 4 & 8, pin 12 is sensor pin, add wire, foil
const int threshHold = 300;

void setup() {
  // put your setup code here, to run once:
  cs_4_2.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
   Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
    long start = millis();
    long total1 =  cs_4_2.capacitiveSensor(30);
    long total2 =  cs_4_6.capacitiveSensor(30);
    long total3 =  cs_4_8.capacitiveSensor(30);
    long total4 = cs_4_9.capacitiveSensor(30);
    
    Serial.print(millis() - start);        // check on performance in milliseconds
    Serial.print("\t");                    // tab character for debug window spacingk

    Serial.print(total1);                  // print sensor output 1
    Serial.print("\t");
    Serial.print(total2);                  // print sensor output 2
    Serial.print("\t");
    Serial.print(total3);                // print sensor output 3
     Serial.print("\t");
   Serial.println(total4);
   if(total1 == -2){
    Serial.println("Pin 9 is doing you a dirty");  
   }
   if(total2 == -2){
    Serial.println("Pin 10 is doing you a dirty");  
   }
    if(total3 == -2){
    Serial.println("Pin 11 is doing you a dirty");  
   }
    if(total4 == -2){
    Serial.println("Pin 12 is doing you a dirty");  
   }

    
}
