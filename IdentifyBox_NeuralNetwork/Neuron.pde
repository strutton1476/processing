public class Neuron{
  public float axonValue;
  public ArrayList<Neuron> dendriteValue;
  public ArrayList<Float> dendriteWeight;
  
  public void addDendrite(Neuron neuron, float weight){
    this.dendriteValue.add(neuron);
    this.dendriteWeight.add(weight);
  }
  
  public void process(){
    for(int i=0; i<dendriteValue.size(); i++){
      axonValue += dendriteValue.get(i).axonValue * dendriteWeight.get(i); 
    }
    axonValue /= dendriteValue.size();
  }
}
