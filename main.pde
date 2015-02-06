Maps maps;
Key key;
Character cha;
Player player;

void setup(){
  size(480, 480);
  maps = new Maps();
  key =new Key();
  cha =new Character();
  player =new Player();
}

void draw(){
  key.key();
  player.move();
  maps.Draw_back();
  player.draw();
  maps.Draw_front();
}

void keyPressed(){
  key.keyPressed();
}

void keyReleased(){
  key.keyReleased();
}
