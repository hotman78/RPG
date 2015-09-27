class TalkCommand{
  PImage MessageBox;
  String dispContents="";
  boolean inConversation;
  
  TalkCommand(){
    MessageBox=loadImage("picture/MessageBox.png");
    inConversation=false;
  }
  
  void startConversation(String tDispContents){
    dispContents=tDispContents;
    inConversation=true;
  }
  void stopConversation(){
    dispContents="";
    inConversation=false;
  }
  void draw(){
    if(!inConversation)return;
    image(MessageBox,0,height*3/4,width, height*1/4);
    text(dispContents,0+50,height*3/4+50);    
  }
}