import peasy.*;
import javax.swing.JFrame;

PeasyCam cam;
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage milkyWay;

ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Star> stars = new ArrayList<>();
ArrayList<BlackHole> blackholes = new ArrayList<>();
ArrayList<Textbox> textboxes = new ArrayList<>();

boolean objectMenu = false;
boolean spaceIsPressed = false;
boolean tabIsPressed = false;
boolean create = false;
boolean freezeMovement = false;
boolean quit = false;
boolean isPlaced = false;
boolean chooseDirection = false;
boolean infoNeeded = false;
boolean sideMenu = true;

int objektMenuWidth = 125;
int objektMenuHeight = 189;
int createMenuWidth = 800;
int createMenuHeight = 530;
int sideMenuWidth = 300;
int count = 0;

double cameraDistance = 0;

float saveMouseX = 0;
float saveMouseY = 0;
float interval = 10;

String objectType = "";

float [] cameraPos = new float[0];
float [] cameraRotation = new float[0];
float [] cameraLookAt = new float[0];
float [] cameraLookAtUpdater = new float[0];

PVector s1 = new PVector(0, 0);
PVector lookAt = new PVector(0, 0, 0);
PVector direction = new PVector();

PGraphics oui;
PGraphics qui;
PGraphics cui;
PGraphics sui;

PFont font, font2;

