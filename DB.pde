class DB{
  /*--------------------------------------------
  UDB(ユーザーデータベース):ユーザーが
  CDB(可変データベース)   :
  SDB(システムデータベース):
  --------------------------------------------*/
  //HashMap<String,HashMap<String,String>> UDB = new HashMap<String,HashMap<String,String>>();
  //HashMap<String,HashMap<String,String>> CDB = new HashMap<String,HashMap<String,String>>();
  //HashMap<String,HashMap<String,String>> SDB = new HashMap<String,HashMap<String,String>>();
  DB(){
    loadData();
  }
  void loadData(){
  }
}

class DBload{
   //変数をDBから読み込みます
 /* void doCommand(XML data){
    String DBname=data.getInt("DBname");
    int indexElements=data.getInt("elements");
    int indexElement=data.getInt("element");
    XML DB=null;
    XML UDB = loadXML("Basicdata/DataBase.xml").getChild("UDB");
    XML CDB = loadXML("Basicdata/DataBase.xml").getChild("CDB");
    XML SDB = loadXML("Basicdata/DataBase.xml").getChild("SDB");
    XML[] elements = DB.getChildren("elements");
    XML[] items = elements[indexElements].getChildren("element");
    //items[indexElement].getString("data");
  }*/
}
class DBWhite{
  //変数をDBに書き出します
/*  void doCommand(XML data){
    String written=data.getContent();
    String DBname=data.getString("DBname");
    String option=data.getString("option");
    int indexElements=data.getInt("elements");
    int indexElement=data.getInt("element");
    XML DB=null;
    XML UDB = loadXML("Basicdata/DataBase.xml").getChild("UDB");
    XML CDB = loadXML("Basicdata/DataBase.xml").getChild("CDB");
    XML SDB = loadXML("Basicdata/DataBase.xml").getChild("SDB");
    if(DBname=="UDB")DB=UDB;
    if(DBname=="CDB")DB=UDB;
    if(DBname=="SDB")DB=SDB;
    XML item = DB.getChildren("elements")[indexElements].getChildren("element")[indexElement];
    if(option=="==")item.setInt("data",written);
    if(option=="+=")item.setInt("data",item.getInt("data")+written);
    if(option=="-=")item.setInt("data",item.getInt("data")-written);
    if(option=="String")item.setString("data",written);
    nextCommand();
  }*/
}