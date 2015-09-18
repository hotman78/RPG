/*------------------------------------------------
クラスおよび重要なパブリック関数一覧
world: すべてのクラスを管理するクラスです。
  -commonEvent:コモンイベントです。
    -doCommand():コマンドを実行します
    -startComannd():コマンドを実行待機状態にさせます
  -maps: マップを設定します。今のところ1面しかないです
    -events: NPCが要素として格納されているLISTです。
      -move():1マス移動させます
      -command:コマンドの管理をするLISTです。
          -doCommand():コマンドを実行します
          -startComannd():コマンドを実行待機状態にさせます
  -key      :keyを設定します
  -DB       :DBを管理します。

起動条件一覧
マップイベントのみ
  enter:エンターを押した際に実行
  playerConntact:イベントにプレイヤーがぶつかった時実行(プレイヤー移動時)
  eventConntact:プレイヤーにイベントがぶつかった時実行(イベント移動時)
コモンイベントのみ
parallel:並列的に毎フレーム実行。なお並列実行(常時)は明示的に他の条件がないことを表す。
automic:自動的に毎フレーム実行。実行中は他のイベントは実行されない。(未実装)
called:呼びだされた時実行。
変数・定数一覧
world.canMove:プレイヤーが動けるかどうか
world.doingAutomicCommand:自動実行イベントが実行中かどうか
world.MAP_CHIP_SIZE;マップチップのサイズです。
world.mapSizeX,Y:マップのサイズです
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