class Config{
  Config(){
    
  }
  void debug(){
    //プレイヤーの位置座標を表示させてます
    int x=0,y=0;
    text(player.player.chipY()-player.player.fromX,x,y+10);
    text(player.player.chipY(),x,y+20);
    text(player.player.fromX,x,y+30);
    text(player.player.fromY,x,y+40);
    text(player.player.toX,x,y+50);
    text(player.player.toY,x,y+60);
    if(maps.eventSearch(15,15)!=null)text(maps.eventSearch(15,15).DBid,x,y+70);
    else text("null",x,y+70);
  }
}
