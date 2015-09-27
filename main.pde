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