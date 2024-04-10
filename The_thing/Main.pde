import peasy.*; 

PeasyCam cam; 
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage stars;
ArrayList<Planet> planets = new ArrayList<>();

void setup() {
  fullScreen(P3D);
  noStroke();
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(50);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(2000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  
  stars = loadImage("space.jpg");
  universe = createShape(SPHERE, 2000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(stars);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  
  planets.add(new Planet(100,0,0,20));
  planets.add(new Planet(100,200,0,10));
  
}

void draw() {
  background(0); //resetter canvassen
  shape(universe); //laver en globusformet baggrund med stjerner
  for (Planet planet : planets) {
    planet.update(); //opdaterer objektet "planet"
  }
}
