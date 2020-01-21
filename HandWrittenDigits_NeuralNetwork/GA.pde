class GA {
  float bestfitness = 100000;
  Network bestNetwork;
  
  int initSize = 10000;
  int num = 28*28;
  Network[] nets = new Network[10000];
  int netCount =0;

  private int InputNodes =28*28;
  private int HiddenXNodes = 2;
  private int HiddenYNodes = InputNodes;
  private int OutputNodes = 10;

  GA(boolean loading) {
    // 1,237,152 weights
    //float[] weights = new float[OutputNodes * HiddenYNodes + (HiddenXNodes-1)*HiddenYNodes*HiddenXNodes + InputNodes*HiddenYNodes];
    float[] weights = new float[OutputNodes*HiddenYNodes + (HiddenXNodes-1)*HiddenYNodes*HiddenYNodes + HiddenYNodes*InputNodes];
    if(!loading){
      for (int i=0; i<10; i++) {
        for (int j=0; j<weights.length; j++) {
          weights[j] = random(-1, 1);
        }
        
        nets[i] = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights);
        nets[i].feedForward(float(td.getCurrentPixs()));
        grade(nets[i]);
        
        if(nets[i].fitness < bestfitness){
          bestfitness = nets[i].fitness;
          bestNetwork = nets[i];
        }
      }
    }
    else{
      nets = new Network[1];
      
      nets[0] = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights.length);
      nets[0].feedForward(float(td.getCurrentPixs()));
      grade(nets[0]);
    }
  }
  
  void breed(){
    Network childNetwork = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights);
    Network Mate = random(nets);
    
    int index1 = (int)random(Mate.weights.length);
    int index2 = (int)random(Mate.weights.length);
    
    
  }

  void grade(Network net_) {
    float[] result = new float[net_.Outputs.length];
    float[] errors = new float[net_.Outputs.length];
    float[] expected = td.getCurrentExpected();
    float avrerror =0;
    
    for(int i=0; i<result.length; i++){
       result[i] = net_.Outputs[i].axonValue;
       errors[i] = Math.abs(expected[i] - result[i]);
       avrerror += errors[i];
    }
    avrerror /= errors.length;
    
    net_.fitness = map(avrerror, 0, 1, 1, 0);
    
    float smallest = 10;
    int index = 0;
    for(int i=0; i<errors.length; i++){
      if(errors[i] < smallest){
        smallest = errors[i];
        index = i;
      }
      
      if(index == td.getCurrentnum())
        net_.fitness*=2;
        
    }
  }
}
