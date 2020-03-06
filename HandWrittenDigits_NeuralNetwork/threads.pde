class GeneticThread extends Thread{
  public void run(){
    ga = new GA(false);
  }
}

//class FeedForwardThread extends Thread{
//  int index;
//  float[] Result;
//  public FeedForwardThread(Network net, Neuron[] inputs_){
    
//    Result = new float[net.Outputs.length];
//    if(net.Inputs.length != net.Inputs.length){
//      println("inputs must have the same length");
//    }
    
//    for(int i=0; i<net.Inputs.length; i++){
//      net.Inputs[i].axonValue = net.Inputs[i].axonValue;
//    }
//    for(int i=0; i<net.HiddenXNodes; i++){
//      for(int j=0; j<net.HiddenYNodes; j++){
//        net.Hiddens[i][j].process();
//      } 
//    }
//    for(int i=0; i<net.Outputs.length; i++){
//      net.Outputs[i].process(); 
//    }
//    for(int i=0; i<Result.length; i++){
//      Result[i] = net.Outputs[i].axonValue;
//    }
    
//    //return Result;
//  }
  
//  public void run(){
//    if(ga != null){
//      ga.nets.get(index).feedForward(float(td.getCurrentPixs()));
//      ga.grade(ga.nets.get(index));
//    }
//  }
//}
