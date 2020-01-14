class Network{
  int InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes;
  Neuron[] Inputs, Hiddens[], Outputs;
  float[] weights;
  int weightsCount =0;
  
  Network(int InputNodes_, int HiddenXNodes_, int HiddenYNodes_, int OutputNodes_){
    InputNodes = InputNodes_;
    HiddenXNodes = HiddenXNodes_;
    HiddenYNodes = HiddenYNodes_;
    OutputNodes = OutputNodes_;
    weights = new float[OutputNodes*HiddenYNodes + HiddenYNodes*HiddenXNodes + HiddenYNodes*InputNodes];
    
    Inputs = new  Neuron[InputNodes];
    Hiddens = new Neuron[HiddenXNodes][HiddenYNodes];//bug??
    Outputs = new Neuron[OutputNodes];
    
    for(int i=0; i<InputNodes; i++){
      Inputs[i] = new Neuron();
    }
    
    for(int i=0; i<HiddenXNodes; i++){
      for(int v=0; v<HiddenYNodes; v++){
         Hiddens[i][v] = new Neuron();
         float[] w = new float[Inputs.length];
         if(i==0){
           for(int j=0; j<Inputs.length; j++){
             w[j] = weights[weightsCount];
             weightsCount++;
           }
           Hiddens[i][v].addDendrite(Inputs, w);
         }
         else{
           for(int j=0; j<HiddenYNodes; j++){
             w[j] = weights[weightsCount];
             weightsCount++;
           }
           Hiddens[i][v].addDendrite(Hiddens[i-1], w);
         }
      }
    }
    
    for(int i=0; i<OutputNodes; i++){
      float[] w = new float[Inputs.length];
      Outputs[i] = new Neuron();
      for(int j=0; j<HiddenYNodes; j++){
        w[j] = weights[weightsCount];
        weightsCount++; 
      }
      
      Outputs[i].addDendrite(Hiddens[HiddenXNodes-1], w);
    }
  }
  
  public float[] feedForward(float[] Inputs_){
    if(Inputs.length != Inputs_.length){
      println("inputs must have the same length");
    }
    for(int i=0; i<Inputs_.length; i++){
      
      Inputs[i].axonValue = Inputs_[i];
    }
    for(int i=0; i<HiddenXNodes; i++){
      for(int j=0; j<HiddenYNodes; j++){
        Hiddens[i][j].process();
        println(Hiddens[0][0].axonValue);
      } 
    }
    for(int i=0; i<Outputs.length; i++){
      Outputs[i].process(); 
    }
    float[] Result = new float[Outputs.length];
    for(int i=0; i<Result.length; i++){
      Result[i] = Outputs[i].axonValue;
    }
    return Result;
  }
  
  PrintWriter inputLog, hiddenLog, outputLog;
  public void save(){
     inputLog = createWriter( "Inputs.txt");
    hiddenLog = createWriter("Hiddens.txt");
    outputLog = createWriter("Outputs.txt");
     inputLog.println( Inputs);
    hiddenLog.println(Hiddens);
    outputLog.println(Outputs);
     inputLog.flush();
    hiddenLog.flush();
    outputLog.flush();
  }
  
  public void load(){
     
  }
}
