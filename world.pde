//一番大まかな所を扱っているクラスです。SETUPやDRAWを呼んでます。

class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int MAP_CHIP_SIZE = 16;
  boolean canMove;
  int time;
  
  Key key;
  Maps maps;
  DB db;
  Config config;
  TalkCommand tc;
  World(){
    key=new Key();
    maps=new Maps(MAP_CHIP_SIZE);
    db =new DB();
    config=new Config();
    tc =new TalkCommand();
    
    canMove=true;
  }
  
  void draw(){
    time++;
    //if(time==1)maps.addEVENT(MAP_CHIP_SIZE);
    if(canMove==true)maps.update();
    maps.draw();
    tc.draw();
    config.debug();
  }
  void stop(){
    canMove=false;
  }
}