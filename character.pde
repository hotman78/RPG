class Character{
  PImage down,up,left,right;
  int X;int Y;
  int aboutX;int aboutY;
  float speed;
  WALK move_option;
  Direction move_directionX,move_directionY;
  Direction direction;
  int movingX;
  int movingY;
  void talk(){
    if(key.enter){
      if(npc_co.here(aboutX(),aboutY()))text("a",10,10);
    }
  }
  boolean here(int x,int y){return (x==this.aboutX()-1 && y==this.aboutY()-1);}
  void move_option(WALK par){
    switch(par){
      case key_walk: move_option=WALK.key_walk;break;
      case random: move_option=WALK.random;break;
      case stay:move_option=WALK.stay;break;
    }
  }
  
  void key_move(){
    if(key.up)move_up();
    if(key.down)move_down();
    if(key.left)move_left();
    if(key.right)move_right();
  }
  boolean col(Direction dir,int y,int x){
    return dir==Direction.STAY && maps.here(x,y);
  }
  void move_up(){
    if(move_directionY==Direction.STAY && maps.here(aboutX(),aboutY()-1)){
      move_directionY=Direction.UP;
      direction=Direction.UP;
    }
  }
  void move_down(){
    if(move_directionY==Direction.STAY && maps.here(aboutX(),aboutY()+1)){
      move_directionY=Direction.DOWN;
      direction=Direction.DOWN;
    }
  }
  void move_left(){
    if(move_directionX==Direction.STAY && maps.here(aboutX()-1,aboutY())){
      move_directionX=Direction.LEFT;
      direction=Direction.LEFT;
    }
  }
  void move_right(){
    if(move_directionX==Direction.STAY && maps.here(aboutX()+1,aboutY())){
      move_directionX=Direction.RIGHT;
      direction=Direction.RIGHT;
    }
  }
  void speed(float speed_replace){
    speed=speed_replace;
  }
  void set_position(int set_X,int set_Y){
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
    if(direction==Direction.UP)image(up,X,Y);
    if(direction==Direction.DOWN)image(down,X,Y);
    if(direction==Direction.LEFT)image(left,X,Y);
    if(direction==Direction.RIGHT)image(right,X,Y);
  }
  float chipX(){
    return X/world.mapchipsize+1;
  }
  float chipY(){
    return Y/world.mapchipsize+1;
  }
  int aboutX(){
    return floor(X/world.mapchipsize)+1;
  }
  int aboutY(){
    return floor(Y/world.mapchipsize)+1;
  }
  void set(){
    this.move_directionX=Direction.STAY;
    this.move_directionY=Direction.STAY;
    this.direction=Direction.UP;
    this.movingX=world.mapchipsize;
    this.movingY=world.mapchipsize;
  }
  void update(){
    switch(move_option){
      case key_walk:key_move();break;
      case random:random_walk();break;
      case stay:break;
      default:break;
    }
    if(movingX==0){
      movingX=world.mapchipsize;
      move_directionX=Direction.STAY;
    }else{
      if(move_directionX!=Direction.STAY && movingX<speed)movingX=0;
      else if(move_directionX!=Direction.STAY)movingX-=speed;
      if(move_directionX==Direction.LEFT)X-=speed;
      if(move_directionX==Direction.RIGHT)X+=speed;
    }
    if(movingY==0){
      movingY=world.mapchipsize;
      move_directionY=Direction.STAY;
    }else{
      if(move_directionY!=Direction.STAY && movingY<speed)movingY=0;
      else if(move_directionY!=Direction.STAY)movingY-=speed;
      if(move_directionY==Direction.UP)Y-=speed;
      if(move_directionY==Direction.DOWN)Y+=speed;
    }    
  }
  void random_walk(){
    if(move_directionX==Direction.STAY && move_directionY==Direction.STAY){
      int i =floor(random(0,5));
      switch(i){
        case 1:move_up();break;
        case 2:move_down();break;
        case 3:move_left();break;
        case 4:move_right();break;
      }
    }
  }
}
