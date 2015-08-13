class Character{
  PImage down,up,left,right;
  int X;int Y;
  int aboutX;int aboutY;
  float speed;
  WALK move_option;
  Direction direction;
  int toX,toY;
  int fromX,fromY;
  int DBid;
  void move(Direction muki){
    switch(muki){
      case UP:
      if(toY-fromY>-world.MAP_CHIP_SIZE)direction=Direction.UP;
      if(toY-fromY>-world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX(),aboutToY()-1,"all"))toY-=world.MAP_CHIP_SIZE;
      if(toY-fromY>-world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX(),aboutToY()-1,"event"))command.conntactEvent((Events)this,maps.eventSearch(aboutToX(),aboutToY()-1));
      break;
      case DOWN:
      if(toY-fromY<+world.MAP_CHIP_SIZE)direction=Direction.DOWN;
      if(toY-fromY<+world.MAP_CHIP_SIZE &&  !maps.here(aboutToX(),aboutToY()+1,"all"))toY+=world.MAP_CHIP_SIZE;
      if(toY-fromY<+world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX(),aboutToY()+1,"event"))command.conntactEvent((Events)this,maps.eventSearch(aboutToX(),aboutToY()+1));
      break;
      case LEFT:
      if(toX-fromX>-world.MAP_CHIP_SIZE)direction=Direction.LEFT;
      if(toX-fromX>-world.MAP_CHIP_SIZE &&  !maps.here(aboutToX()-1,aboutToY(),"all"))toX-=world.MAP_CHIP_SIZE;
      if(toX-fromX>-world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX()-1,aboutToY(),"event"))command.conntactEvent((Events)this,maps.eventSearch(aboutToX()-1,aboutToY()));
      break;
      case RIGHT:
      if(toX-fromX<+world.MAP_CHIP_SIZE)direction=Direction.RIGHT;
      if(toX-fromX<+world.MAP_CHIP_SIZE && !maps.here(aboutToX()+1,aboutToY(),"all"))toX+=world.MAP_CHIP_SIZE;
      if(toX-fromX<+world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX()+1,aboutToY(),"event"))command.conntactEvent((Events)this,maps.eventSearch(aboutToX()+1,aboutToY()));
      break;
    }
  }
  //キャラクターを動かします。
  void update(){
    //並列実行,接触実行するイベントを呼び出します
    command.parallelEvent((Events)this);
    switch(move_option){
      case key_walk:key_move();break;
      case random:random_walk();break;
      case stay:break;
      default:break;
    }
  if(toX<X)X--;
  if(X<toX)X++;
  if(toY<Y)Y--;
  if(Y<toY)Y++;
  if(X==toX)fromX=toX;
  if(Y==toY)fromY=toY;
  if(toY-Y<0)direction=Direction.UP;
  if(toY-Y>0)direction=Direction.DOWN;
  if(toX-X<0)direction=Direction.LEFT;
  if(toX-X>0)direction=Direction.RIGHT;
  }
  
  //小クラスにおいてキャラクター毎に設定していきます。
  HashMap<String,Integer> flag = new HashMap<String,Integer>();
  //HashMap<String,int> map = new HashMap<String,int>();
  
  //キャラクターが特定座標にいるか否かを返します
  boolean here(int x,int y){return (x==this.aboutX() && y==this.aboutY());}
  
  //歩き方を設定しています　key_move,random_walk,stayがあります。
  void move_option(WALK par){
    switch(par){
      case key_walk: move_option=WALK.key_walk;break;
      case random: move_option=WALK.random;break;
      case stay:move_option=WALK.stay;break;
    }
  }
  
  void key_move(){
    if(key.up)move(Direction.UP);
    if(key.down)move(Direction.DOWN);
    if(key.left)move(Direction.LEFT);
    if(key.right)move(Direction.RIGHT);
  }
  void random_walk(){
    if(toX-X==0 && toY-Y==0){
      int i =floor(random(0,5));
      switch(i){
        case 1:move(Direction.UP);break;
        case 2:move(Direction.DOWN);break;
        case 3:move(Direction.LEFT);break;
        case 4:move(Direction.RIGHT);break;
      }
    }
  }
  boolean col(Direction dir,int y,int x){
    return dir==Direction.STAY && maps.here(x,y,"map");
  }

  //キャラクターのパラメータを設定させます。NPCsのsetやPlayerのコンストラクタから呼ばれます。
  void speed(float speed_replace){
    speed=speed_replace;
  }
  void set_position(int set_X,int set_Y){
    X=(set_X-1)*world.MAP_CHIP_SIZE;
    Y=(set_Y-1)*world.MAP_CHIP_SIZE;
  }
  void load_image(String file_name){
    down =loadImage(file_name+"_down.png");
    up =loadImage(file_name+"_up.png");
    left =loadImage(file_name+"_left.png");
    right =loadImage(file_name+"_right.png"); 
  }
  
  //キャラクターを描画します。
  void draw(){
    switch(direction){
      case UP:image(up,X,Y);break;
      case DOWN:image(down,X,Y);break;
      case LEFT:image(left,X,Y);break;
      case RIGHT:image(right,X,Y);break;
    }
  }
  //キャラクターの位置です。chipX,Yは小数点込み、aboutX,Yは切り捨てて表示されます
  float chipX(){
    return X/world.MAP_CHIP_SIZE+1;
  }
  float chipY(){
    return Y/world.MAP_CHIP_SIZE+1;
  }
  int aboutX(){
    return floor(X/world.MAP_CHIP_SIZE)+1;
  }
  int aboutY(){
    return floor(Y/world.MAP_CHIP_SIZE)+1;
  }
  int aboutToX(){
    return floor(toX/world.MAP_CHIP_SIZE)+1;
  }
  int aboutToY(){
    return floor(toY/world.MAP_CHIP_SIZE)+1;
  }
  //設定です。NPCsではNPCのパラメータを設定してます。
  void set(){
    this.fromX=X;
    this.fromY=Y;
    this.toX=X;
    this.toY=Y;
    this.direction=Direction.UP;
  }
}
