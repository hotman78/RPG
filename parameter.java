enum WALK{key_walk,random,stay}
enum CHAR{player,NPC,enemy}
enum Direction{
  UP{
    @Override
    void collider(){
      if(move_directionY==Direction.STAY && maps.here(aboutX(),aboutY()-1)){
        move_directionY=Direction.UP;
        direction=Direction.UP;
      }
    }
  },
  DOWN{
    @Override
    void collider(){
      if(move_directionY==Direction.STAY && maps.here(aboutX(),aboutY()+1)){
        move_directionY=Direction.DOWN;
        direction=Direction.DOWN;
      }      
    }
  },
  LEFT{
    @Override
    void collider(){
      if(move_directionX==Direction.STAY && maps.here(aboutX()-1,aboutY())){
        move_directionX=Direction.LEFT;
        direction=Direction.LEFT;
      }      
    }    
  },
  RIGHT{
    @Override
    void collider(){
      if(move_directionX==Direction.STAY && maps.here(aboutX()+1,aboutY())){
        move_directionX=Direction.RIGHT;
        direction=Direction.RIGHT;
      } 
    }
  },
  STAY{
    @Override
    void collider(C){
      
    }    
  };
    public abstract void collider();
}

