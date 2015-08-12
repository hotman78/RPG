class Event{
  //NPCの情報を返します
}

class Events extends Character{
  //EVENTが要素として格納されているLISTです。
  
  //設定です。親クラスではお約束文をまとめてます。
  void set(int X,int Y,int speed,WALK move_option,String imgage_name){
    load_image(imgage_name);
    speed(speed);
    set_position(X,Y);
    move_option(move_option);
    super.set();
  }
}
