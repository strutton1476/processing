byte[] trainSet, labelSet;
int currentCount =0;

class trainingData{
  trainingData(){
    trainSet = loadBytes("train-images.idx3-ubyte");
    labelSet = loadBytes("train-labels.idx1-ubyte");
  }
  
  public int[] getCurrentPix(){
    int[] pixs = new int[28*28];
    for (int i = 0; i < 28; i++) {
      for (int j = 0; j < 28; j++) {
        pixs[i*28 +j] = int(trainSet[784*count+28*i+j +16]);
      }
    }
    return pixs;
  }
  
  public boolean check(int predicted){
    if(predicted == int(labelSet[count +8])){
      currentCount++;
      return true;
    }
    return false;
  }
}