void setup() {
  //
  fullScreen(P3D);
  noStroke();
  frameRate(60);

  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(160);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(3000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setDistance(200);

  //Loader baggrunden
  milkyWay = loadImage("space1.jpg");
  universe = createShape(SPHERE, 6000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(milkyWay);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html

  //Tilføjer Planet og stjerne
  stars.add(new Star(2*pow(10, 30), 0, 0, mToPixel(14000000000L), s1));
  planets.add(new Planet(5*pow(10, 24), -100, -200, mToPixel(7000000000L), s1));
  blackholes.add(new BlackHole(200*pow(10, 30), -900, 0, s1));

  //initierer og deklarerer tekstbokse som senere bruges
  textboxes.add(new Textbox(50, 180, 100, 30));
  textboxes.add(new Textbox(50, 330, 200, 30));
  textboxes.add(new Textbox(createMenuWidth-280, 180, 200, 30));
  textboxes.add(new Textbox(155+64, 180, 35, 30));

  //sørger for at tekstboksene kun kan indeholde tal
  for (Textbox textbox : textboxes) {
    textbox.setToNumbersOnly(true);
  }

  //Deklarerer alle grafiske flader (Menuerne)
  oui = createGraphics(objektMenuWidth, objektMenuHeight, P2D);
  qui = createGraphics(width, height, P2D);
  cui = createGraphics(createMenuWidth, createMenuHeight, P2D);
  sui = createGraphics(sideMenuWidth, height, P2D);

  //deklarerer de to fonte der bliver brugt
  font = createFont("MotionControl-BoldItalic.otf", 100);
  font2 = createFont("Roboto-Bold.ttf", 100);
}

void draw() {
  background(0); //resetter canvassen

  pushMatrix();
  //sørger for at universet følger med kamerateret, så man ikke lige pludselige kommer ud af universet.
  cameraLookAtUpdater = cam.getLookAt();
  lookAt.x = cameraLookAtUpdater[0];
  lookAt.y = cameraLookAtUpdater[1];
  lookAt.z = cameraLookAtUpdater[2];

  //tegner en globusformet baggrund med stjerner
  translate(lookAt.x, lookAt.y, lookAt.z);
  shape(universe);
  popMatrix();


  if (!freezeMovement) { //tjekker om planeternes bevægelse er stoppet

    //Opdaterer nummeret på objekter
    for (Planet planet : planets) {
      planet.setNr(count);
      count++;
    }
    count = 0;
    for (Star star : stars) {
      star.setNr(count);
      count++;
    }
    count = 0;
    for (BlackHole blackhole : blackholes) {
      blackhole.setNr(count);
      count++;
    }
    count = 0;


    //opdaterer objekternes position
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



  if (objectMenu) { //tjekker om objekt menuen skal åbnes

    objectMenu();
  } else if (quit) { //tjekker om brugeren er på vej ud af programmet

    quitMenu();
  } else if (create) { //tjekker om brugeren er ved at lave et nyt objekt

    if (isPlaced) { //tjekker om placering af det ønskede objekt er valgt
      if (!chooseDirection) { //tjekker om brugeren er ved at vælge en direktion for startbevægelsen

        createMenu();
      } else {

        //opdaterer parametrer for direktionen af startbevægelsen
        direction.x = ((mouseX-width/2)*3.20987654-saveMouseX)/( abs((mouseX-width/2)*3.20987654-saveMouseX)+abs((mouseY-height/2)*3.20987654-saveMouseY));
        direction.y = ((mouseY-height/2)*3.20987654-saveMouseY)/( abs((mouseX-width/2)*3.20987654-saveMouseX)+abs((mouseY-height/2)*3.20987654-saveMouseY));

        //viser visuelt hvilken retning startbevægelsen har
        pushMatrix();
        translate(saveMouseX, saveMouseY, 0);
        fill(#964B00);
        sphere(20);
        popMatrix();

        strokeWeight(2);
        stroke(255);
        line (saveMouseX, saveMouseY, 20, (mouseX-width/2)*3.20987654, (mouseY-height/2)*3.20987654, 20);
        noStroke();
      }
    } else {

      if (!chooseDirection) { //tjekker om brugeren er ved at vælge en direktion for startbevægelsen

        // visuelt viser placeringen af objektet, når brugeren vælger placeringen
        pushMatrix();
        translate((mouseX-width/2)*3.20987654, (mouseY-height/2)*3.20987654, 0);
        fill(#964B00);
        sphere(20);
        popMatrix();
      }
    }
  }


  if (sideMenu) { //tjekker om sidemenuen er åben
    sideMenu();
  }
}



/////////////////////////////////////////////////////////////////// Funktioner //////////////////////////////////////////////////////////////////

void mousePressed() {
  if (mouseButton == RIGHT) { //tjekker om det er højreklik

    if (!create && !quit) { //tjekker om brugeren er på vej ud af programmet eller om brugeren er ved at skabe et nyt objekt
      if (mouseX > sideMenuWidth) { //tjekker om musen er uden fra side menuen

        //åbner objekt menuen ved musens placering. Men sørger for at uanset hvad kan menuen altid ses
        if (mouseX < width-objektMenuWidth && mouseY < height -objektMenuHeight) { //tjekker om musens placering er længere oppe fra bunden end objektmenuens højde, samt længer til venstre end menuens bredde
          saveMouseX = mouseX;
          saveMouseY = mouseY;
        } else if (mouseX < width-objektMenuWidth) { //tjekker om musen er længere til venstre end objekt menuens bredde
          saveMouseX = mouseX;
          saveMouseY = height-objektMenuHeight;
        } else if (mouseY < height-objektMenuHeight) { //tjekker om musen er højere oppe fra bunden end objekt menuens højde
          saveMouseX = width-objektMenuWidth;
          saveMouseY = mouseY;
        } else {
          saveMouseX = width-objektMenuWidth;
          saveMouseY = height-objektMenuHeight;
        }

        //åbner objekt menuen samt musens kontrol over det 3 dimensionelle univers
        objectMenu = true;
        cam.setMouseControlled(false);
      }
    }
  } else if (mouseButton == LEFT) { //tjekker om der er fåretaget et venstreklik (unødvendig, men gør det nemmere for mig at spotte når jeg koder)

    if (objectMenu) { //tjekker om objekt menuen er åben
      if (mouseX < saveMouseX || mouseX > saveMouseX+objektMenuWidth || mouseY < saveMouseY || mouseY > saveMouseY+objektMenuHeight) { //tjekker om musen er uden for menuen

        //lukker menuen
        cam.setMouseControlled(true);
        objectMenu = false;
      } else if (hoverOver(saveMouseX, saveMouseY+39, objektMenuWidth, 50)) { //tjekker om musen er over "planet" knappen
        //åbner create menuen for planeter
        createMenuSetup(1);
        sideMenu = false;
      } else if (hoverOver(saveMouseX, saveMouseY+89, objektMenuWidth, 50)) { //tjekker om musen er over "stjerne" knappen
        //åbner create menuen for planeter
        createMenuSetup(2);
        sideMenu = false;
      } else if (hoverOver(saveMouseX, saveMouseY+139, objektMenuWidth, 50)) { //tjekker om musen er over "sort hul" knappen
        //åbner create menuen for planeter
        createMenuSetup(3);
        sideMenu = false;
      }
    } else if (quit) { //tjekker om brugeren er på vej ud af programmet

      if (hoverOver(width/2-400, height/2+100, 200, 100)) { //tjekker om musen er over knappen "Yes"
        exit(); //luk programmet
      } else if (hoverOver(width/2+200, height/2+100, 200, 100)) { //tjekker om musen er over knappen "No"
        //luk quit menuen
        freezeMovement = false;
        quit = false;
        cam.setMouseControlled(true);
      }
    } else if (create) { //tjekker om brugeren er ved at skabe et nyt objekt
      if (!isPlaced) { //tjekker om brugeren har valgt placeringen af objektet

        //gemmer placeringen
        saveMouseX = (mouseX-width/2)*3.20987654;
        saveMouseY = (mouseY-height/2)*3.20987654;
        isPlaced = true;
      } else {

        if (!chooseDirection) {//tjekker om brugeren er ved at bestemme retning for startbevægelsen
          for (Textbox textbox : textboxes) {
            if (hoverOver(textbox.getX()+width/2-createMenuWidth/2, textbox.getY()+height/2-createMenuHeight/2,
              textbox.getWidth(), textbox.getHeight())) { //tjekker om musen er over en tekstboks

              textbox.setSelected(true);
            } else {
              textbox.setSelected(false);
            }
          }
          if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-260, height/2-createMenuHeight/2+240, 160, 50)) {
            chooseDirection = true;
          } else if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-150, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) {
            closeCreateMenu();
          } else if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-300, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) {
            if (!textboxes.get(2).getText().equals("")) {
              direction.x *= float(textboxes.get(2).getText());
              direction.y *= float(textboxes.get(2).getText());
            } else {
              direction.x = 0;
              direction.y = 0;
            }
            if (!textboxes.get(0).getText().equals("") && !textboxes.get(1).getText().equals("") &&
              !textboxes.get(3).getText().equals("")) {
                
              if (float(textboxes.get(0).getText()) > 200) {
                textboxes.get(0).setText("200");
              }
              if (float(textboxes.get(3).getText()) > 30) {
                textboxes.get(3).setText("30");
              }
              
              if (objectType.equals("planet")) {
                planets.add(new Planet(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())), saveMouseX, saveMouseY, mToPixel(1000*float(textboxes.get(1).getText())), direction));
                closeCreateMenu();
              }
              if (objectType.equals("star")) {
                stars.add(new Star(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())), saveMouseX, saveMouseY, mToPixel(1000*float(textboxes.get(1).getText())), direction));
                closeCreateMenu();
              }
            } else  if (objectType.equals("black hole") && !textboxes.get(0).getText().equals("") && !textboxes.get(3).getText().equals("")) {
              
              if (float(textboxes.get(0).getText()) > 200) {
                textboxes.get(0).setText("200");
              }
              if (float(textboxes.get(3).getText()) > 30) {
                textboxes.get(3).setText("30");
              }
              
              blackholes.add(new BlackHole(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())), saveMouseX, saveMouseY, direction));
              closeCreateMenu();
            } else {
              infoNeeded = true;
            }
          }
        } else {
          chooseDirection = false;
          cameraFreeze(true);
        }
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
  } else if (key == TAB && !create && !quit) {
    if (!tabIsPressed) {
      freezeMovement = true;
      tabIsPressed = true;
    } else {
      freezeMovement = false;
      tabIsPressed = false;
    }
  } else if (create) {
    if (key == ESC) {
      closeCreateMenu();
    } else {
      for (Textbox textbox : textboxes) {
        if (textbox.getSelected()) {
          if (key == ENTER) {
            textbox.setSelected(false);
          } else if (key == BACKSPACE) {
            textbox.deleteChracter();
          } else {
            textbox.addToText(key);
          }
        }
      }
    }
  } else if (quit) {
    if (key == ESC) {
      freezeMovement = false;
      quit = false;
      cam.setMouseControlled(true);
    } else if (key == ENTER) {
      exit();
    }
  } else {
    if (key == ESC) {
      freezeMovement = true;
      quit = true;
      objectMenu = false;
      cam.setMouseControlled(false);
    } else if (key == 'p') {
      if (!freezeMovement) {
        freezeMovement = true;
      } else {
        freezeMovement = false;
      }
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
  return (kraft * ((x2-x1)/( (abs(x2-x1)+abs(y2-y1)))));
}

//funktion for kraftfordelingen i y-retningen
float forceDistributionY(float x1, float x2, float y1, float y2, float kraft) {
  return (kraft * ((y2-y1)/( (abs(x2-x1)+abs(y2-y1)))));
}

//omsætter meter til pixels
float mToPixel(float distance) {
  return distance*300/(1499*pow(10, 8));
}

//omsætter pixels til meter
float pixelToM(float distance) {
  return distance*(1499*pow(10, 8))/300;
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
boolean hoverOver(float x, float y, float l, float h) {
  return (mouseX > x && mouseX < x+l && mouseY > y && mouseY < y+h);
}

void createMenuSetup(int object) {
  objectMenu = false;
  create = true;
  cameraFreeze(true);
  freezeMovement = true;
  if (object == 1) {
    objectType = "planet";
  } else if (object == 2) {
    objectType = "star";
  } else if (object == 3) {
    objectType = "black hole";
  }
}

void closeCreateMenu() {
  create = false;
  cameraFreeze(false);
  freezeMovement = false;
  isPlaced = false;
  cursor(ARROW);
  for (Textbox textbox : textboxes) {
    textbox.setText("");
  }
  infoNeeded = false;
  sideMenu = true;
}
