import processing.video.*;

Capture cam;

int c =2;
int rd = 0;
int gd = 0;
int bd = 0;
int th = 1;

boolean bypass = true;

void setup() {
  //size(640, 480);
  size(1280, 960);

  cam = new Capture(this, Capture.list()[87]);
  //cam = new Capture(this, Capture.list()[1]);

  //String[] list = cam.list();

  //for(int i=0; i<list.length; i++){
  //  println(i, list[i]); 
  //}
  cam.start();
}

void draw() {
  background(0);
  

  if (cam.available()) {
    cam.read();
  }
  //image(cam, 0, 0);

  for (int x=0; x<cam.width; x+=c) {
    for (int y=0; y<cam.height; y+=c) {
      int index = y*cam.width+x;

      color expected = color(255, 0, 0);
      color[] cols = cam.pixels;
      int current = cols[index];

      int r = (int)Math.abs(red(current) - red(expected));
      int g = (int)Math.abs(green(current) - green(expected));
      int b = (int)Math.abs(blue(current) - blue(expected));

      if (index >= cam.width && index < cols.length-((c/2)*cam.width) && b>=bd && r>=rd && g>=gd) {
        float[] topRGB = new float[3];
        float[] bottomRGB = new float[3];
        float[] rightRGB = new float[3];
        float[] leftRGB = new float[3];

        int top = cols[index-(c/2)*cam.width];
        topRGB[0] = red(top);
        topRGB[1] = green(top);
        topRGB[2] = blue(top);

        int bottom = cols[index+(c/2)*cam.width];
        bottomRGB[0] = red(bottom);
        bottomRGB[1] = green(bottom);
        bottomRGB[2] = blue(bottom);

        int right = cols[index+(c/2)];
        rightRGB[0] = red(right);
        rightRGB[1] = green(right);
        rightRGB[2] = blue(right);

        int left = cols[index-(c/2)];
        leftRGB[0] = red(left);
        leftRGB[1] = green(left);
        leftRGB[2] = blue(left);

        float avrRGB[] = new float[3];
        avrRGB[0] = (topRGB[0]+bottomRGB[0]+leftRGB[0]+rightRGB[0])/4;
        avrRGB[1] = (topRGB[1]+bottomRGB[1]+leftRGB[1]+rightRGB[1])/4;
        avrRGB[2] = (topRGB[2]+bottomRGB[2]+leftRGB[2]+rightRGB[2])/4;

        //println(Math.abs(avrRGB[0]-r)+(avrRGB[1]-g)+(avrRGB[2]-b)/3);
        if ((Math.abs(avrRGB[0]-r)+(avrRGB[1]-g)+(avrRGB[2]-b))/3 <=th || bypass == true) {
          for (int x_=-c/2; x_<c/2; x_++) {
            for (int y_=-c/2; y_<c/2; y_++) {
              set(cam.width-x+x_, y+y_, current);
            }
          }
        }
      }
    }
  }
  
  fill(color(0, 255, 0));
  
  text("Bypass:"+bypass, 10, 20);
  text("c:"+c, 10, 40);
  text(rd+" gd "+gd+" bd "+bd, 10, 60);
  text("th "+th, 10, 80);
}

void keyPressed() {
  if (key=='q')
    c+=2;
  else if (key=='a'&& c>2)
    c-=2;
  if(key=='z'){
    if(bypass)
      bypass = false;
    else
      bypass = true; 
  }
  
  if(key=='w' && rd<255)
    rd++;
  else if(key=='s' && rd>0)
    rd--;
  
  if(key=='e' && gd<255)
    gd++;
  else if(key=='d' && gd>0)
    gd--;
    
  if(key=='r' && bd<255)
    bd++;
  else if(key=='f' && bd>0)
    bd--;
  if(key=='t')
    th++;
  else if(key=='g')
    th--;
  
}

void mousePressed(){
    
}
