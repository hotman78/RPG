class Key{
    int key_up = 0;
    int key_down = 0;
    int key_right = 0;
    int key_left = 0;
    int key_shift = 0;
    int key_enter = 0;
  void key(){
    if(player.move_directionY==0){
      if(key_up==1 && maps.hash(player.X/player.mapchipsize+1,player.Y/16)!=color(0)){
        player.move_directionY=1;
        player.player_direction=1;
      }
      if(key_down==1 && maps.hash(player.X/16+1,player.Y/16+2)!=color(0)){
        player.move_directionY=2;
        player.player_direction=2;
      }
    }
    if(player.move_directionX==0){
      if(key_left==1 && maps.hash(player.X/16,player.Y/16+1)!=color(0)){
        player.move_directionX=1;
        player.player_direction=3;
      }
      if(key_right==1 && maps.hash(player.X/16+2,player.Y/16+1)!=color(0)){
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
