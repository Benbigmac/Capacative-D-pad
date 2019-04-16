float differenceX = 0;
float differenceY = 0;

void serialEvent(Serial port){
try{
   String inData = port.readStringUntil('\n');
   inData = trim(inData);                 // cut off white space (carriage return)

   if (inData.charAt(0) == 'x'){           // leading 'x' means x value has changed by some amt
     inData = inData.substring(1);        // cut off the leading 'x'
     //if(inData.length() != 0)
       differenceX = float(inData)*0.1;
     println("Changing x:" + currentPosX);
   }
   if (inData.charAt(0) == 'y'){          // leading 'y' means y value has changed by some amt
     inData = inData.substring(1);        // cut off the leading 'y'
     //if(inData.length() != 0)
       differenceY = float(inData)*0.1;
     println("Changing y:" + currentPosY);
   }
} catch(Exception e) {
  println(e.toString());
}

}// END OF SERIAL EVENT
