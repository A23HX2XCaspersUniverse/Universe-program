import peasy.*; 

PeasyCam cam; 
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage stars;

ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Stjerne> stjernes = new ArrayList<>();

PVector s1 = new PVector(0, -0.5);

boolean openMenu = false;

float saveMouseX = 0;
float saveMouseY = 0;
float[] cameraPos = new float[0];

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
  
  stjernes.add(new Stjerne(5000000000000L,0,0,20));
  planets.add(new Planet(25000000000L,200,0,10));
  
  
  planets.get(0).setSpeed(s1);
}

void draw() {
  background(0); //resetter canvassen
  
  pushMatrix();
  translate(0,0,0);
  shape(universe); //laver en globusformet baggrund med stjerner
  popMatrix();
  
  //opdaterer objektet "planet"
  for (Planet planet : planets) {
    planet.update();
  }
  for (Stjerne stjerne : stjernes) {
    stjerne.update();
  }
  
  // beregner tyngdekraftens påvirkning
  for (Planet planet : planets) {
    planet.tyngdekraft();
  }
  for (Stjerne stjerne : stjernes) {
    stjerne.tyngdekraft();
  }
  
  
  /* DOESNT WORK!
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  
  cameraPos = new float[0];
  cameraPos = cam.getPosition();
  if (openMenu) {
    fill(0);
    pushMatrix();
    rect(cameraPos[0],cameraPos[1],cameraPos[2]-2,100,200);
    popMatrix();
  }
  println("Distance: "+cam.getDistance()+"   cameraPosX: "+cameraPos[0]+"   cameraPosY: "+cameraPos[1]+"   cameraPosZ: "+cameraPos[2]);
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  */ 
  
  if (key == 'n') {
  }
  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    openMenu = true;
    saveMouseX = mouseX;
    saveMouseY = mouseY;
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
