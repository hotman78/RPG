class Player{
  int X=15;
  int Y=15;
  int mapsizeX=30;
  int mapsizeY=30;
  int move_directionX=0;
  int move_directionY=0;
  int player_direction=2;
  int movingX=16;
  int movingY=16;
  int speed=1;
  PImage cher_up,cher_down,cher_right,cher_left;
  int mapchipsize = 16;
  Player(){
    cher_up = loadImage("up.png");
    cher_down = loadImage("down.png");
    cher_right = loadImage("right.png");
    cher_left = loadImage("left.png");
  }
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
      movingX=mapchipsize;
      move_directionX=0;
    }
  }
  void draw(){
    if(player_direction==1)image(cher_up,player.X,player.Y);
    if(player_direction==2)image(cher_down,player.X,player.Y);
    if(player_direction==3)image(cher_left,player.X,player.Y);
    if(player_direction==4)image(cher_right,player.X,player.Y);
  }
}
