import processing.serial.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import cc.arduino.*;
import org.firmata.*;

ControlDevice cont;
ControlIO control;

Arduino arduino;

float trigger;
float bumperLeft;
float bumperRight;
float leftStickY;
float rightStickX;
float keyA;

float claw;
float clawRotation;
float armY;
float armYL;
float armYR;
float armX;


void setup() {
 size(360, 200);
 
 control = ControlIO.getInstance(this);
 cont = control.getMatchedDevice("armcont");
 
   if (cont == null) {
     println("There was no valid controller connected, exiting program");
     System.exit(-1);
     
   }
  
  //println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(5, Arduino.SERVO);
  arduino.pinMode(6, Arduino.SERVO);
  arduino.pinMode(9, Arduino.SERVO);
  arduino.pinMode(11, Arduino.SERVO);
  
  claw = 90;
  clawRotation = 90;
  armYL = 90;
  armYR = 90;
  armX = 90;
  
}

public void getUserInput(){
// // assign out floar value
// // access the controller
// trigger = map(cont.getSlider("trigger").getValue(), 1, -1, 180, 0);
// //println(trigger);
// bumperLeft = map(cont.getButton("bumperLeft").getValue(), 1, -1, 180, 0);
// //println(bumperLeft);
// bumperRight = map(cont.getButton("bumperRight").getValue(), 1, -1, 180, 0);
// //println(bumperRight);
// leftStickY = map(cont.getSlider("leftStickY").getValue(), 1, -1, 180, 0);
// //println(leftStickY);
// rightStickX = map(cont.getSlider("rightStickX").getValue(), 1, -1, 180, 0);
// //println(rightStickX);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 trigger = cont.getSlider("trigger").getValue();
 
   if(trigger >= 0.09) {
     claw -= 5;
   }
   else if(trigger <= -0.09) {
     claw += 5;
   }
   claw = constrain(claw, 0, 180);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 bumperLeft = cont.getButton("bumperLeft").getValue();
 bumperRight = cont.getButton("bumperRight").getValue();
 
 //println(bumperLeft);
 //println(bumperRight);
 
   if(bumperRight >= 1) {
     clawRotation += 3;
   }
   else if(bumperLeft >= 1) {
     clawRotation -= 3;
   }
   clawRotation = constrain(clawRotation, 0, 180);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
 leftStickY = cont.getSlider("leftStickY").getValue();
 
   if(leftStickY >= 0.09) {
     armYL += 1;
     armYR -= 1;
    }
   else if(leftStickY <= -0.09) {
    armYL -= 1;
    armYR += 1;
   }
    armY = constrain(armY, 0, 180);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       
 rightStickX = cont.getSlider("rightStickX").getValue();
 
   if(rightStickX >= 0.09) {
     armX -= 1;
    }
   else if(rightStickX <= -0.09) {
    armX += 1;
   }
    armX = constrain(armX, 0, 180);
    
   //println(armX);
  

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
//  keyA = cont.getButton("keyA").getValue();
  
//  if(keyA >= 1) {
//  arduino.servoWrite(11, 0);
//  }
//  else{
//  }
//    println(keyA);
  }

void draw(){
 
  getUserInput();
  background(clawRotation,100,100);
  
  arduino.servoWrite(3, (int)clawRotation);    //or bumperRight
  //arduino.servoWrite(5, (int)placeHolder);
  arduino.servoWrite(6, (int)armYL);
  arduino.servoWrite(5, (int)armYR);
  arduino.servoWrite(9, (int)armX);
  arduino.servoWrite(11, (int)claw);
  
}
