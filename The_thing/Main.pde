import peasy.*;

//deklarering af en massse variabler

PeasyCam cam;
PShape universe; //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
PImage milkyWay;


ArrayList<Textbox> textboxes = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();
ArrayList<Sidebar> sidebars = new ArrayList<>();

boolean objectMenu = false;
boolean spaceIsPressed = false;
boolean tabIsPressed = false;
boolean create = false;
boolean freezeMovement = false;
boolean quit = false;
boolean isPlaced = false;
boolean chooseDirectionMode = false;
boolean infoNeeded = false;
boolean sideMenu = true;
boolean deleted = false;
boolean objectFocus = false;
boolean editMode = false;
boolean ringsAdded = false;

int objektMenuWidth = 125;
int objektMenuHeight = 189;
int createMenuWidth = 800;
int createMenuHeight = 530;
int sideMenuWidth = 400;
int count = 0;
int IDs = 1;
int sizeInterval = 3;
int objectOnFocus = 0;
int editID = 0;
int rotation = 0;

double cameraDistance = 0;

long animationSpeed = 0;

float saveMouseX = 0;
float saveMouseY = 0;
float interval = 20;
float barStart = 0;
float speedInterval = 1/1.2;

String objectType = "";

float [] cameraPos = new float[0];
float [] cameraRotation = new float[0];
float [] cameraLookAt = new float[0];
float [] cameraLookAtUpdater = new float[0];

PVector lookAt = new PVector(0, 0, 0);
PVector direction = new PVector();

PGraphics oui;
PGraphics qui;
PGraphics cui;
PGraphics sui;

PFont font, font2;

