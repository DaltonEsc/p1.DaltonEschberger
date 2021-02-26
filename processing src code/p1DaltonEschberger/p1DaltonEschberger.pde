import controlP5.*;
import processing.sound.*;
ControlP5 cp5;
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
boolean Silent = false;
boolean Turn = true;
int SilentColor = 16711680;

void setup() {
  size(1000, 750); 
  clear();
  cp5 = new ControlP5(this);
  SavedTime = millis();
  ButtonClick = new SoundFile(this, "button.mp3");
  Running = new SoundFile(this,"Running.mp3");
  Alarm = new SoundFile(this, "alarm.wav");
  //timer buttons
  cp5.addButton("TensUp").setSize(45,45).setPosition(12, 615);
  cp5.addButton("TensDown").setSize(45,45).setPosition(12, 665);
  cp5.addButton("OnesUp").setSize(45,45).setPosition(59, 615);
  cp5.addButton("OnesDown").setSize(45,45).setPosition(59, 665);
  cp5.addButton("TensSecUp").setSize(45,45).setPosition(111, 615);
  cp5.addButton("TensSecDown").setSize(45,45).setPosition(111,665);
  cp5.addButton("SecUP").setSize(45,45).setPosition(158, 615);
  cp5.addButton("SecDown").setSize(45,45).setPosition(158, 665);
  
  cp5.addButton("OneMin").setSize(60,50).setPosition(220, 515);
  cp5.addButton("TwoMin").setSize(60,50).setPosition(285, 515);
  cp5.addButton("ThreeMin").setSize(60,50).setPosition(350, 515);
  cp5.addButton("FourMin").setSize(60,50).setPosition(220, 570);
  cp5.addButton("FiveMin").setSize(60,50).setPosition(285, 570);
  cp5.addButton("SixMin").setSize(60,50).setPosition(350, 570);
  cp5.addButton("SevenMin").setSize(60,50).setPosition(220, 625);
  cp5.addButton("EightMin").setSize(60,50).setPosition(285, 625);
  cp5.addButton("NineMin").setSize(60,50).setPosition(350, 625);
  
  cp5.addButton("AddThirtySec").setSize(165,55).setPosition(220, 680);
  
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
  fill(0);
  textSize(20);
  text("Quick Settings",240,510);
  fill(255);
  
  //Power
  rect(420, 490, 100, 250);
  fill(0);
  textSize(20);
  text("Power",440,510);
  fill(255);
  
  //Preferences
  rect(525, 490, 200, 125);
  fill(0);
  textSize(20);
  text("Preferences",570,510);
  fill(255);
  
  //ToggleTurn
  rect(525, 620, 200,120);
  fill(0);
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
  fill(0);
  textSize(80);
  text(Tens, 8, 575);
  text(Ones, 58, 575);
  text(TensSec, 108, 575);
  text(Sec, 158, 575);
  circle(108, 555, 5);
  circle(108, 535, 5);
  
  fill(0);
  textSize(25);
  text(Power+"w",430, 570);
  

  fill(OpenClose/1000000,(OpenClose/1000)%1000, (OpenClose)%1000);
  rect(5, 10, 990, 470, 50);
}
void Alarm(){
  OpenClose=255255255;
  Running.stop();
  if(Silent){
    for(int i =0; i<5;i++){
      OpenClose=255000000;
      int wait = 200000;
      while(wait>0){
        
        wait--;
      }
      OpenClose=255255255;
    }
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
  ButtonClick.play();
  if(Minutes+10<=90){
    Minutes+=10;
  }
}

void TensDown(){
  ButtonClick.play();
  if(Minutes-10>=0){
    Minutes-=10;
  }
}

void OnesUp(){
  ButtonClick.play();
  if(Minutes+1<=99.99){
    Minutes+=1;
  }
}

void OnesDown(){
  ButtonClick.play();
  if(Minutes-1>=0){
    Minutes-=1;
  }
}

void TensSecUp(){
  ButtonClick.play();
  if(Seconds+10 <=99){
    Seconds+=10;
  }
}

void TensSecDown(){
  ButtonClick.play();
   if(Seconds-10 >=0){
    Seconds-=10;
  }
}

void SecUP(){
  ButtonClick.play();
  if(Seconds+1 <=99){
    Seconds+=1;
  }
}

void SecDown(){
  ButtonClick.play();
  if(Seconds-1 >=0){
    Seconds-=1;
  }
}

void OneMin(){
  ButtonClick.play();
  Seconds=0;
  Minutes =1;
}

void TwoMin(){
  ButtonClick.play();
   Seconds=0;
  Minutes =2;
 }

void ThreeMin(){
  ButtonClick.play();
   Seconds=0;
  Minutes =3;
}

void FourMin(){
  ButtonClick.play();
   Seconds=0;
  Minutes =4;
}

void FiveMin(){
  ButtonClick.play();
   Seconds=0;
  Minutes =5;
}

void SixMin(){
  ButtonClick.play();
   Seconds=0;
  Minutes =6;
 }

void SevenMin(){
  ButtonClick.play();
    Seconds =0;
  Minutes =7;
}

void EightMin(){
  ButtonClick.play();
  Minutes =8;
}

void NineMin(){
  ButtonClick.play();
  Minutes =9;
}

void AddThirtySec(){
  ButtonClick.play();
    Seconds+=30;
}

void PowerUp(){
  ButtonClick.play();
  if(Power+100<=1000){
    Power+=100;
  }
}

void PowerDown(){
  ButtonClick.play();
  if(Power-100>=100){
    Power-=100;
  }
}

void ColorBlindMode(){
  ButtonClick.play();
}

void DeafMode(){
  ButtonClick.play();
  Silent = true;
}

void SilentMode(){
  ButtonClick.play();
  SilentColor=65280;
  Silent = true;
}

void ToggleTurn(){
  ButtonClick.play();
if(Turn){
  Turn=false;
}
else{
Turn =true;
}

}

void Cook(){
  ButtonClick.play();
  MicrowaveMode = false;
}

void Timer(){
  ButtonClick.play();
  MicrowaveMode =true;
}

void Start(){
  if(!MicrowaveMode){
    Running.play();
  }
  ButtonClick.play();
  MicrowaveState =true;
  if(MicrowaveMode){
      OpenClose=255255255;
  }
  else{
      OpenClose=255239194;
  }

}

void StopReset(){
  ButtonClick.play();
  Running.stop();
  MicrowaveState=false;
  MicrowaveMode = false;
  OpenClose=255255255;
  Minutes = 0;
  Seconds = 0;
}

void Open(){
  ButtonClick.play();
    Running.stop();
  MicrowaveState=false;
  OpenClose=255239194;
}
