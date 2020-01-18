class trainingData{
  byte[] trainSet, labelSet;
  public int count =0;

  trainingData(){
    trainSet = loadBytes("train-images.idx3-ubyte");
    labelSet = loadBytes("train-labels.idx1-ubyte");
  }
  
  public int[] getCurrentPixs(){
    int[] pixs = new int[28*28];
    for (int i = 0; i < 28; i++) {
      for (int j = 0; j < 28; j++) {
        pixs[i*28 +j] = int(trainSet[784*count+28*i+j +16]);
      }
    }
    return pixs;
  }
  
  public float[] getCurrentExpected(){
   int[] expected = new int[10];
   int current = int(labelSet[count +8]);
   
   for(int i=0; i<expected.length; i++){
     expected[i] = 0; 
   }
   
   expected[current] = 1;
   
   return float(expected);
  }
  
  void display(){
    for(int i=0; i<28; i++){
      for(int j=0; j<28; j++){
        //noStroke();
        fill(getCurrentPixs()[i*28 +j]); //the first 16 bits are meta data
        rect(cellSize*j, cellSize*i, cellSize, cellSize); 
      }
    }
    
    fill(255, 0, 0);
    text(int(labelSet[count +8]), 30, 30); //the first 8 bits are meta data
  }
  
}