void setup() {
  fullScreen(P3D);
  noStroke();
  frameRate(200);

  //initiering af kameraet
  cam = new PeasyCam(this, 100); //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMinimumDistance(160);    //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setMaximumDistance(3000);  //http://wiki.bk.tudelft.nl/toi-pedia/Processing_3D_Navigation
  cam.setDistance(200);

  //Loader baggrunden
  milkyWay = loadImage("textures/space1.jpg");
  universe = createShape(SPHERE, 6000);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html
  universe.setTexture(milkyWay);  //https://forum.processing.org/two/discussion/22593/how-to-fill-the-sphere-with-the-earth-image.html

  //Tilføjer det virkelige solsystem
  objects.add(new Star(2*pow(10, 30), 0, 0, mToPixel(6963400000L*1.5*sizeInterval), new PVector(0, 0, 0), "", "sun"));
  objects.add(new Planet(3*pow(10, 23), mToPixel(68000000000L), 0, mToPixel(637100000L*2.5*sizeInterval), new PVector(0, -0.69*speedInterval, 0), "textures/Planet5.jpg", "mercury", false));
  objects.add(new Planet(5*pow(10, 24), 0, mToPixel(-108000000000L), mToPixel(637100000L*3*sizeInterval), new PVector(-0.55*speedInterval, 0, 0), "textures/Planet6.jpg", "venus", false));
  objects.add(new Planet(6*pow(10, 24), mToPixel(-150360000000L), 0, mToPixel(637100000L*4.5*sizeInterval), new PVector(0, 0.47*speedInterval, 0), "textures/Planet7.jpg", "earth", false));
  objects.add(new Planet(6*pow(10, 23), 0, mToPixel(228000000000L), mToPixel(637100000L*4*sizeInterval), new PVector(0.384*speedInterval, 0, 0), "textures/Planet8.jpg", "mars", false));
  objects.add(new Planet(2*pow(10, 27), 0, mToPixel(-484000000000L), mToPixel(637100000L*8*sizeInterval), new PVector(-0.265*speedInterval, 0, 0), "textures/Planet3.jpg", "jupiter", false));
  objects.add(new Planet(6*pow(10, 26), mToPixel(-750000000000L), 0, mToPixel(637100000L*8*sizeInterval), new PVector(0, 0.21*speedInterval, 0), "textures/Planet10.jpg", "saturn", true));
  objects.add(new Planet(9*pow(10, 25), 0, mToPixel(1000000000000L), mToPixel(637100000L*6.5*sizeInterval), new PVector(0.185*speedInterval, 0, 0), "textures/Planet11.jpg", "uranus", false));
  objects.add(new Planet(1*pow(10, 26), mToPixel(1300000000000L), 0, mToPixel(637100000L*7*sizeInterval), new PVector(0, -0.165*speedInterval, 0), "textures/Planet12.jpg", "neptune", false));
  objects.add(new Planet(1*pow(10, 22), 0, mToPixel(-1600000000000L), mToPixel(637100000L*sizeInterval), new PVector(-0.145*speedInterval, 0, 0), "textures/Planet13.jpg", "pluto", false));

  //initierer og deklarerer tekstbokse som senere bruges
  textboxes.add(new Textbox(50, 180, 100, 30));
  textboxes.add(new Textbox(50, 320, 200, 30));
  textboxes.add(new Textbox(createMenuWidth-280, 180, 200, 30));
  textboxes.add(new Textbox(155+64, 180, 50, 30));
  textboxes.add(new Textbox(createMenuWidth-280, 370, 200, 30));

  //sørger for at tekstboksene kun kan indeholde tal
  for (Textbox textbox : textboxes) {
    textbox.setToNumbersOnly(true);
  }

  textboxes.get(4).setToNumbersOnly(false);

  //Deklarerer alle grafiske flader (Menuerne)
  oui = createGraphics(objektMenuWidth, objektMenuHeight, P2D);
  qui = createGraphics(width, height, P2D);
  cui = createGraphics(createMenuWidth, createMenuHeight, P2D);
  sui = createGraphics(sideMenuWidth, height, P2D);

  //deklarerer de to fonte der bliver brugt
  font = createFont("fonts/MotionControl-BoldItalic.otf", 100);
  font2 = createFont("fonts/Roboto-Bold.ttf", 100);
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

  if (objectFocus) {
    for (Object object : objects) {
      if (object.getID() == objectOnFocus) {
        cam.lookAt(object.getX(), object.getY(), 0, animationSpeed);
        break;
      }
      count++;
    }
  }
  count = 0;


  if (!freezeMovement) { //tjekker om planeternes bevægelse er stoppet

    //Opdaterer nummeret på objekter
    for (Object object : objects) {
      object.setNr(count);
      count++;
    }
    count = 0;


    //opdaterer objekternes position
    for (Object object : objects) {
      object.update();
    }


    // beregner tyngdekraftens påvirkning
    for (int i = 0; i < objects.size(); i++) {
      objects.get(i).gravity();
    }
  }

  //tegner objekter
  for (Object object : objects) {
    object.objectDraw();
  }

  if (sideMenu) { //tjekker om sidemenuen er åben
    sideMenu();
  }


  if (objectMenu) { //tjekker om objekt menuen skal åbnes
    objectMenu();
  } else if (quit) { //tjekker om brugeren er på vej ud af programmet
    quitMenu();
  } else if (create) { //tjekker om brugeren er ved at lave et nyt objekt
    if (isPlaced) { //tjekker om placering af det ønskede objekt er valgt
      if (!chooseDirectionMode) { //tjekker om brugeren er ved at vælge en direktion for startbevægelsen
        createMenu();
      } else {
        chooseDirection();
      }
    } else {
      if (!chooseDirectionMode) { //tjekker om brugeren er ved at vælge en direktion for startbevægelsen
        placeObjectVisual();
      }
    }
  }
}






/////////////////////////////////////////////////////////////////// Funktioner //////////////////////////////////////////////////////////////////

