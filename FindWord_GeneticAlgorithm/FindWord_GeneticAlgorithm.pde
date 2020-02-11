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
    int score =0;
    for(int j=0; j<current.length(); j++){
      if(current.substring(j,j+1) == expected.substring(j, j+1)){
        score++; 
      }
    }
    
    for(int j=0; j<score; j++){
      matingPool.add(current); 
    }
  }
  
}

void draw(){
}

void makeGuess(){
  String guess = new String();
  for(int i=0; i<expected.length(); i++){
    guess = guess+char(byte(random(97, 123)));
  }
  
  population.add(guess);
}
