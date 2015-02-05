class Player{
  int X=15;
  int Y=15;
  void move(){
    if(movingY!=0){
      if(move_directionY!=0)movingY--;
      if(move_directionY==1)Y-=speed;
      if(move_directionY==2)Y+=speed;
    }
    else {
      movingY=16;
      move_directionY=0;
    }
    if(movingX!=0){
      if(move_directionX!=0)movingX--;
      if(move_directionX==1)X-=speed;
      if(move_directionX==2)X+=speed;
    }
    else {
      movingX=16;
      move_directionX=0;
    }
  }
}
