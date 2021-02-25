import controlP5.*;
ControlP5 cp5;



void setup() {
  size(1000, 750); 
  clear();
  cp5 = new ControlP5(this);
  
  //timer buttons
  cp5.addButton("TensUp").setSize(45,45).setPosition(12, 615);
  cp5.addButton("TensDown").setSize(45,45).setPosition(12, 665);
  cp5.addButton("OnesUp").setSize(45,45).setPosition(59, 615);
  cp5.addButton("OnesDown").setSize(45,45).setPosition(59, 665);
  cp5.addButton("TensSecUp").setSize(45,45).setPosition(111, 615);
  cp5.addButton("TensSecDown").setSize(45,45).setPosition(111,665);
  cp5.addButton("SecUP").setSize(45,45).setPosition(158, 615);
  cp5.addButton("SecDown").setSize(45,45).setPosition(158, 665);
  
  cp5.addButton("1min").setSize(60,50).setPosition(220, 515);
  cp5.addButton("2min").setSize(60,50).setPosition(285, 515);
  cp5.addButton("3min").setSize(60,50).setPosition(350, 515);
  cp5.addButton("4min").setSize(60,50).setPosition(220, 570);
  cp5.addButton("5min").setSize(60,50).setPosition(285, 570);
  cp5.addButton("6min").setSize(60,50).setPosition(350, 570);
  cp5.addButton("7min").setSize(60,50).setPosition(220, 625);
  cp5.addButton("8min").setSize(60,50).setPosition(285, 625);
  cp5.addButton("9min").setSize(60,50).setPosition(350, 625);
  
  cp5.addButton("30sec").setSize(165,55).setPosition(220, 680);
  
  cp5.addButton("PowerUp").setSize(50,50).setPosition(445, 625);
  cp5.addButton("PowerDown").setSize(50,50).setPosition(445, 680);
  
  cp5.addButton("ColorBlindMode").setSize(190,25).setPosition(530, 515);
  cp5.addButton("DeafMode").setSize(190,25).setPosition(530, 545);
  cp5.addButton("SilentMode").setSize(190,25).setPosition(530, 575);
  
  cp5.addButton("ToggleTurn").setSize(190,60).setPosition(530, 660);
  
  cp5.addButton("Cook").setSize(120,70).setPosition(735, 495);
  cp5.addButton("Timer").setSize(120,70).setPosition(865, 495);
  
  cp5.addButton("Start").setSize(120,70).setPosition(735, 580);
  cp5.addButton("StopReset").setSize(120,70).setPosition(865, 580);
  
  cp5.addButton("Open").setSize(250,70).setPosition(735, 665);
}

void draw() {
  //window section
  rect(5, 10, 990, 470);
  rect(5, 10, 990, 470, 50);
  
  //control panel
  rect(5, 485, 990, 260);
  
  //timer box
  rect(10, 490, 200, 120);
  
  //Quick settings
  rect(215, 490, 200, 250);
  
  //Power
  rect(420, 490, 100, 250);
  
  //Preferences
  rect(525, 490, 200, 125);
  
  
  //ToggleTurn
  rect(525, 620, 200,120);
  
  //Mode
  rect(730, 490, 260, 80);
  //Start/stop
  rect(730, 575, 260, 80);
  //open
  rect(730, 660, 260, 80);
}
