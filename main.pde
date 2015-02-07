Key key;
World world;
Maps maps;
Character cha;
Player player;
NPC npc;
void setup(){
  size(480, 480);
  key =new Key();
  world = new World();
  maps = new Maps();
  cha =new Character();
  player =new Player();
  npc = new NPC();
}

void draw(){
  key.key();
  player.move();
  maps.Draw_back();
  player.draw();
  maps.Draw_front();
  println(player.about_chipY());
}

void keyPressed(){
  key.keyPressed();
}

void keyReleased(){
  key.keyReleased();
}
