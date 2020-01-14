class GA {
  Network best;
  float bestAxon = 1000000000;
  int initSize = 10000;
  int num = 28*28;
  Network[] nets = new Network[10000];
  int netCount =0;
  int[] inputs;
  
  void init() {
    for(int i=0; i<100; i++){
      nets[i] = new Network(num, 1, num, 10);
    }
  }
  
  public void setInputs(int[] inputs_){
    inputs = inputs_;
  }
  
  public void proccessOutputs(){
  
  }
  
}
