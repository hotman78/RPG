//playerを作るためのクラスです。
class Player{
  Events player;
  Player(){
    player =new Events(15,15,1,WALK.key_walk,"player");
    events.add(player);
  }
}
