float quitTextWidth;
int countTextbox = 0;
int countNr = 0;
boolean foundTextbox = false;

//funktion der tegner objektmenuen
void objectMenu() {
  
  //starter kreeringen af menuen
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  cam.beginHUD();
  oui.beginDraw();

  //resetter canvas
  oui.background(60);

  //tegner selve objekt menuen
  oui.textFont(font);
  oui.noFill();
  oui.strokeWeight(5);
  oui.stroke(50);
  oui.rect(0, 0, objektMenuWidth, objektMenuHeight);
  oui.strokeWeight(1);
  oui.line(0, 38, objektMenuWidth, 38);

  //skriver overskriften i menuen
  oui.fill(255);
  oui.textSize(29);
  oui.text("New Object", 10, 28);
  
  //Laver de tre knapper
  oui.strokeWeight(5);
  oui.fill(60);
  oui.rect(5/2, 39, objektMenuWidth-5, 50);
  oui.rect(5/2, 89, objektMenuWidth-5, 50);
  oui.rect(5/2, 139, objektMenuWidth-5, 50);
  
  //omfarver knapperne hvis musen er over en af dem
  if (hoverOver(saveMouseX, saveMouseY+39, objektMenuWidth, 50)) {
    oui.fill(70);
    oui.rect(5/2, 39, objektMenuWidth-5, 50);
  }
  if (hoverOver(saveMouseX, saveMouseY+89, objektMenuWidth, 50)) {
    oui.fill(70);
    oui.rect(5/2, 89, objektMenuWidth-5, 50);
  }
  if (hoverOver(saveMouseX, saveMouseY+139, objektMenuWidth, 50)) {
    oui.fill(70);
    oui.rect(5/2, 139, objektMenuWidth-5, 50);
  }
  
  //Skriver de forskellige knappers navne
  oui.fill(255);
  oui.textFont(font2);
  oui.textSize(18);
  oui.text("Planet", 18, 70);
  oui.text("Star", 18, 120);
  oui.text("Black Hole", 18, 170);
  
  //stopper kreeringen af menuen
  oui.endDraw();
  image(oui, saveMouseX, saveMouseY);
  cam.endHUD();

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void quitMenu() {
  
  //starter kreeringen af menuen
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  cam.beginHUD();
  qui.beginDraw();
  
  //resetter canvas
  qui.background(0, 90);
  qui.textFont(font);
  
  //skriver "QUIT?" i toppen
  qui.textSize(130);
  qui.fill(255, 200);
  quitTextWidth = textWidth("QUIT?");
  qui.text("QUIT?", width/2-quitTextWidth/2, 200);
  
  //tegner de to knapper
  qui.stroke(100, 90);
  qui.strokeWeight(4);
  qui.fill(150, 90);
  qui.rect(width/2-400, height/2+100, 200, 100);
  qui.rect(width/2+200, height/2+100, 200, 100);
  
  //skriver de to knappers navne
  textSize(80);
  qui.fill(200, 90);
  qui.text("Yes", width/2-390, height/2+185);
  qui.text("No", width/2+240, height/2+185);
  
  qui.stroke(200, 90);
  
  //Omfarver knapperne hvis musen er over dem
  if (hoverOver(width/2-400, height/2+100, 200, 100)) {
    qui.fill(255, 150);
    qui.rect(width/2-400, height/2+100, 200, 100);

    qui.fill(100, 90);
    qui.text("Yes", width/2-390, height/2+185);
  } else if (hoverOver(width/2+200, height/2+100, 200, 100)) {
    qui.fill(255, 150);
    qui.rect(width/2+200, height/2+100, 200, 100);

    qui.fill(100, 90);
    qui.text("No", width/2+240, height/2+185);
  }
  
  //stopper kreeringen af menuen
  qui.endDraw();
  image(qui, 0, 0);
  cam.endHUD();

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void createMenu() {
  
  //starter kreeringen af menu
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  cam.beginHUD();
  cui.beginDraw();
  
  //restter canvas
  cui.fill(60);
  cui.strokeWeight(5);
  cui.stroke(55);
  cui.rect(0, 0, createMenuWidth, createMenuHeight);
  
  //går igenne malle teskbokse
  for (Textbox textbox : textboxes) {
    
    //opdater markøren
    textbox.cursorOnBox(mouseX-(width/2-createMenuWidth/2), mouseY-(height/2-createMenuHeight/2));
    
    cui.textFont(font2);
    countNr++;
    
    //opdaterer tekstboksene
    if (countNr == 2 && objectType.equals("black hole")) {
    } else {
      textbox.update(cui);
    }
  }
  
  //opdaterer markør
  if (!foundTextbox) {
    cursor(ARROW);
  }
  foundTextbox = false;
  countNr = 0;
  
  //skriver overskriften på menuen
  cui.textFont(font);
  cui.textSize(50);
  if (!editMode) {
    cui.text("CREATE "+objectType.toUpperCase(), createMenuWidth/2-cui.textWidth("CREATE "+objectType.toUpperCase())/2, 50);
  } else {
    cui.text("EDIT "+objectType.toUpperCase(), createMenuWidth/2-cui.textWidth("EDIT "+objectType.toUpperCase())/2, 50);
  }
  
  //skriver teskt ved siden af tekstboksene
  cui.textFont(font2);
  cui.textSize(24);
  cui.text("Mass of "+objectType+":", 53, 170);
  
  //skriver teksten ved siden af størrelsestekstboksen hvis det nye objekt ikke eer et sort hul
  if (!objectType.equals("black hole")) {
    cui.text("Size of "+objectType+":", 53, 310);
    cui.text("km", 255, 320+30-30/10*2);
  }
  
  //skriver teskt ved siden af tekstboksene
  cui.text("Name of "+objectType+":", createMenuWidth-277, 360);
  cui.text("Speed of "+objectType+":", createMenuWidth-277, 170);
  cui.text("km/s", createMenuWidth-75, 180+30-30/10*2);
  cui.text("x 10^", 155, 180+30-30/10*2);
  cui.text("kg", 160+64+50, 180+30-30/10*2);
  
  //laver knap for adderingen af ringe
  if (objectType.equals("planet")) {
    cui.text("Rings", 53, 400);

    cui.strokeWeight(3);
    if (ringsAdded) {
      cui.fill(255);
    } else {
      cui.fill(70);
    }
    cui.circle(73, 430, 20);
  }

  //farver knappen for retningsbestemmelse af starthastigheden
  if (hoverOver(width/2+createMenuWidth/2-260, height/2-createMenuHeight/2+240, 160, 50)) {
    cui.fill(80);
  } else {
    cui.fill(64);
  }
  cui.rect(createMenuWidth-260, 240, 160, 50);

  //laver knap for retnin gsbestemmelse af starthastigheden
  cui.fill(255);
  cui.textSize(15);
  cui.text("Set the direction", createMenuWidth-260+80-cui.textWidth("Set the direction")/2, 240+25+7);

  cui.line(0, 70, createMenuWidth, 70);

  //farver knappen for lukningsknappen
  if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-150, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) {
    cui.fill(80);
  } else {
    cui.fill(64);
  }
  
  //laver lukningsknappen
  cui.rect(createMenuWidth-150, createMenuHeight-70, 100, 30);
  cui.fill(255);
  cui.text("Cancel", createMenuWidth-150+80-cui.textWidth("Set the direction")/2, createMenuHeight-70+20);
  
  //farver knappen kreering af nyt objekt
  if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-300, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) {
    cui.fill(80);
  } else {
    cui.fill(64);
  }
  
  //laver knappen for kreeringen af nyt objekt
  cui.rect(createMenuWidth-300, createMenuHeight-70, 100, 30);
  cui.fill(255);
  cui.text("Apply", createMenuWidth-300+50-cui.textWidth("Apply")/2, createMenuHeight-70+20);

  if (infoNeeded) { //tjekker om der er informationer der mangler
    cui.text("Missing information!", createMenuWidth-315-cui.textWidth("Missing information!"), createMenuHeight-70+20); //skriver at der mangles informationer
  }
  
  //tjekker om tekstboksene har de tilladte værdier
  if (!textboxes.get(0).getSelected() && !textboxes.get(3).getSelected() && !textboxes.get(1).getSelected()) {
    checkForInfo(false);
  }
  
  //stopper kreeringen af menuen
  cui.endDraw();
  image(cui, width/2-createMenuWidth/2, height/2-createMenuHeight/2);
  cam.endHUD();

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void sideMenu() {
  
  //starter kreeringen af menuen
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  cam.beginHUD();
  sui.beginDraw();
  
  //restter canvas
  sui.fill(60);
  sui.strokeWeight(10);
  sui.stroke(51);
  sui.rect(0, 0, sideMenuWidth, height);
  
  //Stopper musen fra at ændre i universet når den er over sidemenuen
  if (hoverOver(-5, -5, sideMenuWidth, height+10)) {
    cam.setMouseControlled(false);
  } else {
    if (!spaceIsPressed && !quit) {
      cam.setMouseControlled(true);
    }
  }
  
  //tegner alle sidebarene
  count = 0;
  for (Sidebar sidebar : sidebars) {
    
    sidebar.drawBar(sui, count);
    count++;
  }
  count = 0;
  rotation++;
  
  //tegner den øverste boks med overskrift
  sui.fill(60);
  sui.strokeWeight(10);
  sui.stroke(51);
  sui.rect(0, 0, sideMenuWidth, 100);
  sui.textFont(font);
  sui.textSize(78);
  sui.fill(255);
  sui.text("OBJECTS", sideMenuWidth/2-sui.textWidth("OBJECTS")/2, 70);
  
  //stopper kreeringen af canvas
  sui.endDraw();
  image(sui, 0, 0);
  cam.endHUD();
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}
