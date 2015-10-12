class Input{
    boolean up,down,right,left,shift,enter;
    int pKeyCode;
    boolean typed;
    Input(){
      up=false;
      down=false;
      right=false;
      left=false;
      shift=false;
      enter=false;
    }
  void keyPressed(){
    if(keyCode!=pKeyCode)keyTyped();
    pKeyCode=keyCode;
    
    for(int i=0;i<world.maps.COMMON_SIZE;i++){
      for(int j=0;j<world.maps.events.get(i).PAGE_SIZE;j++){
        world.maps.events.get(i).command.get(j).keyPressed();
      }
    }
    
    if(keyCode==UP) up = true;
    else if(keyCode==DOWN) down = true;
    else if(keyCode==RIGHT) right = true;
    else if(keyCode==LEFT) left = true;
    else if(keyCode==SHIFT) shift = true;
    else if(keyCode==ENTER) enter = true;
  }
  
  void keyTyped(){
    typed=false;
    for(int i=0;i<world.maps.COMMON_SIZE;i++){
      for(int j=0;j<world.maps.events.get(i).PAGE_SIZE;j++){
        if(!typed)world.maps.events.get(i).command.get(j).keyTyped();
      }
    }
    
    if(keyCode==ENTER) {
      for (int i = 0 ; i < world.maps.events.size() ; i++){
        for(int j=0;j<world.maps.Maps.getChild("map").getChildren("EVENT")[world.maps.events.get(i).DBid].getChildren("page").length;j++){
          if(!typed)world.maps.events.get(i).command.get(j).enterEvent();
        }
      }
    }
  }
   
  void keyReleased(){
    pKeyCode=-1;
    if(keyCode==UP) up = false;
    else if(keyCode==DOWN)  down = false;
    else if(keyCode==RIGHT) right= false;
    else if(keyCode==LEFT)  left = false;
    else if(keyCode==SHIFT) shift = false;
    else if(keyCode==ENTER) enter = false;
  }
}