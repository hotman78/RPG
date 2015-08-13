class Maps{
  //マップを設定させます。今のところ1面しかないです
  PImage map,hash;
  Maps(){
    map = loadImage("map.png");
    hash = loadImage("mask.png");
  }
  //ここからEVENTを読み込みます
  void addEVENT(){
    XML MAPs = loadXML("MAPs.xml");
    WALK walkType;
    for(int i=0;i<MAPs.getChild("草原").getChildren("EVENT").length;i++){
      try{
        walkType=WALK.valueOf(MAPs.getChild("草原").getChildren("EVENT")[i].getChild("WALK").getContent());
      }catch(NullPointerException e){walkType=WALK.random;}
    
      int X=MAPs.getChild("草原").getChildren("EVENT")[i].getInt("X");
      int Y=MAPs.getChild("草原").getChildren("EVENT")[i].getInt("Y");
      int speed=Integer.parseInt(MAPs.getChild("草原").getChildren("EVENT")[i].getChild("SPEED").getContent());
      String gazou=MAPs.getChild("草原").getChildren("EVENT")[i].getChild("GAZOU").getContent();
      Events addedEvent =new Events();
      events.add(addedEvent);
      addedEvent.set(X,Y,speed,walkType,gazou);
      addedEvent.DBid=i;
    }
  }
  //イベントを動かします
  void update(){
    if(events.size()!=0){
      for (int i = 0 ; i < events.size() ; i++){
        Events eventList = (Events)events.get(i);
        eventList.update();
      }
    }
  }
  //描画します
  void draw(){
    image(map,0,0);
    for (int i = 0 ; i < events.size() ; i++){
      Events eventList = (Events)events.get(i);
      eventList.draw();
    }
    command.dispWindow();
  }
    color hash(int X,int Y){
     if(X>0 && X<world.mapsizeX+1 && Y>0 && Y<world.mapsizeY+1)
     return hash.pixels[(Y-1)*hash.width+(X-1)];
     else return color(0);
  }
  boolean here(int X,int Y,String option){
    //障害物の判定を行います
    if(option=="map")return (maps.hash(X,Y)== color(0));
    
    //イベントの当たり判定を行います
    if(option=="event"){
      boolean f=false;
      for (int i = 0 ; i < events.size() ; i++){
        Events eventList = (Events)events.get(i);
        if(eventList.here(X,Y))f=true;
      }
      return f;
    }
    
    if(option=="all"){
      if(maps.hash(X,Y)== color(0))return true;
      boolean f=false;
      for (int i = 0 ; i < events.size() ; i++){
        Events eventList = (Events)events.get(i);
        if(eventList.here(X,Y))f=true;
      }
      return f ;
    }
    return false;
  }
  Events eventSearch(int X,int Y){
    for (int i = 0 ; i < events.size() ; i++) {
      Events eventList = (Events)events.get(i);
      if(eventList.here(X,Y))return eventList;
    }
    return null;
  }
}
