class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int mapchipsize = 16;
  World(){
    
  }
  void draw(){
  player.update();
  npc_co.update();
  maps.Draw_back();
  player.draw();
  npc_co.draw();
  maps.Draw_front();
  player.talk();
  }
}
