class GA {
  float bestfitness = 100000;
  Network bestNetwork;
  
  int initSize = 10;
  Network[] nets = new Network[10000];
  private int netCount =0;
  
  Network[] population = new Network[10000];
  private int popCount =0;
  
  private int InputNodes =28*28;
  private int HiddenXNodes = 2;
  private int HiddenYNodes = InputNodes;
  private int OutputNodes = 10;
  
  GA(boolean loading) {
    // 1,237,152 weights
    
    float[] weights = new float[OutputNodes*HiddenYNodes + (HiddenXNodes-1)*HiddenYNodes*HiddenYNodes + HiddenYNodes*InputNodes];
    if(!loading){
      for (int i=0; i<initSize; i++) {
        for (int j=0; j<weights.length; j++) {
          weights[j] = random(-1, 1);
        }
        
        nets[i] = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights);
        netCount++;
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
    
    breed();
  }
  
  Network breed(){
    Network child = bestNetwork; 
    int index1 =(int)random(netCount);
    int index2 =(int)random(netCount);
    
    while(index1==index2){
      index2 = (int)random(netCount);
    }
    
    Network parent1 = nets[index1];
    Network parent2 = nets[index2];
    
    
    for(int i=0; i<parent1.weights.length; i++){
      float chance = random(1);
      
      if(chance<=0.5 && chance > 0.01){
        child.weights[i] = parent1.weights[i]; 
      }
      else if(chance <= 0.01){
        child.weights[i] = random(-1, 1);
      }
      else{
        child.weights[i] = parent2.weights[i];
      }
    }
    
    nets[netCount] = child;
    grade(nets[netCount]);
    println(parent1.fitness, parent2.fitness, child.fitness);
    netCount++;
    
    return child;
  }

   float grade(Network net_) {
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
        net_.fitness+=1;
        
    }
    return net_.fitness;
  }
}
