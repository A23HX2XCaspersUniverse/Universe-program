import peasy.*;
import javax.swing.JFrame;

PeasyCam cam;
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage milkyWay;

ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Star> stars = new ArrayList<>();
ArrayList<BlackHole> blackholes = new ArrayList<>();



boolean objectMenu = false;
boolean spaceIsPressed = false;
boolean create = false;
boolean freezeMovement = false;
boolean quit = false;
boolean isPlaced = false;

int objektMenuWidth = 125;
int objektMenuHeight = 189;
int createMenuWidth = 800;
int createMenuHeight = 600;

double cameraDistance = 0;

float saveMouseX = 0;
float saveMouseY = 0;
float interval = 10;
float objektNr = 1;

float [] cameraPos = new float[0];
float [] cameraRotation = new float[0];
float [] cameraLookAt = new float[0];

PVector s1 = new PVector(0, (-0.03)*interval);

PGraphics oui;
PGraphics qui;
PGraphics cui;

PFont font, font2;

void setup() {
  fullScreen(P3D);
  noStroke();
  frameRate(100);

  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(160);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(30000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setDistance(200);

  //Loader baggrunden
  milkyWay = loadImage("space1.jpg");
  universe = createShape(SPHERE, 6000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(milkyWay);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html

  //Tilføjer Planet og stjerne
  stars.add(new Star(2*pow(10, 30), 0, -2000, 10));
  //planets.add(new Planet(5*pow(10, 24), 100, 0, 5));
  //planets.add(new Planet(5*pow(10, 29), -100, -200, 9));

  //Giver planet nr.2 en starthastighed
  //planets.get(0).setSpeed(s1);

  oui = createGraphics(objektMenuWidth, objektMenuHeight, P2D);
  qui = createGraphics(width, height, P2D);
  cui = createGraphics(createMenuWidth, createMenuHeight, P2D);

  font = createFont("MotionControl-BoldItalic.otf", 100);
  font2 = createFont("Roboto-Bold.ttf", 100);
}

void draw() {
  background(0); //resetter canvassen

  pushMatrix();
  translate(0, 0, 0);
  shape(universe); //laver en globusformet baggrund med stjerner
  popMatrix();

  if (!freezeMovement) {

    //opdaterer objektet "planet"
    for (Planet planet : planets) {
      planet.update();
    }
    for (Star star : stars) {
      star.update();
    }
    for (BlackHole blackhole : blackholes) {
      blackhole.update();
    }


    // beregner tyngdekraftens påvirkning
    for (Planet planet : planets) {
      planet.gravity();
    }
    for (Star star : stars) {
      star.gravity();
    }
    for (BlackHole blackhole : blackholes) {
      blackhole.gravity();
    }
  }

  //tegner objekter
  for (Planet planet : planets) {
    planet.objectDraw();
  }
  for (Star star : stars) {
    star.objectDraw();
  }
  for (BlackHole blackhole : blackholes) {
    blackhole.objectDraw();
  }



  if (objectMenu) {
    objectMenu();
  } else if (quit) {
    quitMenu();
  } else if (create) {
    if (isPlaced) {
      createMenu();
    } else {
      pushMatrix();
      translate((mouseX-width/2)*3.20987654, (mouseY-height/2)*3.20987654, 0);
      fill(255);
      sphere(20);
      popMatrix();
    }
  }

}

void mousePressed() {
  if (mouseButton == RIGHT) {

    if (!create && !quit) {
      if (mouseX < width-objektMenuWidth && mouseY < height -objektMenuHeight) {
        saveMouseX = mouseX;
        saveMouseY = mouseY;
      } else if (mouseX < width-objektMenuWidth) {
        saveMouseX = mouseX;
        saveMouseY = height-objektMenuHeight;
      } else if (mouseY < height-objektMenuHeight) {
        saveMouseX = width-objektMenuWidth;
        saveMouseY = mouseY;
      } else {
        saveMouseX = width-objektMenuWidth;
        saveMouseY = height-objektMenuHeight;
      }

      objectMenu = true;
      cam.setMouseControlled(false);
    }
  } else {             /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (objectMenu) {

      if (mouseX < saveMouseX || mouseX > saveMouseX+objektMenuWidth || mouseY < saveMouseY || mouseY > saveMouseY+objektMenuHeight) {
        cam.setMouseControlled(true);
        objectMenu = false;
      } else if (button(saveMouseX, saveMouseY+39, objektMenuWidth, 50)) {
        createMenuSetup(1);
      } else if (button(saveMouseX, saveMouseY+89, objektMenuWidth, 50)) {
        createMenuSetup(2);
      } else if (button(saveMouseX, saveMouseY+139, objektMenuWidth, 50)) {
        createMenuSetup(3);
      }
    } else if (quit) {

      if (button(width/2-400, height/2+100, 200, 100)) {
        exit();
      } else if (button(width/2+200, height/2+100, 200, 100)) {
        freezeMovement = false;
        quit = false;
        cam.setMouseControlled(true);
      }
    } else if (create && !isPlaced) {
      saveMouseX = mouseX;
      saveMouseY = mouseY;
      isPlaced = true;
    }
  }
}

void keyPressed() {
  if (key == ' ' && !create && !quit) {
    if (!spaceIsPressed) {
      cameraFreeze(true);
    } else {
      cameraFreeze(false);
    }
  } else if (key == DELETE) {
    exit();
  }else if (key == ESC) {

    if (!create) {
      if (!quit) {
        freezeMovement = true;
        quit = true;
        objectMenu = false;
        cam.setMouseControlled(false);
      } else {
        freezeMovement = false;
        quit = false;
        cam.setMouseControlled(true);
      }
    } else {
      create = false;
      cameraFreeze(false);
      freezeMovement = false;
    }
  }

  //https://forum.processing.org/two/discussion/575/stop-escape-key-from-closing-app-in-new-window-g4p.html
  switch(key) {
  case ESC:
    key = 0;
    break;
  }
}

//funktion for kraftfordelingen i x-retningen
float forceDistributionX(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((x2-x1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//funktion for kraftfordelingen i y-retningen
float forceDistributionY(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((y2-y1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//omsætter meter til pixels
float mToPixel(float distance) {
  return distance*100/(1499*pow(10, 8));
}

//omsætter pixels til meter
float pixelToM(float distance) {
  return distance*(1499*pow(10, 8))/100;
}

//kamerahåndtagning
void cameraFreeze(boolean ind) {
  if (ind) {
    //gemmer info, om kamera
    cameraRotation = cam.getRotations();
    cameraDistance = cam.getDistance();
    cameraLookAt = cam.getLookAt();

    //zoomer ud
    cam.setRotations(0, 0, 0);
    cam.setDistance(3000);
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

//funktion for knap
boolean button(float x, float y, float l, float h) {
  return (mouseX > x && mouseX < x+l && mouseY > y && mouseY < y+h);
}

void createMenuSetup(int objekt) {
  objectMenu = false;
  create = true;
  cameraFreeze(true);
  freezeMovement = true;
}
