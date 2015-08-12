//playerを作るためのクラスです。
class Player{
  Events player;
  Player(){
    player =new Events();
    events.add(player);
    player.set(15,15,1,WALK.key_walk,"player");
  }
}
