  //サウンドを流せるようにします
  import ddf.minim.*;
  
class Command{
  PImage MessageBox;
  String TalkingContents="null";  //要素ごとにひとつの話す内容をもたせます
  Minim minim;
  AudioPlayer audioPlayer;
  XML UDB = loadXML("UDB.xml");
  XML CDB = loadXML("CDB.xml");
  XML SDB = loadXML("SDB.xml");
  XML MAPs = loadXML("MAPs.xml");
  boolean disp=false;
  String dispContents="";
  Events playerEvent=player.player;
  Command(){
    MessageBox=loadImage("MessageBox.png");
  }
  
  void doCommand(Events performer,String option){
    XML xml=null;
    if(option=="parallel")xml=MAPs.getChild("草原").getChildren("EVENT")[performer.DBid].getChild("parallel");
    if(option=="enter")xml=MAPs.getChild("草原").getChildren("EVENT")[performer.DBid].getChild("enter");
    if(option=="playerConntact")xml=MAPs.getChild("草原").getChildren("EVENT")[performer.DBid].getChild("playerConntact");
    for(int i=0;i<xml.getChildren().length;i++){
    if(xml.listChildren()[i]=="messageWindow"){messageWindow(xml.getChildren()[i].getContent());}
    }
  }
  //接触イベントを呼び出します
  void conntactEvent(Events performer,Events object){
    if(object==playerEvent)doCommand(performer,"playerConntact");
  }
  //並列イベントとエンターイベントを呼び出します
  void parallelEvent(Events performer){
    doCommand(performer,"parallel");
  }
  void enterEvent(){
    Events performer;
    switch(playerEvent.direction){
      case UP:
      performer=maps.eventSearch(playerEvent.aboutX(),playerEvent.aboutY()-1);
      if(performer!=null)doCommand(performer,"enter");break;
      case DOWN:
      performer=maps.eventSearch(playerEvent.aboutX(),playerEvent.aboutY()+1);
      if(performer!=null)doCommand(performer,"enter");break;
      case LEFT:
      performer=maps.eventSearch(playerEvent.aboutX()-1,playerEvent.aboutY());
      if(performer!=null)doCommand(performer,"enter");break;
      case RIGHT:
      performer=maps.eventSearch(playerEvent.aboutX()+1,playerEvent.aboutY());
      if(performer!=null)doCommand(performer,"enter");break;
    }
  }
  void sound(){
    minim = new Minim(this);  //初期化
    audioPlayer = minim.loadFile("bgm.mp3");  //groove.mp3をロードする
    audioPlayer.play();
  }
  //サウンド終了の関数です
  void stop(){
    audioPlayer.close();  //サウンドデータを終了
    minim.stop();
    //super.stop();
  }
   //変数をDBから読み込みます
  String DBread(String DBname,int indexElements,int indexElement){
    XML DB=null;
    if(DBname=="UDB")DB=UDB;
    if(DBname=="CDB")DB=UDB;
    if(DBname=="SDB")DB=SDB;
    XML[] elements = DB.getChildren("elements");
    XML[] items = elements[indexElements].getChildren("element");
    return items[indexElement].getString("data");
  }
  //変数をDBに書き出します(数値の場合)
  void DBwrite(String DBname,int indexElements,int indexElement,int written,String option){
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
  void DBwrite(String DBname,int indexElements,int indexElement,String written){
    XML DB=null;
    if(DBname=="UDB")DB=UDB;
    if(DBname=="CDB")DB=UDB;
    if(DBname=="SDB")DB=SDB;
    XML item = DB.getChildren("elements")[indexElements].getChildren("element")[indexElement];
    item.setString("data",written);
  }  
  //変数をフラグから読み込みます
  int flagRead(String key,Events performer){
    return performer.flag.get(key);
  }
  //変数をフラグに書き込みます
  void flagWhite(String key,int value,Events performer,String option){
    if(option=="==")performer.flag.put(key,value);
    if(option=="+=")performer.flag.put(key,performer.flag.get(key)+value);
    if(option=="-=")performer.flag.put(key,performer.flag.get(key)-value);
  }
  
  
  //コモンイベントを読み込み、実行します
  void commonEvent(){
    
  }
  //メッセージウィンドウを表示します
  void messageWindow(String TalkingContents){
    disp=!disp;
    dispContents=TalkingContents;
    
  }
  void dispWindow(){
    if(!disp)return;
    image(MessageBox,0,height*3/4,width, height*1/4);
    text(dispContents,0+50,height*3/4+50);    
  }
}
