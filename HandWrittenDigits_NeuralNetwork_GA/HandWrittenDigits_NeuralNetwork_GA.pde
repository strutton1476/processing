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
  //td = new trainingData(); //59,999 digits
  tdT = new trainingThread();
  
  ga = new GA(true);
  //Thread geneticThread = new GeneticThread();
  //geneticThread.start();
  
  println(ga.nets.get(0).weights[763]);
}

void draw() {
  //println(ga.nets.size());
  ga.update();
  //tdT.run();
  //if(trained)
  //td.display();
}

void mousePressed(){
  p=true;
  if(trained){
    td.nextNum();
    tdT.run();
    println(td.getNum(ga.bestNetwork.feedForward(float(td.getCurrentPixs()))));
  }
}

void keyPressed(){
  if(key=='q'){
    noLoop();
    ga.bestNetwork.saveWeights();
    println("Saved Weights");
  }
}
