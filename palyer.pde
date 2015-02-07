class Player extends Character{
  int X;
  int Y;
  int about_chipX;int about_chipY;
  int move_directionX=0;
  int move_directionY=0;
  int player_direction=2;
  int movingX=world.mapchipsize;
  int movingY=world.mapchipsize;
  float speed=1;
  Player(){
    load_image("player");
    X=world.mapchipsize*15;Y=world.mapchipsize*15;
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
  void move(){
      if(movingX!=0){
        if(move_directionX!=0 && movingX<speed)movingX=0;
        else if(move_directionX!=0)movingX-=speed;
        if(move_directionX==1)X-=speed;
        if(move_directionX==2)X+=speed;
      }
      else {
        movingX=world.mapchipsize;
        move_directionX=0;
      }
    if(movingY!=0){
      if(move_directionY!=0 && movingY<speed)movingY=0;
      else if(move_directionY!=0)movingY-=speed;
      if(move_directionY==1)Y-=speed;
      if(move_directionY==2)Y+=speed;
    }
    else {
      movingY=world.mapchipsize;
      move_directionY=0;
    }
  }
  void draw(){
    if(player_direction==1)image(up,player.X,player.Y);
    if(player_direction==2)image(down,player.X,player.Y);
    if(player_direction==3)image(left,player.X,player.Y);
    if(player_direction==4)image(right,player.X,player.Y);
  }
}
