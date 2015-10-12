class MapEvent{
  PImage imageDown,imageUp,imageLeft,imageRight;
  String imageName;
  
  float speed;
  WALK moveOption;
  int toX,toY;
  int fromX,fromY;
  int DBid;
  
  private XML map = loadXML("BasicData/Maps.xml");
  ArrayList<MapEventCommand> command;
  //子クラスにおいてキャラクター毎に設定していきます。
  private HashMap<String,Integer> flag = new HashMap<String,Integer>();  
  Direction direction;
  int x,y;
  int PAGE_SIZE;
  MapEvent(int x, int y, int speed, WALK moveOption, String imageName, int DBid,int MAP_CHIP_SIZE){
    this.x=(x-1)*MAP_CHIP_SIZE;
    this.y=(y-1)*MAP_CHIP_SIZE;
    this.speed=speed;
    this.DBid=DBid;
    this.imageName=imageName;
    this.direction=Direction.DOWN; 
    this.moveOption=moveOption;
    this.fromX=this.x;
    this.fromY=this.y;
    this.toX=this.x;
    this.toY=this.y;
    
    imageUp=loadImage("CharaChip/"+imageName+"_up.png");
    imageDown=loadImage("CharaChip/"+imageName+"_down.png");
    imageLeft=loadImage("CharaChip/"+imageName+"_left.png");
    imageRight=loadImage("CharaChip/"+imageName+"_right.png");
    
    PAGE_SIZE=map.getChild("map").getChildren("EVENT")[this.DBid].getChildren("page").length;
    
    command = new ArrayList<MapEventCommand>(PAGE_SIZE);
    for(int i=0;i<PAGE_SIZE;i++){
      command.add(new MapEventCommand(this,i));
    }
  }
  
  //キャラクターを描画します。
  void draw(){
    if(imageName==null)return;
    switch(direction){
      case UP:world.c.pg.image(imageUp,x,y);break;
      case DOWN:world.c.pg.image(imageDown,x,y);break;
      case LEFT:world.c.pg.image(imageLeft,x,y);break;
      case RIGHT:world.c.pg.image(imageRight,x,y);break;
    }
  }
  
  //キャラクターを動かします。
  void update(){
    for(int i=0;i<PAGE_SIZE;i++){
      command.get(i).update();
      command.get(i).parallelEvent();
      command.get(i).automicEvent();
    }
    
    switch(moveOption){
      case key_walk:key_move();break;
      case random:random_walk();break;
      case stay:break;
      default:break;
    }
    if(toX<x)x-=speed;
    if(x<toX)x+=speed;
    if(toY<y)y-=speed;
    if(y<toY)y+=speed;
    if(x==toX)fromX=x;
    if(y==toY)fromY=toY;
    if(toY-y<0 && toX==x)direction=Direction.UP;
    if(toY-y>0 && toX==x)direction=Direction.DOWN;
    if(toX-x<0 && toY==y)direction=Direction.LEFT;
    if(toX-x>0 && toY==y)direction=Direction.RIGHT;
  }  
  
  private void move(Direction picDirection){
    boolean canMove =((toX-fromX)==0  && picDirection.dx()!=0)||((toY-fromY) ==0 && picDirection.dy()!=0);
    if(canMove)direction=picDirection;
    if(canMove && !world.maps.here(aboutToX()+picDirection.dx(),aboutToY()+picDirection.dy(),"all")){
      toX+=world.MAP_CHIP_SIZE*picDirection.dx();
      toY+=world.MAP_CHIP_SIZE*picDirection.dy();
    }
    if(canMove &&  world.maps.here(aboutFromX()+picDirection.dx(),aboutFromY()+picDirection.dy(),"event")){
      for(int i=0;i<map.getChild("map").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
        command.get(i).conntactEvent(picDirection);
      }
      
    }
  }
  
  //キャラクターが特定座標にいるか否かを返します
  boolean here(int x,int y){return (x==this.aboutX() && y==this.aboutY());}
  
  private void key_move(){
    if(world.input.up)move(Direction.UP);
    if(world.input.down)move(Direction.DOWN);
    if(world.input.left)move(Direction.LEFT);
    if(world.input.right)move(Direction.RIGHT);
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
  
  //キャラクターの位置です。、aboutX,Yはチップ単位の表示です。
  int aboutX(){
    return floor(x/world.MAP_CHIP_SIZE)+1;
  }
  int aboutY(){
    return floor(y/world.MAP_CHIP_SIZE)+1;
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