import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

/*------------------------------------------------
World    :\u4e00\u756a\u5927\u307e\u304b\u306a\u6240\u3092\u6271\u3063\u3066\u3044\u308b\u30af\u30e9\u30b9\u3067\u3059\u3002\u5404\u30af\u30e9\u30b9\u306eSETUP\u3084DRAW\u3084UPDATE\u3092\u547c\u3093\u3067\u307e\u3059\u3002
Character:\u3059\u3079\u3066\u306e\u30ad\u30e3\u30e9\u30af\u30bf\u30fc\u306e\u89aa\u30af\u30e9\u30b9\u3067\u3059\u3002
Player   :\u30d7\u30ec\u30a4\u30e4\u30fc\u306e\u8ffd\u52a0\u30fb\u5236\u5fa1\u3092\u884c\u3044\u307e\u3059
NPC      :NPC\u3092\u8ffd\u52a0\u3057\u3001NPC\u306e\u60c5\u5831\u3092\u8fd4\u3057\u307e\u3059
NPCs     :NPC\u304c\u8981\u7d20\u3068\u3057\u3066\u683c\u7d0d\u3055\u308c\u3066\u3044\u308bLIST\u3067\u3059\u3002
Map      :\u30de\u30c3\u30d7\u3092\u8a2d\u5b9a\u3055\u305b\u307e\u3059\u3002\u4eca\u306e\u3068\u3053\u308d1\u9762\u3057\u304b\u306a\u3044\u3067\u3059
Key      :\u65b0\u3057\u3044key\u4f7f\u3044\u305f\u304f\u306a\u3063\u305f\u3089\u3053\u3061\u3089\u3067\u3059
DB       :DB\u3092\u4fdd\u5b58\u3057\u307e\u3059\u3002
Gui      :\u672a\u5b9f\u88c5\u3067\u3059
--------------------------------------------------*/

World world;

public void setup(){
  
  world=new World();
}

public void draw(){
  world.draw();
}

public void keyPressed(){
  world.key.keyPressed();
}

public void keyReleased(){
  world.key.keyReleased();
}
//\u30b5\u30a6\u30f3\u30c9\u3092\u6d41\u305b\u308b\u3088\u3046\u306b\u3057\u307e\u3059

Minim minim= new Minim(this);  //\u521d\u671f\u5316 

class Command{
  String TalkingContents="null";  //\u8981\u7d20\u3054\u3068\u306b\u3072\u3068\u3064\u306e\u8a71\u3059\u5185\u5bb9\u3092\u3082\u305f\u305b\u307e\u3059
  AudioPlayer player;
  
  XML UDB = loadXML("UDB.xml");
  XML CDB = loadXML("CDB.xml");
  XML SDB = loadXML("SDB.xml");
  XML MAPs = loadXML("MAPs.xml");
  XML xml=null;
  boolean isExecuting=false;
  int commandID;
  int pageNumber;
  String trigger;
  
  Events performer;
  Events playerEvent;
  
  Command(Events t_performer,int t_pageNumber){
    performer=t_performer;
    pageNumber=t_pageNumber;
    xml=MAPs.getChild("\u8349\u539f").getChildren("EVENT")[performer.DBid].getChildren("page")[pageNumber];
    trigger=xml.getString("Trigger");
  }
  
  public void startCommand(String option){
    println(pageNumber+","+commandID+","+trigger+","+option);
    if(!trigger.equals(option))return;
    println(option);
    commandID=0;
    isExecuting=true;
    println(isExecuting);
  }
  
  public void doCommand(){
    if(!isExecuting)return;
    if(xml.listChildren()[commandID]=="messageWindow" && !world.tc.inConversation){world.tc.startConversation(xml.getChildren()[commandID].getContent());}
    if(xml.listChildren()[commandID]=="sound"){sound();}
    else if(commandID==xml.listChildren().length-1){commandID=0;isExecuting=false;}
    else {commandID++;doCommand();}
  }
  
  public void nextCommand(){
    
  }
  
  //\u63a5\u89e6\u30a4\u30d9\u30f3\u30c8\u3092\u547c\u3073\u51fa\u3057\u307e\u3059
  public void conntactEvent(Events object){
    playerEvent=world.player.player;
    if(object==playerEvent)startCommand("playerConntact");
  }
  
  public void enterEvent(){
    playerEvent=world.maps.player;
    if(performer.aboutX()==playerEvent.aboutX()+playerEvent.direction.dx()
    && performer.aboutY()==playerEvent.aboutY()+playerEvent.direction.dy()){startCommand("enter");}
  }
  
