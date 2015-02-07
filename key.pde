class Key{
    int key_up = 0;
    int key_down = 0;
    int key_right = 0;
    int key_left = 0;
    int key_shift = 0;
    int key_enter = 0;
  void key(){
    if(player.move_directionY==0){
      //up
      if(key_up==1 && maps.hash(player.about_chipX(),player.about_chipY()-1)!=color(0)){
        player.move_directionY=1;
        player.player_direction=1;
      }
      //down
      if(key_down==1 && maps.hash(player.about_chipX(),player.about_chipY()+1)!=color(0)){
        player.move_directionY=2;
        player.player_direction=2;
      }
    }
    if(player.move_directionX==0){
      //left
      if(key_left==1 && maps.hash(player.about_chipX()-1,player.about_chipY())!=color(0)){
        player.move_directionX=1;
        player.player_direction=3;
      }
      //right
      if(key_right==1 && maps.hash(player.about_chipX()+1,player.about_chipY())!=color(0)){
        player.move_directionX=2;
        player.player_direction=4;
      }
    }
  }
  void keyPressed(){
    if(keyCode==UP) key_up = 1;
    else if(keyCode==DOWN) key_down = 1;
    else if(keyCode==RIGHT) key_right = 1;
    else if(keyCode==LEFT) key_left = 1;
    else if(keyCode==SHIFT) key_shift = 1;
    else if(keyCode==ENTER) key_enter = 1;
  }
    
  void keyReleased(){
    if(keyCode==UP) key_up = 0;
    else if(keyCode==DOWN)  key_down = 0;
    else if(keyCode==RIGHT) key_right = 0;
    else if(keyCode==LEFT)  key_left = 0;
    else if(keyCode==SHIFT) key_shift = 0;
    else if(keyCode==ENTER) key_enter = 0;
  }
}
