int cellSize = 15;
int count =0;

trainingData td;
GA ga;

void settings() {
  size(28*cellSize, 28*cellSize);
}

void setup() {
  ga = new GA();
  td = new trainingData();
  
  //noStroke();
  //textAlign(CENTER, CENTER);
  //textSize(30);
}

void draw() {
  //int[] pixs = new int[28*28];
  //for (int i = 0; i < 28; i++) {
  //  for (int j = 0; j < 28; j++) {
  //    pixs[i*28 +j] = int(trainSet[784*count+28*i+j +16]);
  //    fill(pixs[i*28 +j]); //the first 16 bits are meta data
  //    rect(cellSize*j, cellSize*i, cellSize, cellSize);
  //  }
  //}
  
  //ga.setInputs(pixs);
  fill(255, 0, 0);
  //text(int(labelSet[count +8]), 30, 30); //the first 8 bits are meta data
}

void mousePressed(){
  count++; 
}
