class Config{
  Config(){
    
  }
  void debug(){
    int x=0,y=0;
    text(player.chipX(),x,y);
    text(player.chipY(),x,y+10);
    text(player.aboutX(),x,y+20);
    text(player.aboutY(),x,y+30);
    text(player.X,x,y+40);
    text(player.Y,x,y+50); 
  }
}
