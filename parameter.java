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