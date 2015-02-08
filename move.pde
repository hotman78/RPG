class Move{
  void update(Character my){
    switch(my.move_option){
      case key_walk:my.key_move();break;
      case random:my.random_walk();break;
      default:break;
    }
    if(my.movingX==0){
      my.movingX=world.mapchipsize;
      my.move_directionX=Direction.STAY;
    }else{
      if(my.move_directionX!=Direction.STAY && my.movingX<my.speed)my.movingX=0;
      else if(my.move_directionX!=Direction.STAY)my.movingX-=my.speed;
      if(my.move_directionX==Direction.LEFT)my.X-=my.speed;
      if(my.move_directionX==Direction.RIGHT)my.X+=my.speed;
    }
    if(my.movingY==0){
      my.movingY=world.mapchipsize;
      my.move_directionY=Direction.STAY;
    }else{
      if(my.move_directionY!=Direction.STAY && my.movingY<my.speed)my.movingY=0;
      else if(my.move_directionY!=Direction.STAY)my.movingY-=my.speed;
      if(my.move_directionY==Direction.UP)my.Y-=my.speed;
      if(my.move_directionY==Direction.DOWN)my.Y+=my.speed;
    }    
  }
}
