import peasy.*;
import javax.swing.JFrame;

PeasyCam cam;
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage stars;

ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Stjerne> stjernes = new ArrayList<>();
ArrayList<SortHul> sorthuls = new ArrayList<>();



boolean openCreateMenu = false;
boolean spaceIsPressed = false;
boolean create = false;
boolean freezeMovement = false;
boolean quit = false;

int menuWidth = 120;
int menuHeight = 139;

double cameraDistance = 0;

float saveMouseX = 0;
float saveMouseY = 0;
float interval = 10;
float objektNr = 1;

float [] cameraPos = new float[0];
float [] cameraRotation = new float[0];
float [] cameraLookAt = new float[0];

PVector s1 = new PVector(0, (-0.03)*interval);

PGraphics ui;
PGraphics qui;

PFont font;

void setup() {
  fullScreen(P3D);
  noStroke();
  frameRate(100);

  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(160);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(2000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setDistance(200);

  //Loader baggrunden
  stars = loadImage("space.jpg");
  universe = createShape(SPHERE, 2000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(stars);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html

  //Tilføjer Planet og stjerne
  stjernes.add(new Stjerne(2*pow(10, 30), 0, 0, 10));
  planets.add(new Planet(5*pow(10, 24), 100, 0, 5));
  planets.add(new Planet(5*pow(10, 29), -100, -200, 9));

  //Giver planet nr.2 en starthastighed
  planets.get(0).setSpeed(s1);

  ui = createGraphics(menuWidth, menuHeight, P2D);
  qui = createGraphics(width, height, P2D);
  
  font = createFont("Spaceboardsdemo-8MyRB.otf", 32);
  qui.textFont(font);
  
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
    
  }
  
  //tegner objekter
  for (Planet planet : planets) {
      planet.objektDraw();
    }
    for (Stjerne stjerne : stjernes) {
      stjerne.objektDraw();
    }
    for (SortHul sorthul : sorthuls) {
      sorthul.objektDraw();
    }



  if (openCreateMenu) {
    createMenu();
  }
  
  
  if (quit) {
    quitMenu();
  }
  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    if (!create && !quit) {
      if (mouseX < width-menuWidth && mouseY < height -menuHeight) {
        saveMouseX = mouseX;
        saveMouseY = mouseY;
      } else if (mouseX < width-menuWidth) {
        saveMouseX = mouseX;
        saveMouseY = height-menuHeight;
      } else if (mouseY < height-menuHeight) {
        saveMouseX = width-menuWidth;
        saveMouseY = mouseY;
      } else {
        saveMouseX = width-menuWidth;
        saveMouseY = height-menuHeight;
      }

      openCreateMenu = true;
      cam.setMouseControlled(false);
    }
  } else { /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (openCreateMenu) {
      if (mouseX < saveMouseX || mouseX > saveMouseX+menuWidth || mouseY < saveMouseY || mouseY > saveMouseY+menuHeight) {
        cam.setMouseControlled(true);
        openCreateMenu = false;
      } else if (knap(saveMouseX, saveMouseY+39, menuWidth, 50)) {
        openCreateMenu = false;
        create = true;
        cameraFreeze(true);
      }
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
  } else if (key == ESC) {
    if (!freezeMovement) {
      freezeMovement = true;
      quit = true;
      cam.setMouseControlled(false);
    } else {
      freezeMovement = false;
      quit = false;
      cam.setMouseControlled(true);
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
float kraftFordelingX(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((x2-x1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//funktion for kraftfordelingen i y-retningen
float kraftFordelingY(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((y2-y1)*149900000/200)/( (abs(x2-x1)+abs(y2-y1))*149900000/200));
}

//omsætter meter til pixels
float mTilPixel(float distance) {
  return distance*100/(1499*pow(10, 8));
}

//omsætter pixels til meter
float pixelTilM(float distance) {
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

//funktion for knap
boolean knap(float x, float y, float l, float h) {
  return (mouseX > x && mouseX < x+l && mouseY > y && mouseY < y+h);
}