void mousePressed() {
  if (mouseButton == RIGHT) { //tjekker om det er højreklik

    if (!create && !quit) { //tjekker om brugeren er på vej ud af programmet eller om brugeren er ved at skabe et nyt objekt
      if (mouseX > sideMenuWidth) { //tjekker om musen er uden fra side menuen

        objectMenuSetup();
      }
    }
  } else if (mouseButton == LEFT) { //tjekker om der er fåretaget et venstreklik (unødvendig, men gør det nemmere for mig at spotte når jeg koder)

    if (objectMenu) { //tjekker om objekt menuen er åben

      if (mouseX < saveMouseX || mouseX > saveMouseX+objektMenuWidth || mouseY < saveMouseY || mouseY > saveMouseY+objektMenuHeight) { //tjekker om musen er uden for menuen
        cam.setMouseControlled(true);//lukker menuen
        objectMenu = false;
      } else if (hoverOver(saveMouseX, saveMouseY+39, objektMenuWidth, 50)) { //tjekker om musen er over "planet" knappen
        createMenuSetup(1);//åbner create menuen for planeter
        sideMenu = false;
      } else if (hoverOver(saveMouseX, saveMouseY+89, objektMenuWidth, 50)) { //tjekker om musen er over "stjerne" knappen
        createMenuSetup(2);//åbner create menuen for stjerner
        sideMenu = false;
      } else if (hoverOver(saveMouseX, saveMouseY+139, objektMenuWidth, 50)) { //tjekker om musen er over "sort hul" knappen
        createMenuSetup(3);//åbner create menuen for sortehuller
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
        editMode = false;
      } else {

        if (!chooseDirectionMode) {//tjekker om brugeren er ved at bestemme retning for startbevægelsen
          for (Textbox textbox : textboxes) {
            if (hoverOver(textbox.getX()+width/2-createMenuWidth/2, textbox.getY()+height/2-createMenuHeight/2,
              textbox.getWidth(), textbox.getHeight())) { //tjekker om musen er over en tekstboks

              textbox.setSelected(true); //setter den valgte tekstboks til "selected"
            } else {
              textbox.setSelected(false); //setter alle de andre tekstbokse til "not selected"
            }
          }

          if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-260, height/2-createMenuHeight/2+240, 160, 50)) { //tjekker om musen er over knappen til at vælge retning for starthastighed

            chooseDirectionMode = true; //setter retningsvælgelse til sandt
          } else if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-150, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) { //tjekker om musen er over "close" knappen

            closeCreateMenu(); //lukker menuen
          } else if (hoverOverCircle(width/2-createMenuWidth/2+73, height/2-createMenuHeight/2+430, 20) && objectType.equals("planet")) { //tjekker om musen er over knappen for ringe

            //ændrer status om ringe alt efter hvilken status den allerede har
            if (ringsAdded) {
              ringsAdded = false;
            } else {
              ringsAdded = true;
            }
          } else if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-300, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) { //tjekker om musen er over "apply" knappen

            //tjekker om der er angivet nogen hastighed og beregner x- og y-komposanterne for den angivede vektor
            if (!textboxes.get(2).getText().equals("")) {
              direction.x *= float(textboxes.get(2).getText())/2000;
              direction.y *= float(textboxes.get(2).getText())/2000;
            } else {
              direction.x = 0;
              direction.y = 0;
            }

            if (!textboxes.get(0).getText().equals("") && !textboxes.get(1).getText().equals("") &&
              !textboxes.get(3).getText().equals("")) { //tjekker om de nødvendige informationer er givet, ved at tjekke indholdet i tekstboksene

              //tjekker om massen og størrelsen er inden for den tilladte grænse og ændrer dem derefter
              checkForInfo(false);

              if (!editMode) { //Tjekker om brugeren er i gang med at ændre et objekt

                //tilføjer nyt objekt alt efter objekt type
                if (objectType.equals("planet")) {
                  objects.add(new Planet(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())), saveMouseX, saveMouseY, mToPixel(1000*float(textboxes.get(1).getText())), direction, "", textboxes.get(4).getText(), ringsAdded));
                } else if (objectType.equals("star")) {
                  objects.add(new Star(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())), saveMouseX, saveMouseY, mToPixel(1000*float(textboxes.get(1).getText())), direction, "", textboxes.get(4).getText()));
                }
              } else {

                //ændrer informationerne på de valgte objekt
                for (Object object : objects) {
                  if (object.getID() == editID) { //finder objektet via. ID'et
                    changeObject(object);
                    break;
                  }
                }
              }

              closeCreateMenu(); //lukker menuen
            } else  if (objectType.equals("black hole") && !textboxes.get(0).getText().equals("") && !textboxes.get(3).getText().equals("")) { //tjekker om objektet er et sort hul

              //tjekker om massen er inden for den tilladte grænse og ændrer dem derefter
              checkForInfo(true);

              if (!editMode) {//Tjekker om brugeren er i gang med at ændre et objekt

                //Laver et nyt sort hul
                objects.add(new BlackHole(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())), saveMouseX, saveMouseY, direction, "", textboxes.get(4).getText()));
              } else {

                //ændrer informationerne på de valgte objekt
                for (Object object : objects) {
                  if (object.getID() == editID) { //finder objektet via. ID'et
                    changeObject(object);
                    break;
                  }
                }
              }

              closeCreateMenu(); //lukker menuen
            } else {
              infoNeeded = true;
            }
          }
        } else {

          //stopper for muligheden for retningsvælgelse af starthastighed
          chooseDirectionMode = false;
          cameraFreeze(true);
        }
      }
    } else {
      if (hoverOver(-5, -5, sideMenuWidth, height+10)) {

        for (Sidebar sidebar : sidebars) {
          if (mouseY > sidebar.getY() && mouseY < sidebar.getY()+sidebar.getH() && mouseY > 100) { //tjekker om musen er over en "Sidebar"
            if (hoverOver(sideMenuWidth-130, sidebar.getY()+130, 100, 30)) { //tjekker om musen er over "delete"-knappen

              //finder objektet baseret på ID og sletter det
              for (int i = 0; i < objects.size(); i++) {
                if (objects.get(i).getID() == sidebar.getID()) {
                  objects.remove(i);
                }
              }

              sidebars.remove(sidebar); //fjerner sidebar
              break;
            } else {

              //setter objekt i fokus
              objectFocus = true;
              objectOnFocus = sidebar.getID();
              sidebar.setFocus(true);

              if (hoverOver(sideMenuWidth-260, sidebar.getY()+130, 100, 30)) { //tjekker om musen er over "edit"-knappen

                //finder ud af hvilken objekt type det er
                for (Object object : objects) {
                  if (object.getID() == sidebar.getID()) {
                    if (object.getType().equals("planet")) {
                      count = 1;
                    } else if (object.getType().equals("star")) {
                      count = 2;
                    } else if (object.getType().equals("black hole")) {
                      count = 3;
                    }
                  }
                }

                //sætter gang i ændringen på objektet
                editID = sidebar.getID();
                editMode = true;
                createMenuSetup(count);
                isPlaced = true;
                sideMenu = false;
                count = 0;
              }
            }
          } else {

            //fjerner fokussset fra alle andre sidebare
            sidebar.setFocus(false);
          }
        }
      }
    }
  }
}

