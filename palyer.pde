//playerを作るためのクラスです。
class Player extends Character{
  Player(){
    load_image("player");
    speed(1);
    set_position(15,15);
    move_option(WALK.key_walk);
    set();
  }
  
  void talk(){
    //enterを押した際に目の前にNPCがいたら話せます。
    NPCs talkedNPC = npc.search(this.aboutX,this.aboutY);
    println(npc.here(this.aboutX,this.aboutY));
    if(talkedNPC!=null)talkedNPC.talk();
  }
}
