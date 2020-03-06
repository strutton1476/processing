class GA {
  //float bestfitness = 100000;
  //Network bestNetwork;
  
  int initSize = 50;
  //Network[] nets = new Network[10000];
  //private int netCount =0;
  
  ArrayList<Network> nets = new ArrayList<Network>();
  
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
        Network net = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen, false);
        
        for(int j=0; j<grade(net); j++){
          nets.add(net);
        }
        
        //nets.add(new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights));
        
        //netCount++;
        //nets[i].feedForward(float(td.getCurrentPixs()));//things!!!
        //Thread t = new FeedForwardThread(i);
        //t.start();
      }
      //breed();
    }
    else{
      
      //nets.add(new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen, true));
      //nets.get(0).feedForward(float(td.getCurrentPixs()));
      grade(nets.get(0));
    }
    //println(netCount);
  }
  
  Network breed(){
    Network parent1 = nets.get((int)Math.floor(random(nets.size())));
    Network parent2 = nets.get((int)Math.floor(random(nets.size())));
    
    while(parent1.equals(parent2))
      parent2 = nets.get((int)Math.floor(random(nets.size())));
     
    //ArrayList<Float> fits = new ArrayList<Float>();
    //ArrayList<Float> fitCalc = new ArrayList<Float>();
    //float[] fits = new float[netCount];
    //float[] fitCalc = new float[netCount+1];
    
    //float fitsum = 0;
    //for(int i=0; i<nets.size(); i++){
    //  fits.add(nets.get(i).fitness);
    //  fitsum += fits.get(i);
    //}
    
    //float chance1 = random(fitsum);
    //float chance2 = random(fitsum);
    
    //fitCalc.add(0f);
    //for(int i=0; i<nets.size(); i++){
    //  fitCalc.add(fits.get(i) + fitCalc.get(i));
      
    //    if(fitCalc.get(i)<=chance1 && chance1 <fitCalc.get(i+1)){
    //      parent1 = nets.get(i);
    //    }
    //    if(fitCalc.get(i)<=chance2 && chance2 <fitCalc.get(i+1)){
    //      parent2 = nets.get(i);
    //    }
        
    //  //println("["+i+"]","["+fitCalc[i]+","+fitCalc[i+1]+")");
    //}
    
    //println(chance1, chance2);
    //println();
    //println(fits);
    
    //Network old;
    //if(parent1.fitness < parent2.fitness){
    //  old = parent1;
    //  parent1 = parent2;
    //  parent2 = old;
    //}
    
    float[] w = new float[parent1.weights.length];//set weights
    for(int i=0; i<parent1.weights.length; i++){
      float ran = random(100);
      if(ran >= 50)
        w[i] = parent1.weights[i];
      else if(ran<=1)
        w[i] = random(-1, 1);
      else
        w[i] = parent2.weights[i];
    }
    
    Network child = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, w);
    
    grade(child);
    for(int i=0; i<grade(child); i++)
      nets.add(child);
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
  
  void update(){
    println(breed().fitness, nets.size());
    while(nets.size() > 500)
      nets.remove(0);
  }
  
}
