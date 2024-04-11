import peasy.*;
import javax.swing.JFrame;

PeasyCam cam;
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage stars;

ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Stjerne> stjernes = new ArrayList<>();
ArrayList<SortHul> sorthuls = new ArrayList<>();



boolean openMenu = false;
boolean spaceIsPressed = false;
boolean rightIsPressed = false;

double cameraDistance = 0;
float saveMouseX = 0;
float saveMouseY = 0;
float interval = 20;
float objektNr = 1;
float [] cameraPos = new float[0];
float [] cameraRotation = new float[0];
float [] cameraLookAt = new float[0];

PVector s1 = new PVector(0, (-0.03)*interval);

PGraphics ui;

void setup() {
  fullScreen(P3D);
  noStroke();
  frameRate(100);

  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(160);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(2000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setDistance(400);

  //Loader baggrunden
  stars = loadImage("space.jpg");
  universe = createShape(SPHERE, 2000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(stars);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html

  //Tilføjer Planeter
  planets.add(new Planet(2*pow(10, 30), 0, 0, 20));
  planets.add(new Planet(5*pow(10, 24), 200, 0, 10));

  //Giver planet nr.2 en starthastighed
  planets.get(1).setSpeed(s1);

  ui = createGraphics(100, 200, P2D);
}

void draw() {
  background(0); //resetter canvassen

  pushMatrix();
  translate(0, 0, 0);
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



  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3

  if (openMenu) {
    cam.beginHUD();
    ui.beginDraw();
    ui.background(60);
    ui.endDraw();
    image(ui, saveMouseX, saveMouseY);
    cam.endHUD();
 }

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    if (!rightIsPressed) {
    openMenu = true;
    saveMouseX = mouseX;
    saveMouseY = mouseY;
    cam.setMouseControlled(false);
    rightIsPressed = true;
    } else {
    }
  } else {
    if (openMenu) {
      if (mouseX < saveMouseX || mouseX > saveMouseX+100 || mouseY < saveMouseY || mouseY > saveMouseY+200) {
      cam.setMouseControlled(true);
      rightIsPressed = false;
      openMenu = false;
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    if (!spaceIsPressed) {
      cameraFreeze(false);
    } else {
      cameraFreeze(true);
    }
  }
}

//funktion for kraftfordelingen i x-retningen
float kraftFordelingX(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((x2-x1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//funktion for kraftfordelingen i y-retningen
float kraftFordelingY(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((y2-y1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//omsætter meter til pixels
float mTilPixel(float distance) {
  return distance*200/(1499*pow(10, 8));
}

//omsætter pixels til meter
float pixelTilM(float distance) {
  return distance*(1499*pow(10, 8))/200;
}

//kamerahåndtagning
void cameraFreeze(boolean ind) {
  if (!ind) {
    //gemmer info, om kamera
    cameraRotation = cam.getRotations();
    cameraDistance = cam.getDistance();
    cameraLookAt = cam.getLookAt();

    //zoomer ud
    cam.setRotations(0, 0, 0);
    cam.setDistance(2000);
    cam.lookAt(0, 0, 0);

    //fryser kameraet
    cam.setMouseControlled(false);
    spaceIsPressed = true;
  } else {
    //restter info om kamera
    cam.setRotations(cameraRotation[0], cameraRotation[1], cameraRotation[2]);
    cam.setDistance(cameraDistance);
    cam.lookAt(cameraLookAt[0], cameraLookAt[1], cameraLookAt[2]);

    //resetter kamera-funktioner
    cam.setMouseControlled(true);
    spaceIsPressed = false;
  }
}
