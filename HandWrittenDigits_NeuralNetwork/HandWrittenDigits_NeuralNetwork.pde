int cellSize = 15;
boolean trained =false;

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
  ga.update();
  td.display();
}

void mousePressed(){
  if(trained){
    td.nextNum();
    println(td.getNum(ga.bestNetwork.feedForward(float(td.getCurrentPixs()))));
  }
}
