class DB{
  /*--------------------------------------------
  UDB(ユーザーデータベース):ユーザーが
  CDB(可変データベース)   :
  SDB(システムデータベース):
  --------------------------------------------*/
  HashMap<String,HashMap<String,String>> UDB = new HashMap<String,HashMap<String,String>>();
  HashMap<String,HashMap<String,String>> CDB = new HashMap<String,HashMap<String,String>>();
  HashMap<String,HashMap<String,String>> SDB = new HashMap<String,HashMap<String,String>>();
  DB(){
    loadData();
  }
  void loadData(){
/*    XML UDB = loadXML("UDB.xml");
     XML[] elements = UDB.getChildren("elements");
     XML[] items = elements[0].getChildren("element");
     */
  }
}
