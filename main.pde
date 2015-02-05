int mapsizeX=30;
int mapsizeY=30;
PImage map1,map2;
PImage hash;
PImage cher_up,cher_down,cher_right,cher_left;
int speed=1;
int movingX=16;
int movingY=16;
int move_directionX=0;
int move_directionY=0;
int char_direction=2;
Maps maps;
Key key;
Cha cha;
Player player;

void setup(){
  size(480, 480);
  map1 = loadImage("map1.png");
  map2 = loadImage("map2.png");
  hash = loadImage("hash.png");
  cher_up = loadImage("up.png");
  cher_down = loadImage("down.png");
  cher_right = loadImage("right.png");
  cher_left = loadImage("left.png");
  hash.loadPixels();
  maps = new Maps();
  key =new Key();
  cha =new Cha();
  player =new Player();
}

void draw(){
  image(map1, 0, 0);
  cha.cha();
  image(map2, 0, 0);
  key.key();
  player.move();
}

void keyPressed(){
  key.keyPressed();
}

void keyReleased(){
  key.keyReleased();
}
