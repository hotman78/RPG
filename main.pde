World world;

void setup(){
  size(480, 480);
  background(0);
  //surface.setResizable(true);
  world=new World();
}

void draw(){
  world.draw();
}

void keyPressed(){
  world.input.keyPressed();
}

void keyReleased(){
  world.input.keyReleased();
}