クラスおよび重要なパブリック関数一覧<br>
world: すべてのクラスを管理するクラスです。<br>
  -maps: マップを設定します。今のところ1面しかないです<br>
    -MapEvent: NPCが要素として格納されているLISTです。<br>
      -move():1マス移動させます<br>
      -command:コマンドの管理をするLISTです。<br>
          -doCommand():コマンドを実行します<br>
          -startComannd():コマンドを実行待機状態にさせます<br>
    -commonEvent:コモンイベントです。<br>
      -doCommand():コマンドを実行します<br>
      -startComannd():コマンドを実行待機状態にさせます<br>
  -key      :keyを設定します<br>
  -DB       :DBを管理します。<br>
<br>
起動条件一覧<br>
マップイベントのみ<br>
  enter:エンターを押した際に実行<br>
  playerConntact:イベントにプレイヤーがぶつかった時実行(プレイヤー移動時)<br>
  eventConntact:プレイヤーにイベントがぶつかった時実行(イベント移動時)<br>
コモンイベントのみ<br>
parallel:並列的に毎フレーム実行。なお並列実行(常時)は明示的に他の条件がないことを表す。<br>
automic:自動的に毎フレーム実行。実行中は他のイベントは実行されない。<br>
called:呼びだされた時実行。<br>
変数・定数一覧<br>
world.canMove:プレイヤーが動けるかどうか、新しくコマンドを呼び出せるかどうか<br>
world.doingAutomicCommand:自動実行イベントが実行中かどうか<br>
world.MAP_CHIP_SIZE;マップチップのサイズです。<br>
world.mapSizeX,Y:マップのサイズです