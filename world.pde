class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int mapchipsize = 16;
  boolean can_move;
  World(){
    can_move=true;
  }
  void draw(){
    npc.yellow();
    player.update();
    npc.update();
    maps.Draw_back();
    player.draw();
    npc.draw();
    maps.Draw_front();
    config.debug();
    player.talk();
  }
  void stop(){
    can_move=false;
  }
}
