//一番大まかな所を扱っているクラスです。SETUPやDRAWを呼んでます。

class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int MAP_CHIP_SIZE = 16;
  boolean canMove;
  int time;
  
  Input input;
  Maps maps;
  DB db;
  Camera c;
  Image image;
  
  World(){
    input=new Input();
    maps=new Maps(MAP_CHIP_SIZE);
    db =new DB();
    c =new Camera();
    image= new Image();
    canMove=true;
  }
  
  void draw(){
    time++;
    if(canMove==true)maps.update();
    c.update();
    maps.draw();
    c.draw();
    image.draw();
  }
  void stop(){
    canMove=false;
  }
}

class Camera{
  float zoom=1.5;
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
    else if((pg.width-player.x)*zoom<width/2){x=round(pg.width*zoom-width);}
    else x=round(player.x*zoom-width/2);
    if(player.y*zoom<height/2)y=0;
    else if((pg.height-player.y)*zoom<height/2){y=round(pg.height*zoom-height);}
    else y=round(player.y*zoom-height/2);
  }
  void draw(){
    background(0);
    image(pg,-x,-y,pg.width*zoom,pg.height*zoom);
  }
}