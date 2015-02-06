class Character{
  PImage down,up,left,right;
  Character(){
  }
  void load_image(String file_name){
    down =loadImage(file_name+"_down.png");
    up =loadImage(file_name+"_up.png");
    left =loadImage(file_name+"_left.png");
    right =loadImage(file_name+"_right.png"); 
  }
}
