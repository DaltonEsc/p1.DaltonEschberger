import controlP5.*;
import processing.sound.*;

ControlP5 cp5;
ControlFont ButtonFont;
SoundFile ButtonClick;
SoundFile Running;
SoundFile Alarm;

boolean MicrowaveState = false; // false = off, true = on
boolean MicrowaveMode = false; // false = cook, true = timer
int TimeInSeconds = 0;
int Minutes = 0;
int Seconds = 0;
int Tens = 0;
int Ones = 0;
int TensSec = 0;
int Sec = 0;
int Power = 1000;
int OpenClose = 255255255;

int SavedTime ;
int TotalTime=1000; //1sec
int ColorPosition=0;
int[] Colors ={000000000, 255000000, 000255000, 000000255 ,204121167, 86180233, 233255000};

boolean Silent = false;
boolean Deaf = false;
boolean Turn = true;
boolean Complete = false;

void setup() {
  size(1000, 750); 
  clear();
  cp5 = new ControlP5(this);
  SavedTime = millis();
  ButtonFont = new ControlFont(createFont("Arial",15,true));
  ButtonClick = new SoundFile(this, "button.mp3");
  Running = new SoundFile(this,"Running.mp3");
  Alarm = new SoundFile(this, "alarm.wav");
  //timer buttons
  cp5.addButton("TensUp").setLabel("+1").setSize(45,45).setPosition(12, 615).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("TensDown").setLabel("-1").setSize(45,45).setPosition(12, 665).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("OnesUp").setLabel("+1").setSize(45,45).setPosition(59, 615).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("OnesDown").setLabel("-1").setSize(45,45).setPosition(59, 665).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("TensSecUp").setLabel("+1").setSize(45,45).setPosition(111, 615).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("TensSecDown").setLabel("-1").setSize(45,45).setPosition(111,665).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("SecUP").setLabel("+1").setSize(45,45).setPosition(158, 615).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("SecDown").setLabel("-1").setSize(45,45).setPosition(158, 665).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("OneMin").setLabel("1 Min").setSize(60,50).setPosition(220, 515).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("TwoMin").setLabel("2 Min").setSize(60,50).setPosition(285, 515).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("ThreeMin").setLabel("3 Min").setSize(60,50).setPosition(350, 515).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("FourMin").setLabel("4 Min").setSize(60,50).setPosition(220, 570).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("FiveMin").setLabel("5 Min").setSize(60,50).setPosition(285, 570).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("SixMin").setLabel("6 Min").setSize(60,50).setPosition(350, 570).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("SevenMin").setLabel("7 Min").setSize(60,50).setPosition(220, 625).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("EightMin").setLabel("8 Min").setSize(60,50).setPosition(285, 625).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("NineMin").setLabel("9 Min").setSize(60,50).setPosition(350, 625).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("AddThirtySec").setLabel("Add 30 Sec").setSize(190,55).setPosition(220, 680).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("PowerUp").setLabel("+ Power").setSize(80,50).setPosition(430, 625).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("PowerDown").setLabel("- Power").setSize(80,50).setPosition(430, 680).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("ColorBlindMode").setLabel("Color Blind Mode").setSize(190,25).setPosition(530, 515).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("DeafMode").setLabel("Deaf Mode").setSize(190,25).setPosition(530, 545).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("SilentMode").setLabel("Silent").setSize(190,25).setPosition(530, 575).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("ToggleTurn").setLabel("Toggle Turn").setSize(190,60).setPosition(530, 660).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("Cook").setSize(120,70).setPosition(735, 495).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("Timer").setSize(120,70).setPosition(865, 495).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("Start").setSize(120,70).setPosition(735, 580).setColorBackground(#898686).setFont(ButtonFont);
  cp5.addButton("StopReset").setLabel("Stop/Reset").setSize(120,70).setPosition(865, 580).setColorBackground(#898686).setFont(ButtonFont);
  
  cp5.addButton("Open").setSize(250,70).setPosition(735, 665).setColorBackground(#898686).setFont(ButtonFont);
}

void draw() {
  clear();
  ComputeTimerDigits();
  
  if(MicrowaveState){
    int passedTime=millis()-SavedTime;
    if(Seconds==0&&Minutes>0){
      Minutes-=1;
      Seconds+=60;
    }
    if(Seconds==0 && Minutes ==0){
      Alarm();
      MicrowaveState = false;
    }
    if(passedTime>TotalTime && Seconds!=0){
      Seconds-=1;
      SavedTime =millis();
    }
  }
  fill(255);
  //window section
  rect(5, 10, 990, 470);
  rect(5, 10, 990, 470, 50);
  
  //control panel
  rect(5, 485, 990, 260);
  
  //timer box
  rect(10, 490, 200, 120);
  
  //Quick settings
  rect(215, 490, 200, 250);
  fill(Colors[ColorPosition]/1000000,(Colors[ColorPosition]/1000)%1000, (Colors[ColorPosition])%1000);
  textSize(20);
  text("Quick Settings",240,510);
  fill(255);
  
  //Power
  rect(420, 490, 100, 250);
  fill(Colors[ColorPosition]/1000000,(Colors[ColorPosition]/1000)%1000, (Colors[ColorPosition])%1000);
  textSize(20);
  text("Power",440,510);
  fill(255);
  
  //Preferences
  rect(525, 490, 200, 125);
  fill(Colors[ColorPosition]/1000000,(Colors[ColorPosition]/1000)%1000, (Colors[ColorPosition])%1000);
  textSize(20);
  text("Preferences",570,510);
  fill(255);
  
  //ToggleTurn
  rect(525, 620, 200,120);
  fill(Colors[ColorPosition]/1000000,(Colors[ColorPosition]/1000)%1000, (Colors[ColorPosition])%1000);
  textSize(20);
  text("Turn Table: "+Turn,540,645);
  fill(255);
  
  
  //Mode
  rect(730, 490, 260, 80);
  //Start/stop
  rect(730, 575, 260, 80);
  //open
  rect(730, 660, 260, 80);
  
  //Timer Digits
  fill(Colors[ColorPosition]/1000000,(Colors[ColorPosition]/1000)%1000, (Colors[ColorPosition])%1000);
  textSize(80);
  text(Tens, 8, 575);
  text(Ones, 58, 575);
  text(TensSec, 108, 575);
  text(Sec, 158, 575);
  circle(108, 555, 5);
  circle(108, 535, 5);
  
  fill(Colors[ColorPosition]/1000000,(Colors[ColorPosition]/1000)%1000, (Colors[ColorPosition])%1000);
  textSize(25);
  text(Power+"w",430, 570);
  

  fill(OpenClose/1000000,(OpenClose/1000)%1000, (OpenClose)%1000);
  rect(5, 10, 990, 470, 50);
  if(Silent){
    fill(0xff888888);
    rect(500,20,150,20);
    fill(0);
    textSize(15);
    text("Silent Mode Enabled",502, 35);
  }
  else if(Deaf) {
    fill(0xff00ffff);
    rect(500,20,150,20);
    fill(0);
    textSize(15);
    text("Deaf Mode Enabled",502, 35);
  }
  if(Complete){
    fill(255,00,00);
    rect(5, 10, 990, 470, 50);
  }
}
void Alarm(){
  OpenClose=255255255;
  Running.stop();
  if(Silent || Deaf){
    Complete=true;
  }
  else{
    
    Alarm.play();
  }
}
void ComputeTimerDigits(){
  if(Seconds>=60){
    Minutes+=int(Seconds/60);
    Seconds-=(int(Seconds/60)*60);
  }
  Tens = Minutes/10;
  Ones = Minutes%10;
  TensSec = Seconds/10;
  Sec=Seconds%10;
}

void TensUp(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Minutes+10<=90){
    Minutes+=10;
  }
}

void TensDown(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Minutes-10>=0){
    Minutes-=10;
  }
}

void OnesUp(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Minutes+1<=99.99){
    Minutes+=1;
  }
}

