class Maps{
  //マップを設定させます。今のところ1面しかないです
  PImage map,hash;
  XML MAPs;
  ArrayList<Events> events;
  Command common[];
  Events player;
  int MAP_CHIP_SIZE;
  
  Maps(int tMAP_CHIP_SIZE){
    MAP_CHIP_SIZE=tMAP_CHIP_SIZE;
    events = new ArrayList<Events>();
    MAPs = loadXML("MAPs.xml");
    int x=MAPs.getChild("playerData").getInt("x");
    int y=MAPs.getChild("playerData").getInt("y");
    int mapId=Integer.parseInt(MAPs.getChild("playerData").getChild("mapId").getContent());
    loadMap(x,y,mapId);
  }
  
  void loadMap(int pX,int pY,int mapId){
    WALK walkType;
    String imageName;
    int speed;
    String picture=MAPs.getChildren("map")[mapId].getChild("picture").getContent();
    map = loadImage(picture+".png");
    hash = loadImage(picture+"_mask.png");
    
    events.clear();
    for(int i=0;i<MAPs.getChildren("map")[mapId].getChildren("EVENT").length;i++){
      int X=MAPs.getChildren("map")[mapId].getChildren("EVENT")[i].getInt("x");
      int Y=MAPs.getChildren("map")[mapId].getChildren("EVENT")[i].getInt("y");
      
      try{
        speed=Integer.parseInt(MAPs.getChildren("map")[mapId].getChildren("EVENT")[i].getChild("speed").getContent());
      }catch(NullPointerException e){speed=0;}
      
      try{
        walkType=WALK.valueOf(MAPs.getChildren("map")[mapId].getChildren("EVENT")[i].getChild("walk").getContent());
      }catch(NullPointerException e){walkType=WALK.stay;}
      
      try{
        imageName=MAPs.getChildren("map")[mapId].getChildren("EVENT")[i].getChild("picture").getContent();
      }catch(NullPointerException e){imageName=null;}
      Events addedEvent =new Events(X,Y,speed,walkType,imageName,i,MAP_CHIP_SIZE);
      events.add(addedEvent);
    }
    addPlayer(pX,pY);
  }
  
  void addPlayer(int pX,int pY){
    WALK pWalkType;
    try{
      pWalkType=WALK.valueOf(MAPs.getChild("getChildplayerData").getChild("walk").getContent());
    }catch(NullPointerException e){pWalkType=WALK.key_walk;}
    int pSpeed=Integer.parseInt(MAPs.getChild("playerData").getChild("speed").getContent());
    String pPicture=MAPs.getChild("playerData").getChild("picture").getContent();
    player =new Events(pX,pY,pSpeed,pWalkType,pPicture,0,MAP_CHIP_SIZE);
    events.add(player);    
  }
  
  //ここからCommonEventを読み込みます
  void addCOMMON(){
    int COMMON_SIZE=loadXML("COMMON.xml").getChild("page").getChildren("command").length;
    common = new Command[COMMON_SIZE];
    for(int i=0;i<COMMON_SIZE;i++)common[i]=new Command(null,i);
  }
  
  //イベントを動かします
  void update(){
    if(events.size()!=0){
      for (int i = 0 ; i < events.size() ; i++){
        events.get(i).update();
      }
    }
  }
  //描画します
  void draw(){
    image(map,0,0);
    println(events.size());
    for (int i = 0 ; i < events.size() ; i++){
      events.get(i).draw();
    }
  }
  
  private color hash(int X,int Y){
   if(X>0 && X<world.mapsizeX+1 && Y>0 && Y<world.mapsizeY+1)
     return hash.pixels[(Y-1)*hash.width+(X-1)];
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
        if(events.get(i).here(X,Y))f=true;
      }return f;
    }return false;
  }
  
  Events eventSearch(int X,int Y){
    for (int i = 0 ; i < events.size() ; i++) {
      if(events.get(i).here(X,Y))return events.get(i);
    }return null;
  }
}