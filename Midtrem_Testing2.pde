import processing.video.*;

Capture cam;

color[] targetColor = new color[2];

int ChangeIndex = 0;

int Position1x,Position1y,Position2x,Position2y;
void setup(){
  
  
  println(Capture.list());
  
  size(1024,768);
  cam = new Capture(this,width,height,33);
  
  cam.start();
  smooth();
  
  targetColor[0] = color(255,0,0);
  targetColor[1] = color(255,0,0);
  textSize(16);
}

void draw()
{
  if(cam.available()){
    cam.read();
  }
  
  
  fill(targetColor[ChangeIndex]);
  rect(0,0,50,50);
         
  cam.loadPixels(); 
  image(cam,0,0);
  
  
  
  float similarity = 1000;
  int closetX = 0;
  int closetY = 0;
  
  for(int x=0;x<cam.width;x++){
    for(int y=0;y<cam.height;y++){
      
      int index = x+y*cam.width;
      
      color currentColor = cam.pixels[index];
      
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      
      float r2 = red(targetColor[ChangeIndex]);
      float g2 = green(targetColor[ChangeIndex]);
      float b2 = blue(targetColor[ChangeIndex]);
      
      // euclidean distance
      float d = dist(r1,g1,b1,r2,g2,b2);
      //println(d);
      if(d<similarity){
        similarity = d;
        closetX = x;
        closetY = y;
      }

  }
    // threshold
    if(similarity < 10){
         
         fill(targetColor[ChangeIndex]);
         strokeWeight(2.0);
         stroke(0);
         
         //stroke(204,102,0);
         
         rect(closetX,closetY,50,50);
         //IndexChager();
    }
 }   
  Showdata();
}
   
void mousePressed(){
    targetColor[ChangeIndex] = cam.pixels[mouseX+mouseY*cam.width];

}

void IndexChager(){
         if(ChangeIndex == 0){
             ChangeIndex = 1;
         }else if (ChangeIndex == 1){
             ChangeIndex = 0;
         }
}
void Showdata(){
   float Far = dist(Position1x,Position1y,Position2x,Position2y);
   text("1st Color = x = " + Position1x + " y = " + Position1y , 10 , 50);
   text("2nd Color = x = " + Position2x + " y = " + Position2y, 10 , 100);
   text("distance" + Far, 10 , 150);
}
      /*if(ChangeIndex == 0){
          Position1x = x;
          Position1y = y;
      }else if (ChangeIndex == 1){
          Position2x = x;
          Position2y = y;
      }*/
