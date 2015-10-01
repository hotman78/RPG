class DB{
  /*--------------------------------------------
  UDB(ユーザーデータベース):ユーザーが
  CDB(可変データベース)   :
  SDB(システムデータベース):
  --------------------------------------------*/
    XML UDB = loadXML("Basicdata/DataBase.xml").getChild("UDB");
    XML CDB = loadXML("Basicdata/DataBase.xml").getChild("CDB");
    XML SDB = loadXML("Basicdata/DataBase.xml").getChild("SDB");
    XML DB=null;
   //変数をDBから読み込みます
  String get(String DBname,int type,int data,int item){
    if("UDB".equals(DBname))DB=UDB;
    if("CDB".equals(DBname))DB=CDB;
    if("SDB".equals(DBname))DB=SDB;
    return DB.getChildren("type")[type]
             .getChildren("data")[data]
             .getChildren("item")[item]
             .getContent();
             
  }
  
  void set(String DBname,int type,int data,int item ,String kind, String content){
    if("UDB".equals(DBname))DB=UDB;
    if("CDB".equals(DBname))DB=CDB;
    if("SDB".equals(DBname))DB=SDB;
    XML DBplace= DB.getChildren("type")[type]
                      .getChildren("data")[data]
                      .getChildren("item")[item];
    if("String".equals(kind))DBplace.setContent(content);
  }
}