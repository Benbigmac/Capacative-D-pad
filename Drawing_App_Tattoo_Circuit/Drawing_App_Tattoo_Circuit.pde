import processing.serial.*;  // serial library lets us talk to Arduino
PFont font;
PFont portsFont;

color eggshell = color(255, 253, 248);
color grey = color(211, 211, 211);
color etchRed = color(200, 0, 0);
color gold = color(255, 215, 0);

// SERIAL PORT STUFF TO HELP YOU FIND THE CORRECT SERIAL PORT
Serial port;
String serialPort;
String[] serialPorts = new String[Serial.list().length];
boolean serialPortFound = false;
Radio[] button = new Radio[Serial.list().length*2];
int numPorts = serialPorts.length;
boolean refreshPorts = false;

// Starting Position for Drawing
  int currentPosX = 350;
  int currentPosY = 300;
  // inData values that actually change the drawing pos is declared in serialEvent

void setup() {
  size(700, 600);  // Stage size
  frameRate(100);
  font = loadFont("Arial-BoldMT-24.vlw");
  textFont(font);
  textAlign(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);

  background(eggshell);
// GO FIND THE ARDUINO
  fill(0);
  text("Select Your Serial Port", 245, 30);
  listAvailablePorts();
}

void draw() {
  if(serialPortFound){
    // ONLY RUN THE VISUALIZER AFTER THE PORT IS CONNECTED
    drawUsingDuoSkin();
    noStroke();
    fill(gold);
    text("Etch a Sketch", 350, 50); 

  } else { // SCAN BUTTONS TO FIND THE SERIAL PORT
  
    autoScanPorts();
  
    if(refreshPorts){
      refreshPorts = false;
      drawBoard();
      listAvailablePorts();
    }
  
    for(int i=0; i<numPorts+1; i++){
      button[i].overRadio(mouseX, mouseY);
      button[i].displayRadio();
    }
  
  }
}
void mouseDragged() {
  drawUsingMouse();
  //println("Dragging mouse");
}

void drawBoard() {
  noStroke();
  fill(eggshell);
  rect(350, 300, 500, 400, 18);
  fill(grey);
  circle(640, 540, 70);
  circle(60, 540, 70);
}

void drawUsingMouse() {
  stroke(0);
  strokeWeight(4);
  line(mouseX, mouseY, pmouseX, pmouseY);
  currentPosX = pmouseX;
  currentPosY = pmouseY;
}

void drawUsingDuoSkin() {
  stroke(0);
  strokeWeight(4);
  line(currentPosX, currentPosY, currentPosX + differenceX, currentPosY + differenceY);
  currentPosX += differenceX;
  currentPosY += differenceY;
  //println("(" + currentPosX + ", " + currentPosY + ")");
}

void clearDrawing() {
  background(etchRed);
  drawBoard();
}

void listAvailablePorts(){
  println((Object)Serial.list());    // print a list of available serial ports to the console
  serialPorts = Serial.list();
  fill(0);
  textFont(font,16);
  textAlign(LEFT);
  // set a counter to list the ports backwards
  int yPos = 0;
  int xPos = 35;
  for(int i=serialPorts.length-1; i>=0; i--){
    button[i] = new Radio(xPos, 95+(yPos*20),12,color(180),color(80),color(255),i,button);
    text(serialPorts[i],xPos+15, 100+(yPos*20));

    yPos++;
    if(yPos > height-30){
      yPos = 0; xPos+=200;
    }
  }
  int p = numPorts;
  fill(233,0,0);
  button[p] = new Radio(35, 95+(yPos*20),12,color(180),color(80),color(255),p,button);
    text("Refresh Serial Ports List",50, 100+(yPos*20));

  textFont(font);
  textAlign(CENTER);
}

void autoScanPorts(){
  if(Serial.list().length != numPorts){
    if(Serial.list().length > numPorts){
      println("New Ports Opened!");
      int diff = Serial.list().length - numPorts;	// was serialPorts.length
      serialPorts = expand(serialPorts,diff);
      numPorts = Serial.list().length;
    }else if(Serial.list().length < numPorts){
      println("Some Ports Closed!");
      numPorts = Serial.list().length;
    }
    refreshPorts = true;
    return;
  }
}
