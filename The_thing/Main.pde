import peasy.*; 

PeasyCam cam; 
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage stars;
ArrayList<Planet> planets = new ArrayList<>();

void setup() {
  fullScreen(P3D);
  noStroke();
  
  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(50);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(2000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  
  stars = loadImage("space.jpg");
  universe = createShape(SPHERE, 2000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(stars);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  
  planets.add(new Planet(100,0,0,20));
  planets.add(new Planet(50,200,0,10));
}

void draw() {
  background(0); //resetter canvassen
  
  pushMatrix();
  translate(0,0,0);
  shape(universe); //laver en globusformet baggrund med stjerner
  popMatrix();
  
  //opdaterer planeternes position
  for (Planet planet : planets) {
    planet.update(); //opdaterer objektet "planet"
  }
  
}

//funktion for kraftfordelingen i x-retningen
float kraftFordelingX(float x1, float x2, float y1, float y2, float kraft){
  return (kraft * (x2-x1)/( abs(x2-x1)+abs(y2-y1)));
}

//funktion for kraftfordelingen i y-retningen
float kraftFordelingY(float x1, float x2, float y1, float y2, float kraft){
  return (kraft * (y2-y1)/( abs(x2-x1)+abs(y2-y1)));
}
