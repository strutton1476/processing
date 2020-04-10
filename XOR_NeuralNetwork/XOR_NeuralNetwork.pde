NeuralNetwork nn = new NeuralNetwork(1, 2, 1, 1, false);

void setup(){
  float[] inputs = {0};
  
  //nn.train(inputs,expected);
  
  float[] result = nn.feedForward(inputs);
  
  println(result);
}

void draw(){
  
}
