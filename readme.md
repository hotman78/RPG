<h2>クラスおよび重要なパブリック関数一覧</h2>
<pre>
world: すべてのクラスを管理するクラスです。
  -maps: マップを設定します。今のところ1面しかないです
    -MapEvent: NPCが要素として格納されているLISTです。
      -move():1マス移動させます
      -MapEventCommand:コマンドの管理をするLISTです。
          -doCommand():コマンドを実行します
          -startComannd():コマンドを実行待機状態にさせます
    -commonEventCommand:コモンイベントです。
      -doCommand():コマンドを実行します
      -startComannd():コマンドを実行待機状態にさせます
  -key      :keyを設定します
  -DB       :DBを管理します。
</pre>
<br>
<h2>起動条件一覧</h2>
<pre>
マップイベントコモンイベント双方
  parallel:並列的に毎フレーム実行。なお並列実行(常時)は明示的に他の条件がないことを表す。
  automic:自動的に毎フレーム実行。実行中は他のイベントは実行されない。	
マップイベントのみ
  enter:エンターを押した際に実行
  playerConntact:イベントにプレイヤーがぶつかった時実行(プレイヤー移動時)
  eventConntact:プレイヤーにイベントがぶつかった時実行(イベント移動時)
コモンイベントのみ
  called:呼びだされた時実行。
</pre>
<br>
<h2>変数・定数一覧<h2>
<pre>
  world.canMove:プレイヤーが動けるかどうか、新しくコマンドを呼び出せるかどうか
  world.MAP_CHIP_SIZE;マップチップのサイズです。
  world.mapSizeX,Y:マップのサイズです
</pre>