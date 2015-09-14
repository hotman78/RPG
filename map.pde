class Maps{
  //マップを設定させます。今のところ1面しかないです
  PImage map,hash;
  XML MAPs;
  ArrayList<Events> events;
  Events player;
  
  Maps(){
    events = new ArrayList<Events>();
    map = loadImage("map.png");
    hash = loadImage("mask.png");
  }
  
  //ここからEVENTを読み込みます
  void addEVENT(int MAP_CHIP_SIZE){
    MAPs = loadXML("MAPs.xml");
    WALK walkType;
    
    player =new Events(15,15,16,WALK.key_walk,"player",0,MAP_CHIP_SIZE);
    world.maps.events.add(player);
      
    for(int i=0;i<MAPs.getChild("草原").getChildren("EVENT").length;i++){
      try{
        walkType=WALK.valueOf(MAPs.getChild("草原").getChildren("EVENT")[i].getChild("WALK").getContent());
      }catch(NullPointerException e){walkType=WALK.random;}
    
      int X=MAPs.getChild("草原").getChildren("EVENT")[i].getInt("X");
      int Y=MAPs.getChild("草原").getChildren("EVENT")[i].getInt("Y");
      int speed=Integer.parseInt(MAPs.getChild("草原").getChildren("EVENT")[i].getChild("SPEED").getContent());
      String gazou=MAPs.getChild("草原").getChildren("EVENT")[i].getChild("GAZOU").getContent();
      Events addedEvent =new Events(X,Y,speed,walkType,gazou,i,MAP_CHIP_SIZE);
      events.add(addedEvent);
      addedEvent.DBid=i;
    }
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