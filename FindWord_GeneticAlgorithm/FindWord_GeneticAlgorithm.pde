String expected = "school";
ArrayList<String> population = new ArrayList<String>();
ArrayList<String> matingPool = new ArrayList<String>();

int count =10;
void setup(){
  size(600, 500);
  for(int i=0; i<count; i++)
    makeGuess();
  
  for(int i=0; i<population.size(); i++){
    String current = population.get(i);
    int score = grade(current);
    
    for(int j=0; j<score; j++){
      matingPool.add(current); 
    }
  }
  
  //println(population.size(), matingPool.size());
}

void draw(){
}

int grade(String current){
  int score =1;
  for(int j=0; j<current.length(); j++){
    if(current.substring(j,j+1).equals(expected.substring(j, j+1))){
      score++; 
    }
  }
  return score;
}

void breed(){
  String[] parents = {population.get((int)random(population.size())), population.get((int)random(population.size()))};
  int count=0;
  
  while(parents[0] == parents[1]){
    parents[1] = population.get((int)random(population.size()));
    if(count==1000){
      println("loop in breed overrun to "+count);
      break;
    }
    count++;
  }
  
  String result = "";
  for(int i=0; i<parents[0].length(); i++){
    result += parents[Math.round(random(1))].substring(i, i+1);
  }
  
}

void makeGuess(){
  String guess = new String();
  for(int i=0; i<expected.length(); i++){
    guess = guess+char(byte(random(97, 123)));
  }
  
  population.add(guess);
}
