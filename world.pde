class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int mapchipsize = 16;
  World(){
    
  }
  void draw(){
  player.move();
  npc_co.move();
  maps.Draw_back();
  player.draw();
  npc_co.draw();
  maps.Draw_front();
  player.talk();
  }
}
