import controlP5.*;

ControlP5 gui;

void setup() {
  size(600, 600);
  noStroke();
  c=new Circle(200, 200);

  gui=new ControlP5(this);

  gui.addSlider("slider")
    .setPosition(5, 570)
    .setSize(200, 20)
    .setRange(0.001, 0.2)
    .setValue(0.15)
    ;
  gui.addSlider("linesmod")
    .setPosition(5, 553)
    .setSize(200, 15)
    .setRange(1, 100)
    .setValue(1)
    ;
  gui.addSlider("lineiter")
    .setPosition(5, 538)
    .setSize(200, 15)
    .setRange(1, 300)
    .setValue(100)
    ;
}


/*Variables*/
Circle c;
float alpha=0.01;  //Rotation variable
float x0=0, y0=0;  //Mouse position dragged
float mw=1;        //m.wheel value
boolean flagrot = false;
boolean flagmod = false;


void draw() {
  background(0);

  pushMatrix();
  //translate(width/2, height/2);

  scale(mw);
  translate(width/2/mw +x0, height/2/mw +y0);
  if (flagrot)  //q for rotating figure
  {
    alpha+=0.01;
  }
  if(flagmod)  //w for random change in linesmod
  {
    if(c.linesmod>0 && frameCount%30==0)
    c.linesmod++;
    if(c.linesmod>=99) c.linesmod=0;
  }
  rotate(alpha);
  c.show();

  popMatrix();
}
int ctemp=0;


void keyPressed() {
  if (key=='a') {
    if (c.mflag==true) {
      c.mflag=false;
      if (c.flag==0) {
        c.flag=1;
        ctemp=c.flag;
      } else if (c.flag==1) {
        c.flag=0;
        ctemp=c.flag;
      } else if (c.flag==2)
        c.flag=ctemp;
    }
    c.mflag=true;
  } else if (key=='s') {
    {
      c.flag=2; 
      c.mflag=true;
    }
  }

  if (key=='l')
    c.linesflag=!c.linesflag;

  if (key=='r' || key=='R') {
    mw=1;
    x0=y0=0;
  }

  if (key=='=' && c.linesmod<100)
  {
    c.linesmod=(int)c.linesmod+1;
    linesmod(c.linesmod);
  }
  if (key=='-' && c.linesmod>0)
  {
    c.linesmod=(int)c.linesmod+1;
    linesmod(c.linesmod);
  }
  if(key=='q' || key=='Q')
    flagrot=!flagrot;
  if(key=='w' || key=='W')
    flagmod=!flagmod;
}


int slider(float rate) {
  c.morphRate=rate*rate;
  return 1;
}
void linesmod(float rate) {
  c.linesmod=(int)rate;
}
void lineiter(float rate) {
  c.lineiter=(int)rate;
}

void mouseWheel(MouseEvent event) {
  if (mouseY>520 && mouseY<600 && mouseX>0 & mouseX<220) return;  //Gui protection
  float e = event.getCount();
  println(e, mw);
  float k = lerp(1, mw, 1);//map(w, 0, 200, 1, 50);
  if (mw>0.2 || e<0)
    mw=mw-(e*k)/10;
}

void mouseDragged() {
  if (mouseY>520 && mouseY<600 && mouseX>0 & mouseX<220) return;  //Gui protection
  float k = map(mw, 0, 200, 1, 50);
  x0=x0+(mouseX-pmouseX)/k;
  y0=y0+(mouseY-pmouseY)/k;
}
