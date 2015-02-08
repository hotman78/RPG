class Character{
  PImage down,up,left,right;
  int X;int Y;
  int aboutX;int aboutY;
  float speed;
  WALK move_option;
  int move_directionX,move_directionY;
  int direction;
  int movingX;
  int movingY;
  void talk(){
    if(key.enter){
      if(npc_co.here(12,12))text("a",10,10);
    }
  }
  boolean here(int x,int y){return (x==this.aboutX()-1 && y==this.aboutY()-1);}
  void move_option(WALK par){
    switch(par){
      case key_walk: move_option=WALK.key_walk;break;
      case random: move_option=WALK.random;break;
    }
  }
  void update(){
    col.update((Character)this);    
  }
  void random_walk(){
    if(move_directionX==0 && move_directionY==0){
      int i =floor(random(0,5));
      switch(i){
        case 1:move_up();break;
        case 2:move_down();break;
        case 3:move_left();break;
        case 4:move_right();break;
      }
    }
  }
  
  void key_move(){
    if(key.up)move_up();
    if(key.down)move_down();
    if(key.left)move_left();
    if(key.right)move_right();
  }
  void move_up(){
    if(move_directionY==0 && maps.here(aboutX(),aboutY()-1)){
      move_directionY=1;
      direction=1;
    }
  }
  void move_down(){
    if(move_directionY==0 && maps.here(aboutX(),aboutY()+1)){
      move_directionY=2;
      direction=2;
    }
  }
  void move_left(){
    if(move_directionX==0 && maps.here(aboutX()-1,aboutY())){
      move_directionX=1;
      direction=3;
    }
  }
  void move_right(){
    if(move_directionX==0 && maps.here(aboutX()+1,aboutY())){
      move_directionX=2;
      direction=4;
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
  int aboutX(){
    return floor(X/world.mapchipsize)+1;
  }
  int aboutY(){
    return floor(Y/world.mapchipsize)+1;
  }
  void set(){
    this.move_directionX=0;
    this.move_directionY=0;
    this.direction=2;
    this.movingX=world.mapchipsize;
    this.movingY=world.mapchipsize;
  }
}
