void setup() {
  size(900, 900);

  colorMode(HSB);

  //noiseSeed(1);
  noStroke();
  background(100);

  //noLoop();
}

ArrayList<PVector> pts = new ArrayList<PVector>();
float noiseFactorX = 1, noiseFactorY = 1000;
float noiseFactorS = 500;
float noises[] = {
  1, 10, 50, 100, 200, 400, 800, 1500, 1900
};
float hueRange[] = {0, 70};
float x = 0, y = 0;
float counter = 0;
void draw() {
  fill(0, 15);
  rect(0, 0, width, height);
  translate(width/2, height/2);
  //rotate(noises[0]/10);
  //background(100,1,1,1);

  float noiseValX = noise(noises[0]);
  float noiseValY = noise(noises[1]);
  float noiseValS = noise(noises[2]);
  float noiseValH = noise(noises[3]);

  for (int i = 0; i<noises.length; i++) noises[i]+=0.01;

  //println(noiseValX, noiseValY, x*width*noiseValX, y*height*noiseValX);
  float hue = map(noiseValH, 0, 1, hueRange[0], hueRange[1]);
  fill(hue, 255, 255, 3);
  x = map(noiseValX, 0, 1, 0, width/1.3);
  y = map(noiseValY, 0, 1, 0, height/1.3);
  if (x>width/2 || x<0) x = abs(x)%255;
  if (y>height/2 || y<0) x = abs(x)%255;
  float size = map(noiseValS, 0, 1, 5, 25);
  int pad = -200;

  pts.add(new PVector(x + pad, y + pad, size));
  pts.add(new PVector(-(x+pad), y + pad, size));
  pts.add(new PVector(x+pad, -(y + pad), size));
  pts.add(new PVector(-(x+pad), -(y + pad), size));


  for (int i=0; i<pts.size(); i++) {
    PVector p = pts.get(i);
    float h = map(i, 0, pts.size(), 0, 50);
    fill(h, 200, 200, 25);
    ellipse(p.x, p.y, p.z, p.z);
  }


  if (millis() - counter > 2000 ) {
    noiseSeed((long)random(0, 1000));
    noises[3] = random(hueRange[0], hueRange[1]);
    counter = millis();
    //background(0,10);
  }
  if (frameCount % 200 == 0) reset();

  //if (frameCount % 2000 == 0) noLoop();
  //println(frameCount);
  if (pts.size() > 2000) {
    pts.remove(0);
    pts.remove(1);
    pts.remove(2);
    pts.remove(3);
  }
}//draw


void keyPressed() {
  if (key == 'r') {
    loop();
    reset();
  }
}

void reset() {
  noiseSeed((long)random(0, 1000));
  noises[3] = random(hueRange[0], hueRange[1]);
  float r = random(0, 30);
  hueRange[0] = hueRange[0] + r;
  hueRange[1] = (hueRange[0]+100)%255;
}
