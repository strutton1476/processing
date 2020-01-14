byte[] trainSet, labelSet;
int currentCount =0;

class trainingData{
  trainingData(){
    trainSet = loadBytes("train-images.idx3-ubyte");
    labelSet = loadBytes("train-labels.idx1-ubyte");
  }
  
  public boolean check(int predicted){
    if(predicted == int(labelSet[count +8])){
      currentCount++;
      return true;
    }
    return false; 
  }
}
