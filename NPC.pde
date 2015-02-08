class NPC_co extends Character{
  NPC_co(){
    load_image("yellow");
    speed(1);
    set_position(12,12);
    move_option(WALK.random);
  }
  void talk_event(){
  }
}
