String expected = "school";
ArrayList<String> population = new ArrayList<String>();
ArrayList<String> matingPool = new ArrayList<String>();
int bestScore =0;
String bestString = "";


int count =2;
void setup(){
  size(600, 500);
  
  for(int i=0; i<count; i++)
    makeGuess();
    
  //while(bestScore!= (expected.length()+1)){
  //  breed();
  //}
  breed();
  
  //println(bestScore, bestString);
}

void draw(){

}

int grade(String current){
  int score =1;
  println(current);
  for(int j=1; j<current.length(); j++){
    if(current.substring(j-1,j).equals(expected.substring(j-1, j)))
      score++; 
  }
  for(int j=0; j<score; j++)
    matingPool.add(current);
    
  if(score > bestScore){
    bestString = current;
    bestScore = score; 
  }
    
  return score;
}

void breed(){
  String[] parents = {population.get((int)Math.floor(random(population.size()))), population.get((int)Math.floor(random(population.size())))};
  int count=0;
  
  while(parents[0].equals(parents[1])){
    parents[1] = population.get((int)Math.floor(random(population.size())));
    if(count==1000){
      println("loop in breed overrun to "+count);
      break;
    }
    count++;
  }
  
  String result = "";
  for(int i=1; i<parents[0].length()+1; i++){
    result += parents[(int)random(2)].substring(i-1, i);
  }
  
  population.add(result);
  grade(result);
}

void makeGuess(){
  String guess = new String();
  for(int i=0; i<expected.length(); i++){
    guess = guess+char(byte(random(97, 123)));
  }
  
  population.add(guess);
  grade(guess);
}
