int cellSize = 15;

trainingData td;
GA ga;

void settings() {
  size(28*cellSize, 28*cellSize);
}

void setup() {
  td = new trainingData(); //59,999 digits
  ga = new GA(false);
}

void draw() {
  td.display();
}

void mousePressed(){
  td.nextNum();
}
