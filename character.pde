class Character{
  PImage down,up,left,right;
  int X;int Y;
  int about_chipX;int about_chipY;
  int move_directionX;
  int move_directionY;
  int direction;
  int movingX;
  int movingY;
  float speed;
  String move_option;
  Character(){
    move_directionX=0;
    move_directionY=0;
    direction=2;
    movingX=world.mapchipsize;
    movingY=world.mapchipsize;
  }
  void move_option(String par){
    if(par=="key")move_option="key";
  }
  void move(){
    if(move_option=="key")key_move();
      if(movingX!=0){
        if(move_directionX!=0 && movingX<speed)movingX=0;
        else if(move_directionX!=0)movingX-=speed;
        if(move_directionX==1)X-=speed;
        if(move_directionX==2)X+=speed;
      }
      if(movingX==0){
        movingX=world.mapchipsize;
        move_directionX=0;
      }
    if(movingY!=0){
      if(move_directionY!=0 && movingY<speed)movingY=0;
      else if(move_directionY!=0)movingY-=speed;
      if(move_directionY==1)Y-=speed;
      if(move_directionY==2)Y+=speed;
    }
    if(movingY==0){
      movingY=world.mapchipsize;
      move_directionY=0;
    }
  }
  void key_move(){
    if(key.key_up==1)move_up();
    if(key.key_down==1)move_down();
    if(key.key_left==1)move_left();
    if(key.key_right==1)move_right();
  }
  void move_up(){
    if(move_directionY==0 && maps.hash(about_chipX(),about_chipY()-1)!=color(0)){
      move_directionY=1;
      direction=1;
    }
  }
  void move_down(){
    if(move_directionY==0 && maps.hash(about_chipX(),about_chipY()+1)!=color(0)){
      move_directionY=2;
      direction=2;
    }
  }
  void move_left(){
    if(move_directionX==0 && maps.hash(about_chipX()-1,about_chipY())!=color(0)){
      move_directionX=1;
      direction=3;
    }
  }
  void move_right(){
    if(move_directionX==0 && maps.hash(about_chipX()+1,about_chipY())!=color(0)){
      move_directionX=2;
      direction=4;
    }
  }
  void speed(float speed_replace){
    speed=speed_replace;
  }
  void set_position(int set_X,int set_Y){
    println("a");
    X=set_X*world.mapchipsize;
    Y=set_Y*world.mapchipsize;
  }
  void load_image(String file_name){
    down =loadImage(file_name+"_down.png");
    up =loadImage(file_name+"_up.png");
    left =loadImage(file_name+"_left.png");
    right =loadImage(file_name+"_right.png"); 
  }
  void draw(){
    if(direction==1)image(up,X,Y);
    if(direction==2)image(down,X,Y);
    if(direction==3)image(left,X,Y);
    if(direction==4)image(right,X,Y);
  }
  float chipX(){
    return X/world.mapchipsize+1;
  }
  float chipY(){
    return Y/world.mapchipsize+1;
  }
  int about_chipX(){
    return floor(X/world.mapchipsize)+1;
  }
  int about_chipY(){
    return floor(Y/world.mapchipsize)+1;
  }
}
