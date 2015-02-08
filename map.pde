class Maps{
  PImage map1,map2;
  PImage hash;
  Maps(){
    map1 = loadImage("map1.png");
    map2 = loadImage("map2.png");
    hash = loadImage("hash.png");
    hash.loadPixels();
  }
  void Draw_back(){
    image(map1, 0, 0);
  }
  void Draw_front(){
    image(map2, 0, 0);
  }
  color hash(int X,int Y){
     if(X>0 && X<world.mapsizeX+1 && Y>0 && Y<world.mapsizeY+1)
     return hash.pixels[(Y-1)*hash.width+(X-1)];
     else return color(0);
  }
  boolean here(int X,int Y){
    return (maps.hash(X,Y)!=color(0));
  }
}