  public void sound(){
    player = minim.loadFile("bgm.mp3"); //mp3\u30d5\u30a1\u30a4\u30eb\u3092\u6307\u5b9a\u3059\u308b 
    player.play();  //\u518d\u751f
    player.rewind();
    commandID++;
    doCommand();
  }
   //\u5909\u6570\u3092DB\u304b\u3089\u8aad\u307f\u8fbc\u307f\u307e\u3059
  private String DBread(String DBname,int indexElements,int indexElement){
    XML DB=null;
    if("UDB".equals(DBname))DB=UDB;
    if("CDB".equals(DBname))DB=UDB;
    if("SDB".equals(DBname))DB=SDB;
    XML[] elements = DB.getChildren("elements");
    XML[] items = elements[indexElements].getChildren("element");
    return items[indexElement].getString("data");
  }
  //\u5909\u6570\u3092DB\u306b\u66f8\u304d\u51fa\u3057\u307e\u3059(\u6570\u5024\u306e\u5834\u5408)
  private void DBwrite(String DBname,int indexElements,int indexElement,int written,String option){
    XML DB=null;
    if(DBname=="UDB")DB=UDB;
    if(DBname=="CDB")DB=UDB;
    if(DBname=="SDB")DB=SDB;
    XML item = DB.getChildren("elements")[indexElements].getChildren("element")[indexElement];
    if(option=="==")item.setInt("data",written);
    if(option=="+=")item.setInt("data",item.getInt("data")+written);
    if(option=="-=")item.setInt("data",item.getInt("data")-written);
  }
  //\u5909\u6570\u3092DB\u306b\u66f8\u304d\u51fa\u3057\u307e\u3059(\u6587\u5b57\u5217\u306e\u5834\u5408)
  private void DBwrite(String DBname,int indexElements,int indexElement,String written){
    XML DB=null;
    if(DBname=="UDB")DB=UDB;
    if(DBname=="CDB")DB=UDB;
    if(DBname=="SDB")DB=SDB;
    XML item = DB.getChildren("elements")[indexElements].getChildren("element")[indexElement];
    item.setString("data",written);
  }  
  
  //\u5909\u6570\u3092\u30d5\u30e9\u30b0\u304b\u3089\u8aad\u307f\u8fbc\u307f\u307e\u3059
  private int flagRead(String key,Events performer){
    return performer.flag.get(key);
  }
  
  //\u5909\u6570\u3092\u30d5\u30e9\u30b0\u306b\u66f8\u304d\u8fbc\u307f\u307e\u3059
  private void flagWhite(String key,int value,Events performer,String option){
    if(option=="==")performer.flag.put(key,value);
    if(option=="+=")performer.flag.put(key,performer.flag.get(key)+value);
    if(option=="-=")performer.flag.put(key,performer.flag.get(key)-value);
  }
  
  //\u30b3\u30e2\u30f3\u30a4\u30d9\u30f3\u30c8\u3092\u8aad\u307f\u8fbc\u307f\u3001\u5b9f\u884c\u3057\u307e\u3059
  public void commonEvent(){
    
  }
  
  //\u30e1\u30c3\u30bb\u30fc\u30b8\u30a6\u30a3\u30f3\u30c9\u30a6\u3092\u8868\u793a\u3057\u307e\u3059
/*  void messageWindow(String TalkingContents){
    dispContents=TalkingContents;
    image(MessageBox,0,height*3/4,width, height*1/4);
    text(dispContents,0+50,height*3/4+50);
    
  }*/
}

class TalkCommand{
  PImage MessageBox;
  String dispContents="";
  boolean inConversation;
  
  TalkCommand(){
    MessageBox=loadImage("MessageBox.png");
    inConversation=false;
  }
  
