int cellSize = 15;

trainingData td;
GA ga;

void settings() {
  size(28*cellSize, 28*cellSize);
}

void setup() {
  td = new trainingData(); //59,999 digits
  ga = new GA(false);
  
  //Thread geneticThread = new GeneticThread();
  //geneticThread.start();
}

void draw() {
  if(td != null)
    td.display();
  
  if(ga != null)
    ga.update();
}

void mousePressed(){
  //td.nextNum();
}
