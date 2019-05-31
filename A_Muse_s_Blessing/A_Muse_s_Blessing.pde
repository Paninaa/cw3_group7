import processing.video.*;
import processing.io.*;

PImage img1;
Movie video1, video2;

boolean Switch = false;

void setup(){
  background(255);
  size(780,964);
  
  video1 = new Movie(this, "vid1.mp4");
  video2 = new Movie(this, "vid2.mp4");
  
  video2.play(); 
  video2.loop();
}

void draw(){
  int val = sensorRead(4);
  println(val);
  
  image(video2,0,0);
  
  if (val > 20){
    Switch = true;
  }
  if(Switch == true){
    image(video1,0,0);
    video1.play();
    if(video1.time()>=10){
      image(video2,0,0);
      video1.stop();
      video1.jump(0);
      Switch = false;
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}

int sensorRead(int pin) {
  // discharge the capacitor
  GPIO.pinMode(pin, GPIO.OUTPUT);
  GPIO.digitalWrite(pin, GPIO.LOW);
  delay(100);
  // now the capacitor should be empty

  // measure the time takes to fill it
  // up to ~ 1.4V again
  GPIO.pinMode(pin, GPIO.INPUT);
  int start = millis();
  while (GPIO.digitalRead(pin) == GPIO.LOW) {
    // wait
  }
   // return the time elapsed
  // this will vary based on the value of the
  // resistive sensor (lower resistance will
  // make the capacitor charge faster)
  return millis() - start;
}