void OnesDown(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Minutes-1>=0){
    Minutes-=1;
  }
}

void TensSecUp(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Seconds+10 <=99){
    Seconds+=10;
  }
}

void TensSecDown(){
  if(!Silent){
    ButtonClick.play();
  }
   if(Seconds-10 >=0){
    Seconds-=10;
  }
}

void SecUP(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Seconds+1 <=99){
    Seconds+=1;
  }
}

void SecDown(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Seconds-1 >=0){
    Seconds-=1;
  }
}

void OneMin(){
  if(!Silent){
    ButtonClick.play();
  }
  Seconds=0;
  Minutes =1;
}

void TwoMin(){
  if(!Silent){
    ButtonClick.play();
  }
   Seconds=0;
  Minutes =2;
 }

void ThreeMin(){
  if(!Silent){
    ButtonClick.play();
  }
   Seconds=0;
  Minutes =3;
}

void FourMin(){
  if(!Silent){
    ButtonClick.play();
  }
   Seconds=0;
  Minutes =4;
}

void FiveMin(){
  if(!Silent){
    ButtonClick.play();
  }
   Seconds=0;
  Minutes =5;
}

void SixMin(){
  if(!Silent){
    ButtonClick.play();
  }
   Seconds=0;
  Minutes =6;
 }

