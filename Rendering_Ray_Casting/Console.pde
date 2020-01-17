class Console {
  float currenth = 150;
  float h = 150;
  public void show() {
    
    if(currenth < 0)
      currenth =0;
    else if (currenth > h)
      currenth -=7;
    else if (currenth < h)
      currenth +=7;
      
    println(currenth, h);
    fill(100, 150);
    rect(0, height-currenth, width, height);
  }
  public void toggle() {
    if(h==150)
      h = 0;
    else if(h==0)
      h = 150;
  }
}
