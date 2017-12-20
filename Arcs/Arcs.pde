
void setup(){
  size(500,500);
  noFill();
  colorMode(HSB);
  strokeWeight(7);
 //a=rainbow(8,0,0,400);
 a=wavy(20,0,0,400);
}


Arc[] a;

void draw(){
 background(0);
 stroke(255);
 pushMatrix();

 translate(width/2,height/2);
  rotate(PI);
 for(Arc ar : a)
 ar.show();
 popMatrix();
 
 showtxt();
}

void showtxt(){
 textAlign(LEFT);
 textSize(15);
 text("1-rainbow, 2-wavy",0,height-3);
}

Arc[] wavy(int n, int x, int y, int rad){
  
   Arc[] wavearr = new Arc[n];
  
  for(int i=0; i<n; i++){
     wavearr[i]=new Arc(x,y,rad-20*i);
    wavearr[i].k+=(i/13f);
    wavearr[i].col = color(180-i*3,255,255);
    //wavearr[i].q+=(1/100f);
  }
  
 return wavearr;
}

Arc[] rainbow(int n, int x, int y, int rad){
  
 Arc[] rainbowarr = new Arc[n];
  
  for(int i=0; i<n; i++){
     rainbowarr[i]=new Arc(x,y,rad-20*i);
    rainbowarr[i].col=color(i*(30),255,255);
  }
  
 return rainbowarr;
}

void keyPressed(){
  switch(key){
    case '1': { a=rainbow(7,0,0,400); break;}
    case '2': {a=wavy(20,0,0,400); break; }
  }
}
