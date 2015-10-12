class Maps{
  //マップを設定させます。今のところ1面しかないです
  PImage map,hash;
  XML Maps;
  ArrayList<MapEvent> events;
  Command common[];
  int COMMON_SIZE;
  MapEvent player;
  int MAP_CHIP_SIZE;
  
  Maps(int tMAP_CHIP_SIZE){
    MAP_CHIP_SIZE=tMAP_CHIP_SIZE;
    events = new ArrayList<MapEvent>();
    Maps = loadXML("BasicData/Maps.xml");
    int x=Maps.getChild("playerData").getInt("x");
    int y=Maps.getChild("playerData").getInt("y");
    int mapId=Integer.parseInt(Maps.getChild("playerData").getChild("mapId").getContent());
    loadMap(x,y,mapId);
    addCommon();
  }
  
  void loadMap(int pX,int pY,int mapId){
    WALK walkType;
    String imageName;
    int speed;
    String picture=Maps.getChildren("map")[mapId].getChild("picture").getContent();
    map = loadImage("MapData/"+picture+".png");
    hash = loadImage("MapData/"+picture+"_mask.png");
    
    events.clear();
    for(int i=0;i<Maps.getChildren("map")[mapId].getChildren("EVENT").length;i++){
      int X=Maps.getChildren("map")[mapId].getChildren("EVENT")[i].getInt("x");
      int Y=Maps.getChildren("map")[mapId].getChildren("EVENT")[i].getInt("y");
      
      try{
        speed=Integer.parseInt(Maps.getChildren("map")[mapId].getChildren("EVENT")[i].getChild("speed").getContent());
      }catch(NullPointerException e){speed=0;}
      
      try{
        walkType=WALK.valueOf(Maps.getChildren("map")[mapId].getChildren("EVENT")[i].getChild("walk").getContent());
      }catch(NullPointerException e){walkType=WALK.stay;}
      
      try{
        imageName=Maps.getChildren("map")[mapId].getChildren("EVENT")[i].getChild("picture").getContent();
      }catch(NullPointerException e){imageName=null;}
      MapEvent addedEvent =new MapEvent(X,Y,speed,walkType,imageName,i,MAP_CHIP_SIZE);
      events.add(addedEvent);
    }
    addPlayer(pX,pY);
  }
  
  void addPlayer(int pX,int pY){
    WALK pWalkType;
    try{
      pWalkType=WALK.valueOf(Maps.getChild("getChildplayerData").getChild("walk").getContent());
    }catch(NullPointerException e){pWalkType=WALK.key_walk;}
    int pSpeed=Integer.parseInt(Maps.getChild("playerData").getChild("speed").getContent());
    String pPicture=Maps.getChild("playerData").getChild("picture").getContent();
    player =new MapEvent(pX,pY,pSpeed,pWalkType,pPicture,0,MAP_CHIP_SIZE);
    events.add(player);    
  }
  
  //ここからCommonEventを読み込みます
  void addCommon(){
    COMMON_SIZE=loadXML("BasicData/Common.xml").getChildren("Event").length;
    common = new CommonEventCommand[COMMON_SIZE];
    for(int i=0;i<COMMON_SIZE;i++)common[i]=new CommonEventCommand(null,i);
  }
  
  //イベントを動かします
  void update(){
    if(events.size()!=0){
      for (int i = 0 ; i < events.size() ; i++){
        events.get(i).update();
      }
    }
    for(int i=0;i<COMMON_SIZE;i++){
      common[i].update();
      common[i].parallelEvent();
      common[i].automicEvent();
    }
  }
  //描画します
  void draw(){
    world.c.pg.beginDraw();
    world.c.pg.image(map,0,0);
    for (int i = 0 ; i < events.size() ; i++){
      events.get(i).draw();
    }
    world.c.pg.endDraw();
  }
  
  private color hash(int x,int y){
   if(x>0 && x<world.mapsizeX+1 && y>0 && y<world.mapsizeY+1)
     return hash.pixels[(y-1)*hash.width+(x-1)];
   else return color(0);
  }
  boolean here(int X,int Y,String option){
    //障害物の判定を行います
    if(option=="map")return (hash(X,Y)== color(0));
    //イベントの当たり判定を行います
    if(option=="event"){
      boolean f=false;
      for (int i = 0 ; i < events.size() ; i++){
        if(events.get(i).here(X,Y))f=true;
      }return f;
    }
    
    if(option=="all"){
      if(hash(X,Y)== color(0))return true;
      boolean f=false;
      for (int i = 0 ; i < events.size() ; i++){
        if(events.get(i).here(X,Y)){f=true;}
      }return f;
    }return false;
  }
  
  MapEvent eventSearch(int X,int Y){
    for (int i = 0 ; i < events.size() ; i++) {
      if(events.get(i).here(X,Y))return events.get(i);
    }return null;
  }
}