Key key;
World world;
Maps maps;
Player player;
NPC npc;
Config config;
void setup(){
  size(480, 480);
  key=new Key();
  world=new World();
  maps=new Maps();
  player=new Player();
  npc=new NPC();
  config=new Config();
}

void draw(){
  world.draw();
}

void keyPressed(){
  key.keyPressed();
}

void keyReleased(){
  key.keyReleased();
}
