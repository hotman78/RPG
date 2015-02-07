class Player extends Character{
  Player(){
    load_image("player");
    speed(3);
    set_position(30,30);
    move_option("key");
    X=world.mapchipsize*15;Y=world.mapchipsize*15;
  }
}
