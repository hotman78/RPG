class Config{
  Config(){
    
  }
  void debug(){
    int x=0,y=0;
    text(player.chipX(),x,y+10);
    text(player.chipY(),x,y+20);
    text(player.aboutX(),x,y+30);
    text(player.aboutY(),x,y+40);
    text(player.X,x,y+50);
    text(player.Y,x,y+60); 
    text(npc_co.chipX(),x,y+70);
    text(npc_co.chipY(),x,y+80);
  }
}
