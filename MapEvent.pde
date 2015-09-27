class MapEvent{
  PImage imageDown,imageUp,imageLeft,imageRight;
  String imageName;
  
  float speed;
  WALK moveOption;
  int toX,toY;
  int fromX,fromY;
  int DBid;
  private XML MAPs = loadXML("BasicData/Maps.xml");
  ArrayList<MapEventCommand> command;
  //子クラスにおいてキャラクター毎に設定していきます。
  private HashMap<String,Integer> flag = new HashMap<String,Integer>();  
  Direction direction;
  int X, Y;
  int PAGE_SIZE;
  MapEvent(int tX, int tY, int tSpeed, WALK tMoveOption, String tImageName, int tDBid,int MAP_CHIP_SIZE){
    X=(tX-1)*MAP_CHIP_SIZE;
    Y=(tY-1)*MAP_CHIP_SIZE;
    speed=tSpeed;
    DBid=tDBid;
    imageName=tImageName;
    this.direction=Direction.DOWN; 
    moveOption=tMoveOption;
    this.fromX=this.X;
    this.fromY=this.Y;
    this.toX=this.X;
    this.toY=this.Y;
    imageUp=loadImage("CharaChip/"+imageName+"_up.png");
    imageDown=loadImage("CharaChip/"+imageName+"_down.png");
    imageLeft=loadImage("CharaChip/"+imageName+"_left.png");
    imageRight=loadImage("CharaChip/"+imageName+"_right.png");
    PAGE_SIZE=MAPs.getChild("map").getChildren("EVENT")[this.DBid].getChildren("page").length;
    command = new ArrayList<MapEventCommand>(PAGE_SIZE);
    for(int i=0;i<PAGE_SIZE;i++){
      command.add(new MapEventCommand(this,i));
    }
  }
  
  //キャラクターを描画します。
  void draw(){
    if(imageName==null)return;
    switch(direction){
      case UP:image(imageUp,X,Y);break;
      case DOWN:image(imageDown,X,Y);break;
      case LEFT:image(imageLeft,X,Y);break;
      case RIGHT:image(imageRight,X,Y);break;
    }
  }
  
  //キャラクターを動かします。
  void update(){
    for(int i=0;i<MAPs.getChild("map").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
      command.get(i).doCommand();
      command.get(i).parallelEvent();
      command.get(i).automicEvent();
    }
    
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
    if(X==toX)fromX=X;
    if(Y==toY)fromY=toY;
    if(toY-Y<0 && toX==X)direction=Direction.UP;
    if(toY-Y>0 && toX==X)direction=Direction.DOWN;
    if(toX-X<0 && toY==Y)direction=Direction.LEFT;
    if(toX-X>0 && toY==Y)direction=Direction.RIGHT;
  }  
  
  private void move(Direction muki){
    boolean canMove =((toX-fromX)==0  && muki.dx()!=0)||((toY-fromY) ==0 && muki.dy()!=0);
    if(canMove)direction=muki;

    if(canMove && !world.maps.here(aboutToX()+muki.dx(),aboutToY()+muki.dy(),"all")){
      toX+=world.MAP_CHIP_SIZE*muki.dx();
      toY+=world.MAP_CHIP_SIZE*muki.dy();
    }
    if(canMove &&  world.maps.here(aboutFromX()+muki.dx(),aboutFromY()+muki.dy(),"event")){
      for(int i=0;i<MAPs.getChild("map").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
        command.get(i).conntactEvent(muki);
      }
      
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
  int aboutFromX(){
    return floor(fromX/world.MAP_CHIP_SIZE)+1;
  }
  int aboutFromY(){
    return floor(fromY/world.MAP_CHIP_SIZE)+1;
  }

}