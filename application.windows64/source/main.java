import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

int mapsizeX=30;
int mapsizeY=30;
int playerX=15;
int playerY=15;
PImage map;
PImage hash;
int speed=1;
int movingX=16;
int movingY=16;
int move_directionX=0;
int move_directionY=0;
public void setup(){
  size(480, 480);
  map = loadImage("map.png");
  hash = loadImage("hash.png");
}

public void draw(){
  image(map, 0, 0);
  rect(playerX,playerY,16,16);
  key();
  move();
}

public void move(){
  if(movingY!=0){
    if(move_directionY!=0)movingY--;
    if(move_directionY==1)playerY-=speed;
    if(move_directionY==2)playerY+=speed;
  }
  else {
    movingY=16;
    move_directionY=0;
  }
  if(movingX!=0){
    if(move_directionX!=0)movingX--;
    if(move_directionX==1)playerX-=speed;
    if(move_directionX==2)playerX+=speed;
  }
  else {
    println("test");
    movingX=16;
    move_directionX=0;
  }
}
  int key_up = 0;
  int key_down = 0;
  int key_right = 0;
  int key_left = 0;
  int key_shift = 0;
  int key_enter = 0;
public void key(){
  if(move_directionY==0){
    if(key_up==1)   move_directionY=1;
    if(key_down==1) move_directionY=2;
  }
  if(move_directionX==0){
    if(key_left==1) move_directionX=1;
    if(key_right==1)move_directionX=2;
  }
}
public void keyPressed(){
  if(keyCode==UP) key_up = 1;
  else if(keyCode==DOWN) key_down = 1;
  else if(keyCode==RIGHT) key_right = 1;
  else if(keyCode==LEFT) key_left = 1;
  else if(keyCode==SHIFT) key_shift = 1;
  else if(keyCode==ENTER) key_enter = 1;
}
  
public void keyReleased(){
  if(keyCode==UP) key_up = 0;
  else if(keyCode==DOWN)  key_down = 0;
  else if(keyCode==RIGHT) key_right = 0;
  else if(keyCode==LEFT)  key_left = 0;
  else if(keyCode==SHIFT) key_shift = 0;
  else if(keyCode==ENTER) key_enter = 0;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
