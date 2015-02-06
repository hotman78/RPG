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
  color hash(color colorX,color colorY){
     return hash.pixels[(colorY)*hash.width+(colorX)];
  }
}
