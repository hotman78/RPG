class BaseCommand{
  Command parent;
  
  void update(XML data){};
  void keyPressed(){}
  void keyTyped(){}
  void keyReleased(){}
  
  void getParent(Command parent){
    this.parent=parent;
  }
  
  void nextCommand(){
    parent.commandID++;
    parent.update();
  }
}
class For extends BaseCommand{
  //Command command = new MapEventCommand(this,this);
  void update(XML data){
    
  }
  void forC(int count){
    int count=0;
  }
}
class Wait extends BaseCommand{
  int time=0;
  void update(XML data){
    time++;
    if(time==Integer.parseInt(data.getContent())){
      time=0;
      nextCommand();
    }
  }  
}

class Talk extends BaseCommand{
  int time=0;
  
  void update(XML data){
    String text=data.getContent();
    if(time==0)start(text);
    time++;
  }
  
  void keyTyped(){
    if(keyCode==ENTER)stop();
  }
  
  void start(String text){
    world.stop();
    world.image.setImage("Picture/MessageBox.png",5,height-120,0.6,1);
    world.image.setText(text,50,height-60,20,2);
  }
  
  void stop(){
    time=0;
    world.canMove=true;
    world.input.typed=true;
    world.image.remove(1);
    world.image.remove(2);
    nextCommand();
  }
}

class ImageCommand extends BaseCommand{
  int x=0,y=0,id=0;
  String path="";
  void update(XML data){
    x=data.getInt("x");
    y=data.getInt("y");
    id=data.getInt("id");
    path=data.getContent();
    world.image.setImage(path,x,y,1,id);
    nextCommand();
  }
}

class Image{
  HashMap<Integer,ImageData> imageID;
  PImage image;
  ImageData data;
  Image(){
    imageID = new HashMap<Integer,ImageData>();
  }
  
  void remove(int id){
    imageID.remove(id);
  }
  
  void clear(){
    imageID.clear();
  }
  
  void setImage(String path,int x,int y,float zoom,int id){
    int width=round(loadImage(path).width*zoom);
    int height=round(loadImage(path).height*zoom);
    data=new ImageData(loadImage(path), x, y,width,height);
    imageID.put(id,data);
  }
  
  void setText(String text,int x,int y,int size,int id){
    PGraphics pg =createGraphics(text.length()*size,size*2);
    pg.beginDraw();
    pg.textSize(size);
    pg.text(text,0,size);
    pg.endDraw();
    PImage image=pg.get();
    data=new ImageData(image, x, y,image.width,image.height);
    imageID.put(id,data);
  }
  
  void draw(){
    for(Integer
    key : imageID.keySet()){
      ImageData data=imageID.get(key);
      image(data.image
      ,data.x
      ,data.y
      ,data.width
      ,data.height);
    }
  }
  
  class ImageData{
    PImage image;
    int x,y,width,height;
    ImageData(PImage image,int x,int y,int width,int height){
      this.image=image;
      this.x=x;
      this.y=y;
      this.width=width;
      this.height=height;
    }
  }
}

class Sound extends BaseCommand{
  AudioPlayer player;
  int x=0;
  void update(XML data){
    if("stop".equals(data.getContent())){stop();return;}
    try{player.close();}catch(NullPointerException e){}
    try {
      player = minim.loadFile("BGM/"+data.getContent()); //mp3ファイルを指定する
      player.play();  //再生
      player.rewind();
    }catch (NullPointerException e) {
      println("ファイルを読み込めませんでした");
    }
    nextCommand();
  }
  void stop(){
    player.close();  //サウンドデータを終了
    minim.stop();
    nextCommand();
  }
}

class Warp extends BaseCommand{
  void update(XML data){
    int map=data.getInt("map");
    println(map);
    int x=data.getInt("x");
    int y=data.getInt("y");
    world.maps.loadMap(x,y,map);
    nextCommand();
  }
}

class DBGet extends BaseCommand{
  void update(XML data){
    DB db =new DB();
  }
}