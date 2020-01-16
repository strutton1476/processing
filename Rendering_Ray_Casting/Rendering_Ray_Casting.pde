Ray ray;
Particle p;

float sceneW = 400;
int wallCount = 4;
int amt = 5+wallCount;
int range = 46;

Boundary[] walls = new Boundary[amt];
float[] scene = new float[range];

void setup() {
  if(range%2 !=0)
    range++;
  size(800, 400); 
  for (int i=0; i<amt-wallCount; i++) {
    PVector p1 = new PVector(random(sceneW), random(height));
    PVector p2 = new PVector(random(sceneW), random(height));
    walls[i] = new Boundary(p1.x, p1.y, p2.x, p2.y);
  }
  if(wallCount == 4){
    walls[5] = new Boundary(sceneW, 0, sceneW, height);
    walls[6] = new Boundary(0, 0, sceneW, 0);
    walls[7] = new Boundary(0, 0, 0, height);
    walls[8] = new Boundary(0, height, sceneW, height);
  }
  p = new Particle();
}
void draw() {
  background(0);
  for (int i=0; i<amt; i++) {
    walls[i].show();
  }
  
  float w = sceneW/scene.length;
  push();
  for(int i=0; i<scene.length; i++){
    float sq = scene[i]*scene[i];
    float wSq = sceneW * sceneW;
    float b = map(sq, 0, wSq, 255, 0);
    float h = map(scene[i], 0, sceneW, height, 0);
    
    fill(b);
    //rect(i*w + sceneW, 0, w, height);
    noStroke();
    rectMode(CENTER);
    rect(i*w+sceneW+5, height/2, w+1, h);
  }
  pop();
  
  p.update();
  p.show();
  scene = p.look(walls);

  //ray.setDir(mouseX, mouseY);

  //PVector pt = ray.cast(wall);
  //println(pt);
  //if(pt != null){
  // fill(255);
  // ellipse(pt.x, pt.y, 8, 8);
  //}
}
boolean down = false;
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(down && ((e<0 && range>=1) || (e>0 && range <=358))){
    range+=2*e;
    p.rot(0);
  }
  else
    p.rot(e/10);
}

void mousePressed(){
  down=true; 
}
void mouseReleased(){
  down = false;
}
