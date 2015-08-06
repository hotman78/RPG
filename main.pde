/*------------------------------------------------
World    :一番大まかな所を扱っているクラスです。各クラスのSETUPやDRAWやUPDATEを呼んでます。
Character:すべてのキャラクターの親クラスです。
Player   :プレイヤーの追加・制御を行います
NPC      :NPCを追加し、NPCの情報を返します
NPCs     :NPCが要素として格納されているLISTです。
Map      :マップを設定させます。今のところ1面しかないです
Key      :新しいkey使いたくなったらこちらです
DB       :DBを保存します。
Gui      :未実装です
--------------------------------------------------*/


Key key;
World world;
Maps maps;
Player player;
NPC npc;
DB db;
ArrayList<NPCs> npcs;
Config config;
void setup(){
  size(480, 480);
  key=new Key();
  world=new World();
  maps=new Maps();
  player=new Player();
  npc=new NPC();
  db =new DB();
  npcs = new ArrayList<NPCs>();
  config=new Config();
}

void draw(){
  world.draw();
}

void keyPressed(){
  key.keyPressed();
}

void keyReleased(){
  key.keyReleased();
}
