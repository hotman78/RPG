//一番大まかな所を扱っているクラスです。SETUPやDRAWを呼んでます。

class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int MAP_CHIP_SIZE = 16;
  boolean canMove;
  int time;
  World(){
    canMove=true;
  }
  void draw(){
    time++;
    if(time==1)maps.addEVENT();
    maps.update();
    maps.draw();
    config.debug();
  }
  void stop(){
    canMove=false;
  }
}
