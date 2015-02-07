Key key;
World world;
Maps maps;
Character cha;
Player player;
NPC npc;
Config config;
void setup(){
  size(480, 480);
  key =new Key();
  world = new World();
  maps = new Maps();
  cha =new Character();
  player =new Player();
  npc = new NPC();
  config =new Config();
}

void draw(){
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
