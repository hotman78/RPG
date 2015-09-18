//サウンドを流せるようにします
import ddf.minim.*;
Minim minim= new Minim(this);  //初期化 

class Command{
  String TalkingContents="null";  //要素ごとにひとつの話す内容をもたせます
  AudioPlayer player;
  
  XML UDB = loadXML("UDB.xml");
  XML CDB = loadXML("CDB.xml");
  XML SDB = loadXML("SDB.xml");
  XML MAPs = loadXML("MAPs.xml");
  XML xml=null;
  boolean isExecuting=false;
  boolean canStartCommand=true;
  int commandID;
  int pageNumber;
  String trigger;
  Events performer;
  Events playerEvent;
  
  Command(Events t_performer,int t_pageNumber){
    performer=t_performer;
    pageNumber=t_pageNumber;
    xml=MAPs.getChild("map").getChildren("EVENT")[performer.DBid].getChildren("page")[pageNumber];
    trigger=xml.getString("Trigger");
  }
  
  void startCommand(String option){
    if(!trigger.equals(option))return;
    commandID=0;
    isExecuting=true;
  }
  
  void doCommand(){
    if(!isExecuting)return;
    if("messageWindow".equals(xml.listChildren()[commandID]) && !world.tc.inConversation){world.tc.startConversation(xml.getChildren()[commandID].getContent());}
    if("sound".equals(xml.listChildren()[commandID])){sound(xml.getChildren()[commandID].getContent());}
    if("warp".equals(xml.listChildren()[commandID])){warp(xml.getChildren()[commandID].getInt("x"),xml.getChildren()[commandID].getInt("y"),xml.getChildren()[commandID].getInt("mapId"));}
    else if(commandID==xml.listChildren().length-1){commandID=0;isExecuting=false;}
    else {commandID++;doCommand();}
  }
  //接触イベントを呼び出します
  void conntactEvent(Direction muki){
    Events object=world.maps.eventSearch(performer.aboutToX()+muki.dx(),performer.aboutToY()+muki.dy());
    if(object==null || performer==object)return;
    playerEvent=world.maps.player;
    if(performer==playerEvent)startCommand("playerConntact");
    if(object==playerEvent)startCommand("eventConntact");
  }
  
  void enterEvent(){
    playerEvent=world.maps.player;
    if(performer.aboutX()==playerEvent.aboutX()+playerEvent.direction.dx()
    && performer.aboutY()==playerEvent.aboutY()+playerEvent.direction.dy()){startCommand("enter");}
  }
  
  void warp(int x,int y,int mapId){
    world.maps.loadMap(x,y,mapId);
  }
  
  void sound(String URL){
    if("stop".equals(URL)){stop();return;}
    player = minim.loadFile(URL); //mp3ファイルを指定する 
    player.play();  //再生
    player.rewind();
    commandID++;
    doCommand();
  }
  
  void stop(){
    player.close();  //サウンドデータを終了
    minim.stop();
    //super.stop();
    commandID++;
    doCommand();
  }

   //変数をDBから読み込みます
  private String DBread(String DBname,int indexElements,int indexElement){
    XML DB=null;
    if("UDB".equals(DBname))DB=UDB;
    if("CDB".equals(DBname))DB=UDB;
    if("SDB".equals(DBname))DB=SDB;
    XML[] elements = DB.getChildren("elements");
    XML[] items = elements[indexElements].getChildren("element");
    return items[indexElement].getString("data");
  }
  //変数をDBに書き出します(数値の場合)
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
  //変数をDBに書き出します(文字列の場合)
  private void DBwrite(String DBname,int indexElements,int indexElement,String written){
    XML DB=null;
    if(DBname=="UDB")DB=UDB;
    if(DBname=="CDB")DB=UDB;
    if(DBname=="SDB")DB=SDB;
    XML item = DB.getChildren("elements")[indexElements].getChildren("element")[indexElement];
    item.setString("data",written);
  }  
  
  //変数をフラグから読み込みます
  private int flagRead(String key,Events performer){
    return performer.flag.get(key);
  }
  
  //変数をフラグに書き込みます
  private void flagWhite(String key,int value,Events performer,String option){
    if(option=="==")performer.flag.put(key,value);
    if(option=="+=")performer.flag.put(key,performer.flag.get(key)+value);
    if(option=="-=")performer.flag.put(key,performer.flag.get(key)-value);
  }
  
  //コモンイベントを読み込み、実行します
  void commonEvent(){
    
  }
  
  //メッセージウィンドウを表示します
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
  
  void startConversation(String tDispContents){
    dispContents=tDispContents;
    inConversation=true;
  }
  void stopConversation(){
    dispContents="";
    inConversation=false;
  }
  void draw(){
    if(!inConversation)return;
    image(MessageBox,0,height*3/4,width, height*1/4);
    text(dispContents,0+50,height*3/4+50);    
  }
}