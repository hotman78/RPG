class Player extends Character{
  Player(){
    load_image("player");
    speed(3);
    set_position(15,15);
    move_option("key");
  }
}
