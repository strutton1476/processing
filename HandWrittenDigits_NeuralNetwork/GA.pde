class GA {
  //float bestfitness = 100000;
  //Network bestNetwork;
  
  int initSize = 10;
  Network[] nets = new Network[10000];
  private int netCount =0;
  
  private int InputNodes =28*28;
  private int HiddenXNodes = 2;
  private int HiddenYNodes = InputNodes;
  private int OutputNodes = 10;
  private int weightlen = 0;
  
  GA(boolean loading) {
    // 1,237,152 weights
    weightlen = OutputNodes*HiddenYNodes + (HiddenXNodes-1)*HiddenYNodes*HiddenYNodes + HiddenYNodes*InputNodes;
    
    if(!loading){
      for (int i=0; i<initSize; i++) {
        float[] weights = new float[weightlen];
        
        for (int j=0; j<weights.length; j++) {
          weights[j] = random(-1, 1);
        }
        
        nets[i] = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights);
        netCount++;
        nets[i].feedForward(float(td.getCurrentPixs()));
        grade(nets[i]);
      }
      
    }
    else{
      nets = new Network[1];
      
      nets[0] = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen);
      nets[0].feedForward(float(td.getCurrentPixs()));
      grade(nets[0]);
    }
    //println(netCount);
  }
  
  Network breed(){
    Network parent1 = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen);
    Network parent2 = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen);
    
    float[] fits = new float[netCount];
    float[] fitCalc = new float[netCount+1];
    
    float fitsum = 0;
    for(int i=0; i<netCount; i++){
      fits[i] = nets[i].fitness;
      fitsum += fits[i];
    }
    
    float chance1 = random(fitsum);
    float chance2 = random(fitsum);
    
    fitCalc[0] =0;
    for(int i=0; i<netCount; i++){
      fitCalc[i+1] = fits[i] + fitCalc[i];
      
        if(fitCalc[i]<=chance1 && chance1 <fitCalc[i+1]){
          parent1 = nets[i];
        }
        if(fitCalc[i]<=chance2 && chance2 <fitCalc[i+1]){
          parent2 = nets[i];
        }
        
      //println("["+i+"]","["+fitCalc[i]+","+fitCalc[i+1]+")");
    }
    
    while(parent1.weights[0] == parent2.weights[0]){  //make sure parents arnt the same
      chance2 = random(fitsum);
      
      for(int i=0; i<netCount; i++){
        fitCalc[i+1] = fits[i] + fitCalc[i];
        
        if(fitCalc[i]<=chance2 && chance2 <fitCalc[i+1]){
          parent2 = nets[i];
        }
      }
    }
     
    //println(chance1, chance2);
    //println();
    //println(fits);
    Network old;
    if(parent1.fitness < parent2.fitness){
      old = parent1;
      parent1 = parent2;
      parent2 = old;
    }
    
    float[] w = new float[parent1.weights.length];//set weights
    for(int i=0; i<parent1.weights.length; i++){
      float ran = random(100);
      if(ran >= 35)
        w[i] = parent1.weights[i];
      else if(ran<=1)
        w[i] = random(-1, 1);
      else
        w[i] = parent2.weights[i];
    }
    
    Network child = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, w);
    
    grade(child);
    
    nets[netCount] = child;
    netCount++;
    //println(parent1.fitness, parent2.fitness, child.fitness);
    
    return child;
  }

   float grade(Network net_) {
    float[] result = net_.feedForward(float(td.getCurrentPixs()));
    float[] errors = new float[net_.Outputs.length];
    float[] expected = td.getCurrentExpected();
    float avrerror =0;
    
    for(int i=0; i<result.length; i++){
       errors[i] = Math.abs(expected[i] - result[i]);
       avrerror += errors[i];
    }
    avrerror /= errors.length;
    
    net_.fitness = map(avrerror, 0, 1, 1, 0);
    //net_.fitness= avrerror;
    
    float smallest = 1000;
    int index = 0;
    for(int i=0; i<errors.length; i++){
      if(errors[i] < smallest){
        smallest = errors[i];
        index = i;
      }
      
      if(index == td.getCurrentnum())
        net_.fitness*=2;
      else
        net_.fitness/=2;
    }
    
    return net_.fitness;
  }
  
}
