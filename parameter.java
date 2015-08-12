enum WALK{key_walk,random,stay}
enum CHAR{player,NPC,enemy}
enum Direction{UP,DOWN,LEFT,RIGHT,STAY;
  int dx(){
    switch(this){
      case LEFT   :return -1;
      case RIGHT :return 1;
      default:return 0;
    }
  }
  int dy(){
    switch(this){
      case UP   :return -1;
      case DOWN :return 1;
      default:return 0;
    }
  }
}
/*
enum Direction{UP(0,-1),DOWN(0,1),LEFT(-1,0),RIGHT(1,0),STAY(0,0);
  int dx,dy;
  Direction{
    
  }
}
enum Direction{UP,DOWN,LEFT,RIGHT,STAY;
  int dx(){
    switch(this){
      case UP   :return -1;
      case DOWN :return 1;
      default:return 0;
    }
  }
  int dy(){
    switch(this){
      case UP   :return -1;
      case DOWN :return 1;
      default:return 0;
    }
  }
}
*/
