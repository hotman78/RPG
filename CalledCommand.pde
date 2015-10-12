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
  HashMap<String,BaseCommand> map;
  MapEvent performer;
  MapEvent player;
  
  Command(MapEvent performer,int pageNumber){
    map = new HashMap<String,BaseCommand>();
    this.performer=performer;
    this.pageNumber=pageNumber;
    
    addCommand("Talk",new Talk());
    addCommand("Sound",new Sound());
    addCommand("Warp",new Warp());
    addCommand("Wait",new Wait());
    addCommand("Image",new ImageCommand());
  }
  
  void addCommand(String code,BaseCommand obj){
    map.put(code,obj);
    obj.getParent(this);
  }
  
  void startCommand(String trigger){
    if(!trigger.equals(this.trigger))return;
    commandID=0;
    isExecuting=true;
    update();
  }
  
  BaseCommand getCommand(){
    //コマンドをすべて実行し終わったら時
    if(commandID==xml.listChildren().length-1){
      commandID=0;
      isExecuting=false;
    }
    
    if(!isExecuting)return null;
    if(map.get(xml.getChildren()[commandID].getName())==null){
      commandID++;
      return getCommand();
    }else return map.get(xml.getChildren()[commandID].getName());
  }
  
  void update(){
    BaseCommand command =getCommand();
    if(command==null)return;
    command.update(xml.getChildren()[commandID]);
  }
  
  void keyPressed(){
    BaseCommand command =getCommand();
    if(command==null)return;
    command.keyPressed();
  }
  
  void keyTyped(){
    BaseCommand command =getCommand();
    if(command==null)return;
    command.keyTyped();
  }
  
  void keyReleased(){
    BaseCommand command =getCommand();
    if(command==null)return;
    command.keyReleased();
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
  void conntactEvent(Direction picDirection){
    if(!world.canMove)return;
    MapEvent object=world.maps.eventSearch(performer.aboutToX()+picDirection.dx(),performer.aboutToY()+picDirection.dy());
    if(object==null || performer==object)return;
    player=world.maps.player;
    if(performer==player)startCommand("playerConntact");
    if(object==player)startCommand("eventConntact");
  }
  
  //エンターイベントを呼び出します
  void enterEvent(){
    if(!world.canMove)return;
    player=world.maps.player;
    if(performer.aboutX()==player.aboutX()+player.direction.dx()
    && performer.aboutY()==player.aboutY()+player.direction.dy()){startCommand("enter");}
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

class CallCommonEvent extends BaseCommand{
  void doCommand(){
  }
  void stopCommand(){
    nextCommand();
  }
}