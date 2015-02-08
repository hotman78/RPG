Key key;
World world;
Maps maps;
Player player;
NPC_co npc_co;
Config config;
Collider col;
void setup(){
  size(480, 480);
  key =new Key();
  world = new World();
  maps = new Maps();
  col =new Collider();
  player =new Player();
  npc_co = new NPC_co();
  config =new Config();
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