void SevenMin(){
  if(!Silent){
    ButtonClick.play();
  }
    Seconds =0;
  Minutes =7;
}

void EightMin(){
  if(!Silent){
    ButtonClick.play();
  }
  Minutes =8;
}

void NineMin(){
  if(!Silent){
    ButtonClick.play();
  }
  Minutes =9;
}

void AddThirtySec(){
  if(!Silent){
    ButtonClick.play();
  }
    Seconds+=30;
}

void PowerUp(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Power+100<=1000){
    Power+=100;
  }
}

void PowerDown(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Power-100>=100){
    Power-=100;
  }
}

void ColorBlindMode(){
  if(!Silent){
    ButtonClick.play();
  }
  if(ColorPosition+1<Colors.length){
    ColorPosition+=1;
  }
  else{
    ColorPosition=0;
  }
  
}

void DeafMode(){
   if(!Silent){
    ButtonClick.play();
  }
  if(Deaf){
    Deaf = false;
  }
  else{
    Deaf = true;
  }
}

void SilentMode(){
  if(!Silent){
    ButtonClick.play();
  }
  if(Silent){
    Silent = false;
  }
  else{
    Silent = true;
  }
}

void ToggleTurn(){
 if(!Silent){
    ButtonClick.play();
  }
  if(Turn){
    Turn=false;
  }
  else{
    Turn =true;
}

}

void Cook(){
  if(!Silent){
    ButtonClick.play();
  }
  MicrowaveMode = false;
}

void Timer(){
  if(!Silent){
    ButtonClick.play();
  }
  MicrowaveMode =true;
}

void Start(){
  if(!MicrowaveMode){
    Running.play();
  }
  if(!Silent){
    ButtonClick.play();
  }
  MicrowaveState =true;
  if(MicrowaveMode){
      OpenClose=255255255;
  }
  else{
      OpenClose=255239194;
  }

}

void StopReset(){
  if(!Silent){
    ButtonClick.play();
  }
  Running.stop();
  MicrowaveState=false;
  MicrowaveMode = false;
  OpenClose=255255255;
  Minutes = 0;
  Seconds = 0;
  Complete=false;
}

void Open(){
  if(!Silent){
    ButtonClick.play();
  }
    Running.stop();
  MicrowaveState=false;
  OpenClose=255239194;
}
