class Events{
  private PImage down,up,left,right;
  private float speed;
  private WALK moveOption;
  private int toX,toY;
  private int fromX,fromY;
  private  int DBid;
  private XML MAPs = loadXML("MAPs.xml");
  private Command[] command;
  //小クラスにおいてキャラクター毎に設定していきます。
  private HashMap<String,Integer> flag = new HashMap<String,Integer>();  
  Direction direction;
  int X, Y;
  
  Events(int tX, int tY, int tSpeed, WALK tMoveOption, String image_name, int DBid,int MAP_CHIP_SIZE){
    X=(tX-1)*MAP_CHIP_SIZE;
    Y=(tY-1)*MAP_CHIP_SIZE;
    speed=tSpeed;
    this.direction=Direction.DOWN;
    down =loadImage(image_name+"_down.png");
    up =loadImage(image_name+"_up.png");
    left =loadImage(image_name+"_left.png");
    right =loadImage(image_name+"_right.png"); 
    moveOption=tMoveOption;
    this.fromX=this.X;
    this.fromY=this.Y;
    this.toX=this.X;
    this.toY=this.Y;
    command =new Command[MAPs.getChild("草原").getChildren("EVENT")[this.DBid].getChildren("page").length];
    for(int i=0;i<MAPs.getChild("草原").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
      command[i] = new Command(this,i);
    }
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
  
  //キャラクターを動かします。
  void update(){
    for(int i=0;i<MAPs.getChild("草原").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
      command[i].doCommand();
    }
    //並列実行,接触実行するイベントを呼び出します
    //command.startCommand("parallel");
    switch(moveOption){
      case key_walk:key_move();break;
      case random:random_walk();break;
      case stay:break;
      default:break;
    }
    if(toX<X)X-=speed;
    if(X<toX)X+=speed;
    if(toY<Y)Y-=speed;
    if(Y<toY)Y+=speed;
    if(X==toX)fromX=toX;
    if(Y==toY)fromY=toY;
    if(toY-Y<0)direction=Direction.UP;
    if(toY-Y>0)direction=Direction.DOWN;
    if(toX-X<0)direction=Direction.LEFT;
    if(toX-X>0)direction=Direction.RIGHT;
  }  
  
  private void move(Direction muki){
    switch(muki){
      case UP:
      if(toY-fromY>-world.MAP_CHIP_SIZE)direction=Direction.UP;
      if(toY-fromY>-world.MAP_CHIP_SIZE   &&  !world.maps.here(aboutToX(),aboutToY()-1,"all"))toY-=world.MAP_CHIP_SIZE;
      //if(toY-fromY>-world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX(),aboutToY()-1,"event"))command.coanntactEvent(maps.eventSearch(aboutToX(),aboutToY()-1));
      break;
      case DOWN:
      if(toY-fromY<+world.MAP_CHIP_SIZE)direction=Direction.DOWN;
      if(toY-fromY<+world.MAP_CHIP_SIZE &&  !world.maps.here(aboutToX(),aboutToY()+1,"all"))toY+=world.MAP_CHIP_SIZE;
      //if(toY-fromY<+world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX(),aboutToY()+1,"event"))command.conntactEvent(maps.eventSearch(aboutToX(),aboutToY()+1));
      break;
      case LEFT:
      if(toX-fromX>-world.MAP_CHIP_SIZE)direction=Direction.LEFT;
      if(toX-fromX>-world.MAP_CHIP_SIZE &&  !world.maps.here(aboutToX()-1,aboutToY(),"all"))toX-=world.MAP_CHIP_SIZE;
      //if(toX-fromX>-world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX()-1,aboutToY(),"event"))command.conntactEvent(maps.eventSearch(aboutToX()-1,aboutToY()));
      break;
      case RIGHT:
      if(toX-fromX<+world.MAP_CHIP_SIZE)direction=Direction.RIGHT;
      if(toX-fromX<+world.MAP_CHIP_SIZE && !world.maps.here(aboutToX()+1,aboutToY(),"all"))toX+=world.MAP_CHIP_SIZE;
      //if(toX-fromX<+world.MAP_CHIP_SIZE   &&  !maps.here(aboutToX()+1,aboutToY(),"event"))command.conntactEvent(maps.eventSearch(aboutToX()+1,aboutToY()));
      break;
    }
  }
  
  //キャラクターが特定座標にいるか否かを返します
  boolean here(int x,int y){return (x==this.aboutX() && y==this.aboutY());}
  
  private void key_move(){
    if(world.key.up)move(Direction.UP);
    if(world.key.down)move(Direction.DOWN);
    if(world.key.left)move(Direction.LEFT);
    if(world.key.right)move(Direction.RIGHT);
  }
  
  private void random_walk(){
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
/*  boolean col(Direction dir,int y,int x){
    return dir==Direction.STAY && maps.here(x,y,"map");
  }*/
  //キャラクターの位置です。chipX,Yは小数点込み、aboutX,Yは切り捨てて表示されます
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
}