class Collider{
  Collider(){
    
  }
  void update(Character my){
    switch(my.move_option){
      case key_walk:my.key_move();break;
      case random:my.random_walk();break;
      default:break;
    }
    if(my.movingX!=0){
      if(my.move_directionX!=0 && my.movingX<my.speed)my.movingX=0;
      else if(my.move_directionX!=0)my.movingX-=my.speed;
      if(my.move_directionX==1)my.X-=my.speed;
      if(my.move_directionX==2)my.X+=my.speed;
    }
    if(my.movingX==0){
      my.movingX=world.mapchipsize;
      my.move_directionX=0;
    }
    if(my.movingY!=0){
      if(my.move_directionY!=0 && my.movingY<my.speed)my.movingY=0;
      else if(my.move_directionY!=0)my.movingY-=my.speed;
      if(my.move_directionY==1)my.Y-=my.speed;
      if(my.move_directionY==2)my.Y+=my.speed;
    }
    if(my.movingY==0){
      my.movingY=world.mapchipsize;
      my.move_directionY=0;
    }    
  }
}
