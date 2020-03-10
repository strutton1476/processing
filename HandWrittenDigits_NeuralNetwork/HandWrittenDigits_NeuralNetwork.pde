int cellSize = 15;
boolean trained =false;
boolean p = false;
Thread tdT;

trainingData td;
GA ga;

void settings() {
  size(28*cellSize, 28*cellSize);
}

void setup() {
  td = new trainingData(); //59,999 digits
  //tdT = new trainingThread();
  //tdT.start();
  
  ga = new GA(false);
  //Thread geneticThread = new GeneticThread();
  //geneticThread.start();
}

void draw() {
  //println(ga.nets.size());
  ga.update();
  if(trained)
    td.display();
}

void mousePressed(){
  p=true;
  if(trained){
    td.nextNum();
    println(td.getNum(ga.bestNetwork.feedForward(float(td.getCurrentPixs()))));
  }
}
