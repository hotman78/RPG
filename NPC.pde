class NPC{
  ArrayList<NPCs> npcs;
  void update(){
    if(npcs.size()!=0){
      for (int i = 0 ; i < npcs.size() ; i++){
        NPCs npc_list = (NPCs)npcs.get(i);
        npc_list.update();
      }
    }
  }
void draw(){
    for (int i = 0 ; i < npcs.size() ; i++){
      NPCs npc_list = (NPCs)npcs.get(i);
      npc_list.draw();
    }
}
  boolean here(int x,int y){
    boolean f=true; 
    for (int i = npcs.size()-1 ; i >= 0 && npcs.size()>0; i--) {
      NPCs npc_list = (NPCs)npcs.get(i);
      if(npc_list.here(x,y))f=false;
    }
    return f;
  }
  void add(){
    
  }
}

class NPCs extends Character{
  void set(int X,int Y,int speed,WALK move_option){
    load_image("yellow");
    speed(speed);
    set_position(X,Y);
    move_option(move_option);
    set();
    talk_flag=0;
  }
}
/*  void talk(){
    switch(talk_flag){
      case 1:
      world.stop();
      case 2:window
      case 3:
    }
  }*/
