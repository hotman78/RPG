class NPC{
  //NPCを追加し、NPCの情報を返します
  
  //ここからNPCを追加します
  void yellow(){
    NPCs yellow =new NPCs();
    npcs.add(yellow);
    yellow.set(15,15,1,WALK.stay,"yellow");
    yellow.TalkingContents="テストですよー";
  }
  
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
    boolean f=false;
    for (int i = npcs.size()-1 ; i >= 0 && npcs.size()>0; i--) {
      NPCs npc_list = (NPCs)npcs.get(i);
      if(npc_list.here(x,y))f=true;
    }
    return f;
  }
  NPCs search(int x,int y){
    for (int i = npcs.size()-1 ; i >= 0 && npcs.size()>0; i--) {
      NPCs npc_list = (NPCs)npcs.get(i);
      if(npc_list.here(x,y))return npc_list;
    }
    return null;
  }
}

class NPCs extends Character{
  //NPCが要素として格納されているLISTです。
  
  String TalkingContents="null";  //要素ごとにひとつの話す内容をもたせます
  
  //設定です。親クラスではお約束文をまとめてます。
  void set(int X,int Y,int speed,WALK move_option,String imgage_name){
    super.set();
    load_image(imgage_name);
    speed(speed);
    set_position(X,Y);
    move_option(move_option);
  }
  
  void talk(){
    println("うわーーーーーーー");
    image(MessageBox,0,height*3/4,width, height*1/4);
    text(TalkingContents,0+50,height*3/4+50);
  }
}
