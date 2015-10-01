//サウンドを流せるようにします
import ddf.minim.*;
Minim minim= new Minim(this);  //初期化 

class Command{
  XML Maps = loadXML("Basicdata/Maps.xml");
  XML xml=null;
  boolean isExecuting=false;
  boolean canStartCommand=true;
  int commandID=0;
  int pageNumber;
  String trigger;
  MapEvent performer;
  MapEvent playerEvent;
  ArrayList <BaseCommand> commands;
  
  Command(MapEvent t_performer,int t_pageNumber){
    commands=new ArrayList <BaseCommand>(10);
    
    performer=t_performer;
    pageNumber=t_pageNumber;
    
    commands.add(new Sound());
    commands.add(new Warp());
    commands.add(new Wait());
    for(int i=0;i<commands.size();i++){
      commands.get(i).getParent(this);
    }
  }
  
  void startCommand(String trigger){
    if(!trigger.equals(this.trigger))return;
    if("automic".equals(this.trigger))world.canMove=false;
    commandID=0;
    isExecuting=true;
    doCommand();
  }
  
  void doCommand(){
    if(commandID==xml.listChildren().length-1){
      world.canMove=true;
      commandID=0;
      isExecuting=false;
    }
    
    if(!isExecuting)return;
    
    int id=xml.getChildren()[commandID].getInt("id",-1);
    if(id==-1){
      commandID++;
      doCommand();
      return;
    }
    commands.get(id).doCommand(xml.getChildren()[commandID]);
  }
  
  void parallelEvent(){
    if(!world.canMove)return;
    startCommand("parallel");
  }
  
  void automicEvent(){
    if(!world.canMove)return;
    startCommand("automic");
  }
  
  //変数をフラグから読み込みます
  private int flagRead(String key,MapEvent performer){
    return performer.flag.get(key);
  }
  
  //変数をフラグに書き込みます
  private void flagWhite(String key,int value,MapEvent performer,String option){
    if(option=="==")performer.flag.put(key,value);
    if(option=="+=")performer.flag.put(key,performer.flag.get(key)+value);
    if(option=="-=")performer.flag.put(key,performer.flag.get(key)-value);
  }
}
class MapEventCommand extends Command{
  MapEventCommand(MapEvent performer,int pageNumber){
    super(performer,pageNumber);
    xml=Maps.getChild("map").getChildren("EVENT")[performer.DBid].getChildren("page")[pageNumber];
    trigger=xml.getString("Trigger");
  }
  //接触イベントを呼び出します
  void conntactEvent(Direction muki){
    if(!world.canMove)return;
    MapEvent object=world.maps.eventSearch(performer.aboutToX()+muki.dx(),performer.aboutToY()+muki.dy());
    if(object==null || performer==object)return;
    playerEvent=world.maps.player;
    if(performer==playerEvent)startCommand("playerConntact");
    if(object==playerEvent)startCommand("eventConntact");
  }
  //エンターイベントを呼び出します
  void enterEvent(){
    if(!world.canMove)return;
    playerEvent=world.maps.player;
    if(performer.aboutX()==playerEvent.aboutX()+playerEvent.direction.dx()
    && performer.aboutY()==playerEvent.aboutY()+playerEvent.direction.dy()){startCommand("enter");}
  }  
}

class CommonEventCommand extends Command{
  XML EventXML = loadXML("Basicdata/Common.xml");
  CommonEventCommand(MapEvent performer,int pageNumber){
    super(performer,pageNumber);
    xml=EventXML.getChildren("Event")[pageNumber];
    trigger=xml.getString("Trigger");
  }
  void parallelEvent(){
    super.parallelEvent();
  }
  void calledEvent(){
    startCommand("called");
  }
}

class   BaseCommand{
  Command parent;
  void doCommand(XML data){}
  void getParent(Command parent){
    this.parent=parent;
  }
  void nextCommand(){
    parent.commandID++;
    parent.doCommand();    
  }
}
class CallCommonEvent extends BaseCommand{
  void doCommand(){
    //maps.common[i].calledEvent(this);
  }
  void stopCommand(){
    nextCommand();
  }
}

class Wait extends BaseCommand{
  int time=0;
  void doCommand(XML data){
    time++;
    if(time==Integer.parseInt(data.getContent())){
      time=0;
      nextCommand();
    }
  }  
}
class Image extends BaseCommand{
  ArrayList <ImageData>imageList;
  PImage image;
  
  Image(){
    imageList = new ArrayList<ImageData>(10);
  }
  
  void setImage(String path,int x,int y){
    imageList.add(new ImageData(path, x, y));
  }
  
  void draw(){
    for(int i=0;i<imageList.size();i++)
    image(imageList.get(i).image
    ,imageList.get(i).x
    ,imageList.get(i).y);
  }
  
  class ImageData{
    PImage image;int x,y;
    ImageData(String path,int x,int y){
      this.x=x;
      this.y=y;
      image =loadImage(path);
    }
  } 
}

class Sound extends BaseCommand{
  AudioPlayer player;
  int x=0;
  @Override
  void doCommand(XML data){
    if("stop".equals(data.getContent())){stop();return;}
    try {
      player = minim.loadFile("BGM/"+data.getContent()); //mp3ファイルを指定する 
      player.play();  //再生
      player.rewind();
    }catch (NullPointerException e) {
      println("ファイルを読み込めませんでした");
    }
    nextCommand();
  }
  void stop(){
    player.close();  //サウンドデータを終了
    minim.stop();
    nextCommand();
  }
}

class Warp extends BaseCommand{
  void doCommand(XML data){
    int mapId=int(data.getContent());
    int x=data.getInt("x");
    int y=data.getInt("y");
    world.maps.loadMap(x,y,mapId);
    nextCommand();
  }
}
class DBGet extends BaseCommand{
  void doCommand(XML data){
    DB db =new DB();
  }  
}