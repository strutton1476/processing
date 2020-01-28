class Neuron{
  public float axonValue = 0;
  public float[] weights;
  public Neuron[] dendrites;
  
  public void process(){
    axonValue = 0;
    for(int i=0; i<dendrites.length; i++){
       axonValue += dendrites[i].axonValue*weights[i];
    }
    axonValue = sigmoid(axonValue/2);
  }
  
  public void addDendrite(Neuron[] neurons, float[] weights_){
    dendrites = neurons;
    weights = weights_;
  }

  private float sigmoid(float x) {
    return (float)(1/( 1 + Math.pow(Math.E,(-1*x))));
  }
}
