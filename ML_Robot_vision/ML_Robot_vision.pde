PImage img;
JSONObject jsn;


void setup() {
  size(640, 480);
  
  // Images must be in the "data" directory to load correctly
  img = loadImage("DSC02184.jpg");
  jsn = loadJSONObject("DSC02184.jpg.json");
  
  
  println(jsn.get("objects"));
}

void draw() {
  image(img, 0, 0);
}
