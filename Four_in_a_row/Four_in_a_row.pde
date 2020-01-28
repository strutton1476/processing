color[][] cells = new color[7][6];
boolean player1 =true;
int r=50;

void setup(){
  size(600, 600);
  
  for(int x=0; x<cells.length; x++){
    for(int y=0; y<cells[x].length; y++){
      cells[x][y] = color(255,255,255);
    }
  }
}

void draw(){
  background(color(0,0,200));
  
  for(int x=0; x<cells.length; x++){
    for(int y=0; y<cells[x].length; y++){
      fill(cells[x][y]);
      ellipse(x*(width/cells.length)+r, y*(height/cells[x].length)+r, r, r);
    }
  }
}

void mousePressed(){
  color current;
  color other;
  
  if(player1){
    current = color(255, 255, 0);
    other = color(255, 0, 0);
  }
  else{
    current = color(255, 0, 0);
    other = color(255, 255, 0);
  }
  
  for(int x=0; x<cells.length; x++){
    if(mouseX >x*(width/cells.length)+48- r/2 && mouseX<x*(width/cells.length)+48+ r/2){
      for(int y=0; y<cells[x].length; y++){
        
        if(cells[x][y]==color(255, 255, 255)){
          cells[x][y] = current;
          if(y>0)
            cells[x][y-1] = color(255, 255, 255);
        }
        else if(y>0){
          if(cells[x][y-1]==color(255, 255, 255))
            cells[x][y-1] = current;
        }
      }
      
      if(player1){
        player1=false;
      }
      else{
        player1=true;
      }
    }
  }
}
