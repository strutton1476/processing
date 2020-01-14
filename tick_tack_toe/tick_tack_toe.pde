String[] board;
int turn =0;
boolean run = true;
void setup(){
  size(600, 600);
  board = new String[9];
  for(int i=0; i<9; i++){
     board[i] = "";
  }
}
void draw(){
  fill(255);
  background(200);
  for(int i=1; i<3; i++){
    line(i*width/3, 0, i*width/3, height); 
    line(0, i*height/3, width, i*height/3); 
  }
  for(int x=0; x<3; x++){
    for(int y=0; y<3; y++){
      fill(0);
      text(board[x*3+y], x*width/3+width/6, y*height/3+height/6);
    }
  }
  
  
  
}
boolean Win(){
  boolean result = false;
  
  if(board[0] == board[1] && board[0] == board[2] && board[0] != ""){
    result = true;
    run = false;
  }
  if(board[3] == board[4] && board[3] == board[5] && board[3] != ""){
    result = true;
    run = false;
  }
  if(board[6] == board[7] && board[6] == board[8] && board[6] != ""){
    result = true;
    run = false;
  }
  if(board[0] == board[4] && board[0] == board[8] && board[0] != ""){
    result = true;
    run = false;
  }
  if(board[2] == board[4] && board[2] == board[6] && board[2] != ""){
    result = true;
    run = false;
  }
  return result;
}

void mousePressed(){
  if(run){
    for(int x=0; x<3; x++){
     for(int y=0; y<3; y++){
       if(mouseX > x*width/3 && mouseX < (x+1)*width/3){
         if(mouseY > y*height/3 && mouseY < (y+1)*width/3){
           if(board[x*3+y] ==""){
             if(turn%2==0)
               board[x*3+y] = "X";
             else
               board[x*3+y] = "O";
             if(Win())
               println("winner is player", turn%2+1);
             else
               turn++;
           }
         }
       }
     }
    }
  }
}
