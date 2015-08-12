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
  Events playerEvent=player.player;
  Command(){
    MessageBox=loadImage("MessageBox.png");
  }
  
  void doCommand(Events performer,int DBid,String option){
    XML xml;
    if(option=="parallel")xml=MAPs.getChild("草原").getChildren("EVENT")[DBid].getChild("parallel");
    if(option=="enter")xml=MAPs.getChild("草原").getChildren("EVENT")[DBid].getChild("enter");
  }
  //接触イベントを呼び出します
  void conntactEvent(Events performer){
    //if(object==playerEvent)doCommand(performer,performer.DBid,"playerEvent");
  }
  //並列イベントとエンターイベントを呼び出します
  void parallelEvent(Events performer,int DBid){
    doCommand(performer,DBid,"parallel");
    if(!key.enter)return;
    switch(performer.direction){
      case UP:if(playerEvent.aboutX==performer.aboutX && playerEvent.aboutY==performer.aboutY-1){doCommand(performer,DBid,"enter");break;}
      case DOWN:if(playerEvent.aboutX==performer.aboutX && playerEvent.aboutY==performer.aboutY-1){doCommand(performer,DBid,"enter");break;}
      case LEFT:if(playerEvent.aboutX==performer.aboutX && playerEvent.aboutY==performer.aboutY-1){doCommand(performer,DBid,"enter");break;}
      case RIGHT:if(playerEvent.aboutX==performer.aboutX && playerEvent.aboutY==performer.aboutY-1){doCommand(performer,DBid,"enter");break;}
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
    while(key.enter){
      image(MessageBox,0,height*3/4,width, height*1/4);
      text(TalkingContents,0+50,height*3/4+50);
    }
  }
}
