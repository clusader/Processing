class Circle {

  int amount;
  float rad;
  PVector arr[];
  int flag;
  boolean mflag=false;
  boolean linesflag=true;
  int linesmod=100;
  int lineiter=50;
  float morphRate=0.05;
  float squareRad;
  float k=5;

  Circle(int n, float r) {
    rad=r; 
    amount=n;
    arr= new PVector[amount];
    this.circ(arr);
    squareRad=rad/sqrt(PI);
  }




  void show() {
    fill(255, 100, 200);
    float x;
    float y;

    for (int i=0; i<amount; i++) {
      x=arr[i].x;
      y=arr[i].y;
      noStroke();
      fill(x, 100, 200, 200);
      ellipse(x, y, k, k);
      }
    
      if(linesflag){
        int count=1;
        stroke(255,100);
        for(int j=0; j<lineiter; j++){
          
              line(arr[count%amount].x,arr[count%amount].y,arr[(count*linesmod)%amount].x,arr[(count*linesmod)%amount].y);
              count=(count+linesmod)%amount;//(count*(linesmod)%amount)%amount;
    }
  }
      
    if (mflag)
      this.premorph();
    //stroke(255);
    //line(0, 0, rad, 0);
  }

  PVector[] circ(PVector[] oarr) {
    float angle = TWO_PI/amount;
    for (int i=0; i<amount; i++) {
      oarr[i]=new PVector(rad*cos(angle*i), rad*sin(angle*i));
    }
    if (oarr==arr)
      flag=0;
    return oarr;
  }

  PVector[] square(PVector[] oarr) {
    int seg = (int)(amount/4);  //partition the amount for sides.
    float orad=squareRad;
    for (int j=0; j<4; j++) {//for each side
      for (int i=0; i<seg; i++) {
        float a=i*2*4*orad/amount;
        /*Build Right Side*/
        if (j==0)
          oarr[i+j*seg]=new PVector(orad, -orad +a);
        /*Build Down*/
        else if (j==1)
          oarr[i+j*seg]=new PVector(orad -a, orad);
        /*Build Left*/
        else if (j==2)
          oarr[i+j*seg]=new PVector(-orad, orad  -a);
        /*Build Up*/
        else
          oarr[i+j*seg]=new PVector(-orad +a, -orad);
      }
    }
    if (oarr==arr)
      flag=1;

    return oarr;
  }

  PVector[] randomize(PVector[] oarr) {
    for (int i=0; i<amount; i++) {
      oarr[i]=new PVector(random(-500, 500), random(-500, 500));
    }
    if (oarr==arr)
      flag=0;
    return oarr;
  }

  void premorph() {
    PVector arrcopy[] = new PVector[amount];

    for (int i=0; i<amount; i++) {  //Deep Copy
      arrcopy[i]=new PVector(arr[i].x, arr[i].y);
    }
    if (this.flag==0) this.square(arrcopy); //If circle 
    else if (this.flag==1) this.circ(arrcopy); //If square
    else if (this.flag==2) this.randomize(arrcopy);  //random point allocation

    this.morph(arrcopy);
  }


  void morph(PVector[] arrc) {

    for (int i=0; i<amount; i++) {
      PVector p;
      float x=lerp(arr[i].x, arrc[i].x, morphRate);
      float y=lerp(arr[i].y, arrc[i].y, morphRate);
      p=new PVector(x, y);
      arr[i]=p;
    }
    boolean isAllFinished=true;
    for (int i=0; i<amount; i++) {
      if (dist(arr[i].x, arr[i].y, arrc[i].x, arrc[i].y)>0.1)
        isAllFinished=false;
    }
    if (isAllFinished) {
      mflag=false; 
      flag=1-flag;
    }
  }
}
