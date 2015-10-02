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
  TalkCommand tc;
  Camera c;
  
  World(){
    key=new Key();
    maps=new Maps(MAP_CHIP_SIZE);
    db =new DB();
    tc =new TalkCommand();
    c =new Camera();
    canMove=true;
  }
  
  void draw(){
    time++;
    if(canMove==true)maps.update();
    c.update();
    maps.draw();
    tc.draw();
    c.draw();
  }
  void stop(){
    canMove=false;
  }
}

class Camera{
  int zoom=2;
  int x;
  int y;
  PGraphics pg;
  MapEvent player;
  Camera(){
    pg = createGraphics(width,height);
  }
  void update(){
    player=world.maps.player;
    if(player.x*zoom<width/2)x=0;
    else if((pg.width-player.x)*zoom<width/2){x=pg.width*zoom-width;}
    else x=player.x*zoom-width/2;
    if(player.y*zoom<height/2)y=0;
    else if((pg.height-player.y)*zoom<height/2){y=pg.height*zoom-height;}
    else y=player.y*zoom-height/2;
  }
  void draw(){
    background(0);
    image(pg,-x,-y,pg.width*zoom,pg.height*zoom);
  }
}