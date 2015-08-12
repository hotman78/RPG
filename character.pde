class Character{
  PImage down,up,left,right;
  int X;int Y;
  int aboutX;int aboutY;
  float speed;
  WALK move_option;
  Direction direction;
  int toX=0,toY=0;
  int fromX,fromY;
  int DBid;
  void move(Direction muki){
    switch(muki){
      case UP:if(toY!=-1 && !maps.here(fromX+toX,fromY+toY-1,"all")){toY--;break;}
      case DOWN:if(toY!=1 && !maps.here(fromX+toX,fromY+toY+1,"all")){toY++;break;}
      case LEFT:if(toX!=-1 && !maps.here(fromX+toX-1,fromY+toY,"all")){toX--;break;}
      case RIGHT:if(toX!=1 && !maps.here(fromX+toX+1,fromY+toY,"all")){toX++;break;}
    }
  }
  //キャラクターを動かします。
  void update(){
    //並列実行,接触実行するイベントを呼び出します
    command.parallelEvent((Events)this,this.DBid);
    switch(move_option){
      case key_walk:key_move();break;
      case random:random_walk();break;
      case stay:break;
      default:break;
    }
    //Xをうごかします
    float x=this.chipX();
   //Yをうごかします
   if((chipX()-fromX)>toX){
      if(speed>fromX+toX-X)X-=speed;
      else X=(fromX+toX)*world.mapchipsize;
    }
    if((chipX()-fromX)<toX){
      if(speed>fromX+toX-X)X+=speed;
      else X=(fromX+toX)*world.mapchipsize;
    }
    if((chipX()-fromX)==toX){
      fromX=toX+fromX;
      toY=0;
    }
    //Yをうごかします
    if((chipY()-fromY)>toY){
      if(speed>fromY+toY-Y)Y-=speed;
      else Y=(fromY+toY)*world.mapchipsize;
    }
    if((chipY()-fromY)<toY){
      if(speed>fromY+toY-Y)Y+=speed;
      else Y=(fromY+toY)*world.mapchipsize;
    }
    if((chipY()-fromY)==toY){
      fromY=toY+fromY;
      toY=0;
    }
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
    if(toX==0 && toY==0){
      int i =floor(random(0,5));
      switch(i){
        case 0:move(Direction.UP);break;
        case 1:move(Direction.UP);break;
        case 2:move(Direction.DOWN);break;
        case 3:move(Direction.LEFT);break;
        case 4:move(Direction.RIGHT);break;
        case 5:move(Direction.RIGHT);break;
      }
    }
  }
  boolean col(Direction dir,int y,int x){
    return dir==Direction.STAY && maps.here(x,y,"map");
  }
  
  /*-------------------------------------------------
  キャラクターの上下左右への動きを制御しています。長いです^^;
  また動く際に接触イベントが発生します
  変数紹介
  muki:渡された変数で向かいたいたい向きを表します。
  dx:上下方向で今現在どの方向に動いてるのかを現します
  dy:左右方向で今現在どの方向に動いてるのかを現します
  copyDxDy:dx,dyをコピーしておいてあたり判定において移動不可能となった場合にdxに戻します
  イベントにぶつかった場合接触イベントの後ブレイクされます
  -------------------------------------------------*/
  //キャラクターのパラメータを設定させます。NPCsのsetやPlayerのコンストラクタから呼ばれます。
  void speed(float speed_replace){
    speed=speed_replace;
  }
  void set_position(int set_X,int set_Y){
    X=(set_X-1)*world.mapchipsize;
    Y=(set_Y-1)*world.mapchipsize;
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
    return X/world.mapchipsize+1;
  }
  float chipY(){
    return Y/world.mapchipsize+1;
  }
  int aboutX(){
    return floor(X/world.mapchipsize)+1;
  }
  int aboutY(){
    return floor(Y/world.mapchipsize)+1;
  }
  
  //設定です。NPCsではNPCのパラメータを設定してます。
  void set(){
    this.fromX=int(chipX());
    println(fromX);
    println(chipX());
    println(chipY());
    this.fromY=int(chipY());
    println(fromY);
    this.direction=Direction.UP;
  }
}
