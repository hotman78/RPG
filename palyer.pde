class Player extends Character{
  Player(){
    load_image("player");
    speed(1);
    set_position(15,15);
    move_option(WALK.key_walk);
    set();
  }
}
