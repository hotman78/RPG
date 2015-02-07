class NPC extends Character{
  NPC(){
    load_image("yellow");
    speed(3);
    set_position(30,30);
    X=world.mapchipsize*15;Y=world.mapchipsize*15;
  } 
}

