/*------------------------------------------------
クラスおよび重要なパブリック関数一覧
world: すべてのクラスを管理するクラスです。
  -commonEvent:コモンイベントです。
    -doCommand():コマンドを実行します
    -startComannd():コマンドを実行待機状態にさせます
  -maps: マップを設定します。今のところ1面しかないです
    -events: NPCが要素として格納されているLISTです。
      -move():1マス移動させます
      -command:コマンドの実行をします。
          -doCommand():コマンドを実行します
          -startComannd():コマンドを実行待機状態にさせます
  -key      :keyを設定します
  -DB       :DBを管理します。

起動条件一覧
enter:エンターを押した際に実行
playerConntact:イベントにプレイヤーがぶつかった時実行(プレイヤー移動時)
eventConntact:プレイヤーにイベントがぶつかった時実行(イベント移動時)
parallel:並列的に毎フレーム実行
automic:自動的に毎フレーム実行。実行中は他のイベントは実行されない。(未実装)

変数・定数一覧

--------------------------------------------------*/

World world;

void setup(){
  size(480, 480);
  world=new World();
}

void draw(){
  world.draw();
}

void keyPressed(){
  world.key.keyPressed();
}

void keyReleased(){
  world.key.keyReleased();
}