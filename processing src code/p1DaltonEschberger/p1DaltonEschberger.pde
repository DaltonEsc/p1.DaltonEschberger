import controlP5.*;
ControlP5 cp5;



void setup() {
  size(1000, 750); 
  clear();
  
  
  cp5 = new ControlP5(this);
  cp5.addButton("Left").setSize(100,100).setPosition(20, 20);
  cp5.addButton("Right").setSize(100,100).setPosition(125, 20);
}

void draw() {
  rect(10, 10, 980, 470);
  rect(10, 10, 980, 470, 50);
  rect(10, 500, 980, 240);
}
