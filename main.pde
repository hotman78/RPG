Key key;
World world;
Maps maps;
Player player;
NPC_co npc_co;
Config config;
Move mv;
void setup(){
  size(480, 480);
  key=new Key();
  world=new World();
  maps=new Maps();
  mv=new Move();
  player=new Player();
  npc_co=new NPC_co();
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