  public void startConversation(String tDispContents){
    dispContents=tDispContents;
    inConversation=true;
  }
  public void stopConversation(){
    dispContents="";
    inConversation=false;
  }
  public void draw(){
    if(!inConversation)return;
    image(MessageBox,0,height*3/4,width, height*1/4);
    text(dispContents,0+50,height*3/4+50);    
  }
}
class DB{
  /*--------------------------------------------
  UDB(\u30e6\u30fc\u30b6\u30fc\u30c7\u30fc\u30bf\u30d9\u30fc\u30b9):\u30e6\u30fc\u30b6\u30fc\u304c
  CDB(\u53ef\u5909\u30c7\u30fc\u30bf\u30d9\u30fc\u30b9)   :
  SDB(\u30b7\u30b9\u30c6\u30e0\u30c7\u30fc\u30bf\u30d9\u30fc\u30b9):
  --------------------------------------------*/
  HashMap<String,HashMap<String,String>> UDB = new HashMap<String,HashMap<String,String>>();
  HashMap<String,HashMap<String,String>> CDB = new HashMap<String,HashMap<String,String>>();
  HashMap<String,HashMap<String,String>> SDB = new HashMap<String,HashMap<String,String>>();
  DB(){
    loadData();
  }
  public void loadData(){
/*    XML UDB = loadXML("UDB.xml");
     XML[] elements = UDB.getChildren("elements");
     XML[] items = elements[0].getChildren("element");
     */
  }
}
class Events{
  private PImage down,up,left,right;
  private float speed;
  private WALK moveOption;
  private int toX,toY;
  private int fromX,fromY;
  private  int DBid;
  private XML MAPs = loadXML("MAPs.xml");
  private Command[] command;
  //\u5c0f\u30af\u30e9\u30b9\u306b\u304a\u3044\u3066\u30ad\u30e3\u30e9\u30af\u30bf\u30fc\u6bce\u306b\u8a2d\u5b9a\u3057\u3066\u3044\u304d\u307e\u3059\u3002
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
    command =new Command[MAPs.getChild("\u8349\u539f").getChildren("EVENT")[this.DBid].getChildren("page").length];
    for(int i=0;i<MAPs.getChild("\u8349\u539f").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
      command[i] = new Command(this,i);
    }
  }
  
  //\u30ad\u30e3\u30e9\u30af\u30bf\u30fc\u3092\u63cf\u753b\u3057\u307e\u3059\u3002
  public void draw(){
    switch(direction){
      case UP:image(up,X,Y);break;
      case DOWN:image(down,X,Y);break;
      case LEFT:image(left,X,Y);break;
      case RIGHT:image(right,X,Y);break;
    }
  }
  
  //\u30ad\u30e3\u30e9\u30af\u30bf\u30fc\u3092\u52d5\u304b\u3057\u307e\u3059\u3002
  public void update(){
    for(int i=0;i<MAPs.getChild("\u8349\u539f").getChildren("EVENT")[this.DBid].getChildren("page").length;i++){
      command[i].doCommand();
    }
    //\u4e26\u5217\u5b9f\u884c,\u63a5\u89e6\u5b9f\u884c\u3059\u308b\u30a4\u30d9\u30f3\u30c8\u3092\u547c\u3073\u51fa\u3057\u307e\u3059
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
  
  //\u30ad\u30e3\u30e9\u30af\u30bf\u30fc\u304c\u7279\u5b9a\u5ea7\u6a19\u306b\u3044\u308b\u304b\u5426\u304b\u3092\u8fd4\u3057\u307e\u3059
  public boolean here(int x,int y){return (x==this.aboutX() && y==this.aboutY());}
  
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
  //\u30ad\u30e3\u30e9\u30af\u30bf\u30fc\u306e\u4f4d\u7f6e\u3067\u3059\u3002chipX,Y\u306f\u5c0f\u6570\u70b9\u8fbc\u307f\u3001aboutX,Y\u306f\u5207\u308a\u6368\u3066\u3066\u8868\u793a\u3055\u308c\u307e\u3059
  public int aboutX(){
    return floor(X/world.MAP_CHIP_SIZE)+1;
  }
  public int aboutY(){
    return floor(Y/world.MAP_CHIP_SIZE)+1;
  }
  public int aboutToX(){
    return floor(toX/world.MAP_CHIP_SIZE)+1;
  }
  public int aboutToY(){
    return floor(toY/world.MAP_CHIP_SIZE)+1;
  }
}
class Config{
  Config(){
    
  }
  public void debug(){
/*    //\u30d7\u30ec\u30a4\u30e4\u30fc\u306e\u4f4d\u7f6e\u5ea7\u6a19\u3092\u8868\u793a\u3055\u305b\u3066\u307e\u3059
    int x=0,y=0;
    text(player.player.toX-player.player.fromX,x,y+10);
    text(player.player.toY,x,y+20);
    text(player.player.X,x,y+30);
   text(player.player.Y,x,y+40);
    text(player.player.fromX,x,y+50);
    text(player.player.fromY,x,y+60);*/
  }
}
class Key{
    boolean up,down,right,left,shift,enter;
    Key(){
      up=false;
      down=false;
      right=false;
      left=false;
      shift=false;
      enter=false;
    }
  public void keyPressed(){
    if(keyCode==UP) up = true;
    else if(keyCode==DOWN) down = true;
    else if(keyCode==RIGHT) right = true;
    else if(keyCode==LEFT) left = true;
    else if(keyCode==SHIFT) shift = true;
    else if(keyCode==ENTER) enter = true;
  }
  
    
  public void keyReleased(){
    if(keyCode==UP) up = false;
    else if(keyCode==DOWN)  down = false;
    else if(keyCode==RIGHT) right= false;
    else if(keyCode==LEFT)  left = false;
    else if(keyCode==SHIFT) shift = false;
    else if(keyCode==ENTER) {
      enter = false;
      for (int i = 0 ; i < world.maps.events.size() ; i++)
        for(int j=0;j<world.maps.MAPs.getChild("\u8349\u539f").getChildren("EVENT")[world.maps.events.get(i).DBid].getChildren("page").length;j++)
          world.maps.events.get(i).command[j].enterEvent();
    }
  }
}
class Maps{
  //\u30de\u30c3\u30d7\u3092\u8a2d\u5b9a\u3055\u305b\u307e\u3059\u3002\u4eca\u306e\u3068\u3053\u308d1\u9762\u3057\u304b\u306a\u3044\u3067\u3059
  PImage map,hash;
  XML MAPs;
  ArrayList<Events> events;
  Events player;
  
