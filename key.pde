class Key{
    boolean up,down,right,left,shift,enter;
    Key(){
      up=false;
      down=false;
      right=false;
      left=false;
      shift=false;
      enter=false;
    }
  void keyPressed(){
    if(keyCode==UP) up = true;
    else if(keyCode==DOWN) down = true;
    else if(keyCode==RIGHT) right = true;
    else if(keyCode==LEFT) left = true;
    else if(keyCode==SHIFT) shift = true;
    else if(keyCode==ENTER) enter = true;
  }
    
  void keyReleased(){
    if(keyCode==UP) up = false;
    else if(keyCode==DOWN)  down = false;
    else if(keyCode==RIGHT) right= false;
    else if(keyCode==LEFT)  left = false;
    else if(keyCode==SHIFT) shift = false;
    else if(keyCode==ENTER) enter = false;
  }
}
