int cellSize = 15;

trainingData td;
GA ga;

void settings() {
  size(28*cellSize, 28*cellSize);
}

void setup() {
  td = new trainingData(); //59,999 digits
  ga = new GA(false);
  
  //noStroke();  
  //textAlign(CENTER, CENTER);
  //textSize(30);
}

void draw() {
  td.display();
}

void mousePressed(){
  //td.count++;
  td.nextNum();
}
