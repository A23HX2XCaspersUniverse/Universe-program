import peasy.*;
import javax.swing.JFrame;

PeasyCam cam; 
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage stars;

ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Stjerne> stjernes = new ArrayList<>();
ArrayList<SortHul> sorthuls = new ArrayList<>();

PVector s1 = new PVector(0, (-0.03)*20);

boolean openMenu = false;
boolean nIsPressed = false;

float saveMouseX = 0;
float saveMouseY = 0;
float[] cameraPos = new float[0];

void setup() {
  fullScreen(P3D);
  noStroke();
  
  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(160);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(2000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setDistance(200);
  
  stars = loadImage("space.jpg");
  universe = createShape(SPHERE, 2000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(stars);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  
  planets.add(new Planet(2*pow(10,30),0,0,20));
  planets.add(new Planet(5*pow(10,24),200,0,10));
  //sorthuls.add(new SortHul(2*pow(10,30),-200,0));
  
  planets.get(1).setSpeed(s1);
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
  for (SortHul sorthul : sorthuls) {
    sorthul.update();
  }
  
  // beregner tyngdekraftens påvirkning
  for (Planet planet : planets) {
    planet.tyngdekraft();
  }
  for (Stjerne stjerne : stjernes) {
    stjerne.tyngdekraft();
  }
  for (SortHul sorthul : sorthuls) {
    sorthul.tyngdekraft();
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
  
  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    openMenu = true;
    saveMouseX = mouseX;
    saveMouseY = mouseY;
  }
}

void keyPressed() {
  if (key == 'n') {
    JFrame window = new JFrame();
    window.setVisible(true);
    }
}

//funktion for kraftfordelingen i x-retningen
float kraftFordelingX(float x1, float x2, float y1, float y2, float kraft){
  return (kraft * ((x2-x1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//funktion for kraftfordelingen i y-retningen
float kraftFordelingY(float x1, float x2, float y1, float y2, float kraft){
  return (kraft * ((y2-y1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

float mTilPixel(float distance) {
  return distance*200/(1499*pow(10,8));
}

float pixelTilM(float distance) {
  return distance*(1499*pow(10,8))/200;
}