//Bliver aktiveret ved mouseScroll
void mouseWheel(MouseEvent event) {

  if (hoverOver(-5, 100, sideMenuWidth+5, height-95)) { //tjekker om musen er over sidebarene
    if (event.getCount() > 0) { //tjekker om der bliver scrollet op eller ned
      if (barStart > (-1)*sidebars.size()*170+height-100) { //tjekker om listen er lang nok til at blive flyttet opad
        barStart -= event.getCount()*30;
      }
    } else {
      if (barStart < 0) { //tjekker om listen er lang nok til at blive flyttet nedad
        barStart -= event.getCount()*30;
      }
    }
  }
}

//bliver aktiveret når en knap trykkes på
void keyPressed() {
  if (key == ' ' && !create && !quit) { //tjekker om knappen er space, og der ikke er nogen menuer åbne

    //indstiller kameraet alt efter dens nuværende tilstand
    if (!spaceIsPressed) {
      cameraFreeze(true);
    } else {
      cameraFreeze(false);
    }
  } else if (key == 'q') { //tjekker om knappen der er trykket er q

    //fjerner al fokus fra objekter i universet
    objectFocus = false;
    for (Sidebar sidebar : sidebars) {
      sidebar.setFocus(false);
    }
  } else if (key == TAB && !create && !quit) { //tjekker om knappen der er trykket er tab samt ingen menuer åbne

    //Indstiller bevægelsen for objekterne alt efter hvad deres nuværende bevægelse er
    if (!tabIsPressed) {
      freezeMovement = true;
      tabIsPressed = true;
    } else {
      freezeMovement = false;
      tabIsPressed = false;
    }
  } else if (create) { //tjekker om brugeren er i gang med at lave et nyt objekt

    if (key == ESC && !chooseDirectionMode) {//tjekker om knappen der er trykket på er escape

      if (!chooseDirectionMode) { //tjekker om brugeren er i gang med at vælge retning
        closeCreateMenu();
      } else {
        chooseDirectionMode = false;
        cameraFreeze(true);
        direction.x = 0;
        direction.y = 0;
      }
    } else {

      for (Textbox textbox : textboxes) {
        if (textbox.getSelected()) { //tjekker om tekstboksen er valgt

          //tilføjer/fjerner tegn i tekstboksen alt efter knap
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
  } else if (quit) { //tjekker om brugeren er på vej ud af programmet

    //lukker programmet/ fortsætter programmet alt efter knap trykket på
    if (key == ESC) {
      freezeMovement = false;
      quit = false;
      cam.setMouseControlled(true);
    } else if (key == ENTER) {
      exit();
    }
  } else {

    if (key == ESC) { //tjekker omder er trykket på escape

      //stopper programmet og åbner quit-menue
      freezeMovement = true;
      quit = true;
      objectMenu = false;
      cam.setMouseControlled(false);
    }
  }

  //stopper escape fra at lukke programmet ned
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
  return distance*100/(1499*pow(10, 8));
}

//omsætter pixels til meter
float pixelToM(float distance) {
  return distance*(1499*pow(10, 8))/100;
}

//kamerahåndtering
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

//funktion for firkantet knap
boolean hoverOver(float x, float y, float l, float h) {
  return (mouseX > x && mouseX < x+l && mouseY > y && mouseY < y+h);
}

//funktion for cirkulær knap
boolean hoverOverCircle(float x, float y, float r) {
  return (sqrt(pow(mouseX-x, 2) + pow(mouseY-y, 2)) < r);
}

//setup for create-menuen
void createMenuSetup(int i) {

  ringsAdded = false;
  objectMenu = false;
  create = true;
  cameraFreeze(true);
  freezeMovement = true;

  //sætter objekttypen alt efter integerens værdi
  if (i == 1) {
    objectType = "planet";
  } else if (i == 2) {
    objectType = "star";
  } else if (i == 3) {
    objectType = "black hole";
  }

  if (editMode) { //tjekker om brugeren er ved at ændre på et eksisterende objekt

    //Indstiller alle infromationer om objektet
    for (Object object : objects) {
      if (object.getID() == editID) { //tjekker om objektet har det rette ID
        count = 0;

        //Henter informationer om objektets vægt
        if (object.getMass() > 0) {

          for (int n = -30; true; n++) {
            if (object.getMass()/(pow(10, n)) < 1) {
              count = n-1;
              break;
            }
          }
        } else {

          for (int n = -30; true; n++) {
            if (object.getMass()/(pow(10, n)) > -1) {
              count = n-1;
              break;
            }
          }
        }

        //henter alle andre informationer om objektet
        textboxes.get(0).setText(String.valueOf(object.getMass()/pow(10, count)));
        textboxes.get(1).setText(String.valueOf(pixelToM(object.getRadius())/1000));
        textboxes.get(3).setText(String.valueOf(count));
        textboxes.get(4).setText(object.getObjectName());
        ringsAdded = object.ifRings();

        count = 0;
        break;
      }
    }
  }
}

//funktion for at lukke menuen for et nyt objekt
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
  editMode = false;
}

//Funktion for valg a retning på det nye objekts starthastighed
void chooseDirection() {
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

void placeObjectVisual() {
  // visuelt viser placeringen af objektet, når brugeren vælger placeringen
  pushMatrix();
  translate((mouseX-width/2)*3.20987654, (mouseY-height/2)*3.20987654, 0);
  fill(#964B00);
  sphere(20);
  popMatrix();
}

void objectMenuSetup() {
  //åbner objekt menuen ved musens placering. Men sørger for at uanset hvad kan menuen altid ses
  if (mouseX < width-objektMenuWidth && mouseY < height -objektMenuHeight) { //tjekker om musens placering er længere oppe fra bunden end objektmenuens højde, samt længer til venstre end menuens bredde
    saveMousePostion(mouseX, mouseY);
  } else if (mouseX < width-objektMenuWidth) { //tjekker om musen er længere til venstre end objekt menuens bredde
    saveMousePostion(mouseX, height-objektMenuHeight);
  } else if (mouseY < height-objektMenuHeight) { //tjekker om musen er højere oppe fra bunden end objekt menuens højde
    saveMousePostion(width-objektMenuWidth, mouseY);
  } else {
    saveMousePostion(width-objektMenuWidth, height-objektMenuHeight);
  }

  //åbner objekt menuen samt musens kontrol over det 3 dimensionelle univers
  objectMenu = true;
  objectFocus = false;
  cam.setMouseControlled(false);
}

//funktion der gemmer musens position
void saveMousePostion(float x, float y) {
  saveMouseX = x;
  saveMouseY = y;
}

//funktion der tjekker tekstboksenes indhold
void checkForInfo(boolean b) {

  //sørger for at vægten den er inden for den tilladte grænse
  if (!objectType.equals("black hole")) {
    if (float(textboxes.get(0).getText()) > 200) {
      textboxes.get(0).setText("200");
    } else if (float(textboxes.get(0).getText()) < -200) {
      textboxes.get(0).setText("-200");
    }
    if (float(textboxes.get(3).getText()) > 30) {
      textboxes.get(3).setText("30");
    } else if (float(textboxes.get(3).getText()) < -30) {
      textboxes.get(3).setText("-30");
    }
  } else {
    if (float(textboxes.get(0).getText()) > 400) {
      textboxes.get(0).setText("400");
    } else if (float(textboxes.get(0).getText()) < -400) {
      textboxes.get(0).setText("-400");
    }
    if (float(textboxes.get(3).getText()) > 33) {
      textboxes.get(3).setText("33");
    } else if (float(textboxes.get(3).getText()) < -33) {
      textboxes.get(3).setText("-33");
    }
  }

  //sørger for at radiussen er inden for den tilladte grænse
  if (!b) {
    if (objectType.equals("star")) {
      if (float(textboxes.get(1).getText()) > 6963400L*7.5*sizeInterval) {
        textboxes.get(1).setText("160000000");
      } else if (float(textboxes.get(1).getText()) < 6963400L*1*sizeInterval) {
        textboxes.get(1).setText(String.valueOf(6963400L*1*sizeInterval));
      }
    } else {
      if (float(textboxes.get(1).getText()) > 6963400L*1.3*sizeInterval) {
        textboxes.get(1).setText("27000000");
      } else if (float(textboxes.get(1).getText()) < 0) {
        textboxes.get(1).setText("0");
      }
    }
  }
}

//finktion for ændring af informationer på et objekt
void changeObject(Object object) {
  object.setMass(float(textboxes.get(0).getText())*pow(10, float(textboxes.get(3).getText())));
  object.setRadius(mToPixel(1000*float(textboxes.get(1).getText())));
  object.setObjectName(textboxes.get(4).getText());
  if (objectType.equals("planet")) {
    object.setRings(ringsAdded);
  }
  object.resetGlobe();
}
