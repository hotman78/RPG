class Config{
  Config(){
    
  }
  void debug(){
    //プレイヤーの位置座標を表示させてます
    int x=0,y=0;
    text(player.chipX(),x,y+10);
    text(player.chipY(),x,y+20);
    text(player.aboutX(),x,y+30);
    text(player.aboutY(),x,y+40);
    text(player.X,x,y+50);
    text(player.Y,x,y+60);
  }
}
