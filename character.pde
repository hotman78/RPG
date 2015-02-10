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
    if(npc_co.here(13,13))text("a",10,100);
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
    if(key.up)move(Direction.UP);
    if(key.down)move(Direction.DOWN);
    if(key.left)move(Direction.LEFT);
    if(key.right)move(Direction.RIGHT);
  }
  void random_walk(){
    if(move_directionX==Direction.STAY && move_directionY==Direction.STAY){
      int i =floor(random(0,5));
      switch(i){
        case 1:move(Direction.UP);break;
        case 2:move(Direction.DOWN);break;
        case 3:move(Direction.LEFT);break;
        case 4:move(Direction.RIGHT);break;
      }
    }
  }
  boolean col(Direction dir,int y,int x){
    return dir==Direction.STAY && maps.here(x,y);
  }
  void move(Direction a){
    switch(a){
      case UP:
      if(move_directionY==Direction.STAY && maps.here(aboutX(),aboutY()-1)){
        move_directionY=Direction.UP;
        direction=Direction.UP;
      }
      break;
      case DOWN:
      if(move_directionY==Direction.STAY && maps.here(aboutX(),aboutY()+1)){
        move_directionY=Direction.DOWN;
        direction=Direction.DOWN;
      }
      break;
      case LEFT:
      if(move_directionX==Direction.STAY && maps.here(aboutX()-1,aboutY())){
        move_directionX=Direction.LEFT;
        direction=Direction.LEFT;
      }
      break;
      case RIGHT:
      if(move_directionX==Direction.STAY && maps.here(aboutX()+1,aboutY())){
        move_directionX=Direction.RIGHT;
        direction=Direction.RIGHT;
      }
      break;
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
}
