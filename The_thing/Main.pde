import peasy.*; 

PeasyCam cam; 

void setup() {
  fullScreen(P3D);
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(50);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(5000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
}

void draw() {
  background(0); //resetter canvassen
  strokeWeight(5); 
  stroke(255, 90);
  noFill(); 
  translate(0, 0, 0);
  sphere(20); 
}
