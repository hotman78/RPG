class Key{
    int key_up = 0;
    int key_down = 0;
    int key_right = 0;
    int key_left = 0;
    int key_shift = 0;
    int key_enter = 0;
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