  Maps(){
    events = new ArrayList<Events>();
    map = loadImage("map.png");
    hash = loadImage("mask.png");
  }
  
  //\u3053\u3053\u304b\u3089EVENT\u3092\u8aad\u307f\u8fbc\u307f\u307e\u3059
  public void addEVENT(int MAP_CHIP_SIZE){
    MAPs = loadXML("MAPs.xml");
    WALK walkType;
    
    player =new Events(15,15,16,WALK.key_walk,"player",0,MAP_CHIP_SIZE);
    world.maps.events.add(player);
      
    for(int i=0;i<MAPs.getChild("\u8349\u539f").getChildren("EVENT").length;i++){
      try{
        walkType=WALK.valueOf(MAPs.getChild("\u8349\u539f").getChildren("EVENT")[i].getChild("WALK").getContent());
      }catch(NullPointerException e){walkType=WALK.random;}
    
      int X=MAPs.getChild("\u8349\u539f").getChildren("EVENT")[i].getInt("X");
      int Y=MAPs.getChild("\u8349\u539f").getChildren("EVENT")[i].getInt("Y");
      int speed=Integer.parseInt(MAPs.getChild("\u8349\u539f").getChildren("EVENT")[i].getChild("SPEED").getContent());
      String gazou=MAPs.getChild("\u8349\u539f").getChildren("EVENT")[i].getChild("GAZOU").getContent();
      Events addedEvent =new Events(X,Y,speed,walkType,gazou,i,MAP_CHIP_SIZE);
      events.add(addedEvent);
      addedEvent.DBid=i;
    }
  }
  
  //\u30a4\u30d9\u30f3\u30c8\u3092\u52d5\u304b\u3057\u307e\u3059
  public void update(){
    if(events.size()!=0){
      for (int i = 0 ; i < events.size() ; i++){
        events.get(i).update();
      }
    }
  }
  //\u63cf\u753b\u3057\u307e\u3059
  public void draw(){
    image(map,0,0);
    for (int i = 0 ; i < events.size() ; i++){
      events.get(i).draw();
    }
  }
  
  private int hash(int X,int Y){
   if(X>0 && X<world.mapsizeX+1 && Y>0 && Y<world.mapsizeY+1)
     return hash.pixels[(Y-1)*hash.width+(X-1)];
   else return color(0);
  }
  public boolean here(int X,int Y,String option){
    //\u969c\u5bb3\u7269\u306e\u5224\u5b9a\u3092\u884c\u3044\u307e\u3059
    if(option=="map")return (hash(X,Y)== color(0));
    
    //\u30a4\u30d9\u30f3\u30c8\u306e\u5f53\u305f\u308a\u5224\u5b9a\u3092\u884c\u3044\u307e\u3059
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
  
  public Events eventSearch(int X,int Y){
    for (int i = 0 ; i < events.size() ; i++) {
      if(events.get(i).here(X,Y))return events.get(i);
    }return null;
  }
}
//player\u3092\u4f5c\u308b\u305f\u3081\u306e\u30af\u30e9\u30b9\u3067\u3059\u3002
class Player{
  Events player;
  Player(int MAP_CHIP_SIZE){
  }
}
//\u4e00\u756a\u5927\u307e\u304b\u306a\u6240\u3092\u6271\u3063\u3066\u3044\u308b\u30af\u30e9\u30b9\u3067\u3059\u3002SETUP\u3084DRAW\u3092\u547c\u3093\u3067\u307e\u3059\u3002

class World{
  int mapsizeX=30;
  int mapsizeY=30;
  int MAP_CHIP_SIZE = 16;
  boolean canMove;
  int time;
  
  Key key;
  Maps maps;
  Player player;
  DB db;
  Config config;
  TalkCommand tc;
  
  World(){
    key=new Key();
    maps=new Maps();
    db =new DB();
    config=new Config();
    tc =new TalkCommand();
    player=new Player(MAP_CHIP_SIZE);
    
    canMove=true;
  }
  
  public void draw(){
    time++;
    if(time==1)maps.addEVENT(world.MAP_CHIP_SIZE);
    maps.draw();
    tc.draw();
    config.debug();
    if(canMove==true)maps.update();
  }
  public void stop(){
    canMove=false;
  }
}
  public void settings() {  size(480, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
