class Cha{
  void cha(){
    if(char_direction==1)image(cher_up,player.X,player.Y);
    if(char_direction==2)image(cher_down,player.X,player.Y);
    if(char_direction==3)image(cher_left,player.X,player.Y);
    if(char_direction==4)image(cher_right,player.X,player.Y);
  }
}
