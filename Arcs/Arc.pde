class Arc{

float x,y,r;//,sa,fa;
float k,q,w;
color col = color(255,255,255);

    /*Constructor*/
 public Arc(float ox, float oy, float or){
             //float osa, float ofa){
             x=ox; y=oy; r=or;
             k=0; q=0.01;
            // sa=osa; fa=ofa;
             }
  
 public void show(){
   stroke(col);
  arc(x,y,r,r,0,w);
   oscilate();
 }
 
 public void oscilate(){
  k+=q;
  if(k>=PI) k=0;
  w=abs((sin(k))*PI);
 }
}
