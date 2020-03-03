String expected = "ab";
ArrayList<String> population = new ArrayList<String>();
ArrayList<String> matingPool = new ArrayList<String>();
int bestScore =0;
String bestString = "";


int count = 50;
void setup(){
  size(600, 500);
  
  for(int i=0; i<count; i++)
    makeGuess();
    
}

void draw(){
  if(bestScore != (expected.length()))
    breed();
  else
    println("correct",bestScore, bestString);

}

int grade(String current){
  int score =0;
  //println(current);
  for(int j=1; j<current.length(); j++){
    if(current.substring(j-1,j).equals(expected.substring(j-1, j)))
      score++; 
  }
  for(int j=0; j<score; j++)
    matingPool.add(current);
  if(score > bestScore){
    bestString = current;
    bestScore = score;
    
    println(score, current);
  }
    
  return score;
}

void breed(){
  String[] parents = {matingPool.get((int)Math.floor(random(matingPool.size()))), matingPool.get((int)Math.floor(random(matingPool.size())))};
  int count=0;
  
  while(parents[0].equals(parents[1])){
    parents[1] = matingPool.get((int)Math.floor(random(matingPool.size())));
    if(count==1000){
      println("loop in breed overrun to "+count);
      break;
    }
    count++;
  }
  
  String result = "";
  for(int i=1; i<parents[0].length()+1; i++){
    if(random(1)>0.01)
      result += parents[(int)random(2)].substring(i-1, i);
    else
      result += char(byte(random(97, 123)));
  }
  
  population.add(result);
  grade(result);
}

void makeGuess(){
  String guess = new String();
  for(int i=0; i<expected.length(); i++){
    guess += char(byte(random(97, 123)));
  }
  
  population.add(guess);
  grade(guess);
}
