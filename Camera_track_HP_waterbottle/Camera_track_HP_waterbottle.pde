import processing.video.*;
import ipcapture.*;

Capture cam;
//IPCapture cam;

int c =2;

//255
int ra = 80;
int ga = 200;
int ba = 200;
int tha = 14;

//0
int rb = 22;
int gb = 0;
int bb = 0;
int thb = 0;


boolean bypass = false;

void setup() {
  size(640, 480);
  //size(1280, 960);

  //cam = new Capture(this, Capture.list()[87]);
  cam = new Capture(this, Capture.list()[1]);
  //cam = new IPCapture(this, "frcvision.local:8081/stream.jpg", "", "");

  //String[] list = cam.list();

  //for(int i=0; i<list.length; i++){
  //  println(i, list[i]); 
  //}
  cam.start();
}

void draw() {
  background(0);
  
  if (cam.available())
    cam.read();

  for (int x=0; x<cam.width; x+=c) {
    for (int y=0; y<cam.height; y+=c) {
      int index = y*cam.width+x;

      color expected = color(0, 0, 255);
      color[] cols = cam.pixels;
      int current = cols[index];

      int r = (int)Math.abs(red(current) - red(expected));
      int g = (int)Math.abs(green(current) - green(expected));
      int b = (int)Math.abs(blue(current) - blue(expected));

      if (index >= cam.width && index < cols.length-((c/2)*cam.width) && b>=bb && r>=rb && g>=gb && r<=ra && g<=ga && b<=ba) {
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

        float val = (Math.abs(avrRGB[0]-r)+Math.abs(avrRGB[1]-g)+Math.abs(avrRGB[2]-b))/3;
        if ((val <=tha && val>=thb) || bypass) {
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
  text("upper: ra "+ra+" ga "+ga+" ba "+ba, 10, 60);
  text("lower: rb "+rb+" gb "+gb+" bb "+bb, 10, 80);
  text("th "+tha+" / "+thb, 10, 100);
}

void mouseWheel(MouseEvent event) {
  int t = -event.getCount();
  
  //println((ra<255 && t>0) rb>0 && t<0));
  
  if(key=='q' && ((ra<255 && t>0) || (ra>0 && t<0)))
    ra+=t; 
  else if(key=='a' && ((rb<255 && t>0) || (rb>0 && t<0)))
    rb+=t;
  else if(key=='w' && ((ga<255 && t>0) || (ga>0 && t<0)))
    ga+=t;
  else if(key=='s' && ((gb<255 && t>0) || (gb>0 && t<0)))
    gb+=t;
  else if(key=='e' && ((ba<255 && t>0) || (ba>0 && t<0)))
    ba+=t;
  else if(key=='d' && ((bb<255 && t>0) || (bb>0 && t<0)))
    bb+=t;
  else if(key=='r' && ((tha<255 && t>0) || (tha>0 && t<0)))
    tha+=t;
  else if(key=='f' && ((thb<255 && t>0) || (thb>0 && t<0)))
    thb+=t;
  else if (key=='x' && ((c>2 && t<0) || t>0))
    c+=2*t;
}

void keyPressed() {
  if(key=='z'){
    if(bypass)
      bypass = false;
    else
      bypass = true; 
  }
}
