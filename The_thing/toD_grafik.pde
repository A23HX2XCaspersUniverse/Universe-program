float quitTextWidth;
int countTextbox = 0;
int countNr = 0;
boolean foundTextbox = false;

void objectMenu() {

  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3

  cam.beginHUD();
  oui.beginDraw();
  oui.textFont(font);
  oui.background(60);

  oui.noFill();
  oui.strokeWeight(5);
  oui.stroke(50);
  oui.rect(0, 0, objektMenuWidth, objektMenuHeight);
  oui.strokeWeight(1);
  oui.line(0, 38, objektMenuWidth, 38);

  oui.fill(255);
  oui.textSize(29);
  oui.text("New Object", 10, 28);

  oui.strokeWeight(5);
  oui.fill(60);
  oui.rect(5/2, 39, objektMenuWidth-5, 50);
  oui.rect(5/2, 89, objektMenuWidth-5, 50);
  oui.rect(5/2, 139, objektMenuWidth-5, 50);

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

  oui.fill(255);
  oui.textFont(font2);
  oui.textSize(18);
  oui.text("Planet", 18, 70);
  oui.text("Star", 18, 120);
  oui.text("Black Hole", 18, 170);

  oui.endDraw();
  image(oui, saveMouseX, saveMouseY);
  cam.endHUD();

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void quitMenu() {

  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3

  cam.beginHUD();
  qui.beginDraw();
  qui.textFont(font);
  qui.background(0, 90);

  qui.textSize(130);
  textSize(100);
  qui.fill(255, 200);
  quitTextWidth = textWidth("QUIT?");
  qui.text("QUIT?", width/2-quitTextWidth/2, 200);

  qui.stroke(100, 90);
  qui.strokeWeight(4);
  qui.fill(150, 90);
  qui.rect(width/2-400, height/2+100, 200, 100);
  qui.rect(width/2+200, height/2+100, 200, 100);

  textSize(80);
  qui.fill(200, 90);
  qui.text("Yes", width/2-390, height/2+185);
  qui.text("No", width/2+240, height/2+185);

  qui.stroke(200, 90);

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

  qui.endDraw();
  image(qui, 0, 0);
  cam.endHUD();

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void createMenu() {
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3

  cam.beginHUD();
  cui.beginDraw();
  cui.fill(60);
  cui.strokeWeight(5);
  cui.stroke(55);
  cui.rect(0, 0, createMenuWidth, createMenuHeight);

  for (Textbox textbox : textboxes) {

    if (textbox.getCursorOnBox(mouseX-(width/2-createMenuWidth/2), mouseY-(height/2-createMenuHeight/2))) {
      foundTextbox = true;
    }

    cui.textFont(font2);
    countNr++;

    if (countNr == 2 && objectType.equals("black hole")) {
    } else {
      textbox.update(cui);
    }
  }

  if (foundTextbox) {
    cursor(TEXT);
  } else {
    cursor(ARROW);
  }
  foundTextbox = false;
  countNr = 0;

  cui.textFont(font);
  cui.textSize(50);
  cui.text("CREATE "+objectType.toUpperCase(), createMenuWidth/2-cui.textWidth("CREATE "+objectType.toUpperCase())/2, 50);

  cui.textFont(font2);
  cui.textSize(24);
  cui.text("Mass of "+objectType+":", 53, 170);
  if (!objectType.equals("black hole")) {
    cui.text("Size of "+objectType+":", 53, 320);
    cui.text("km", 255, 330+30-30/10*2);
  }
  cui.text("Speed of "+objectType+":", createMenuWidth-277, 170);
  cui.text("m/s", createMenuWidth-75, 180+30-30/10*2);

  cui.text("x 10^", 155, 180+30-30/10*2);
  cui.text("kg", 160+64+35, 180+30-30/10*2);

  if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-260, height/2-createMenuHeight/2+240, 160, 50)) {
    cui.fill(80);
  } else {
    cui.fill(64);
  }
  cui.rect(createMenuWidth-260, 240, 160, 50);

  cui.fill(255);
  cui.textSize(15);
  cui.text("Set the direction", createMenuWidth-260+80-cui.textWidth("Set the direction")/2, 240+25+7);

  cui.line(0, 70, createMenuWidth, 70);

  if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-150, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) {
    cui.fill(80);
  } else {
    cui.fill(64);
  }
  cui.rect(createMenuWidth-150, createMenuHeight-70, 100, 30);
  cui.fill(255);
  cui.text("Cancel", createMenuWidth-150+80-cui.textWidth("Set the direction")/2, createMenuHeight-70+20);

  if (hoverOver(width/2-createMenuWidth/2+createMenuWidth-300, height/2-createMenuHeight/2+createMenuHeight-70, 100, 30)) {
    cui.fill(80);
  } else {
    cui.fill(64);
  }
  cui.rect(createMenuWidth-300, createMenuHeight-70, 100, 30);
  cui.fill(255);
  cui.text("Apply", createMenuWidth-300+50-cui.textWidth("Apply")/2, createMenuHeight-70+20);

  if (infoNeeded) {
    cui.text("Missing information!", createMenuWidth-315-cui.textWidth("Missing information!"), createMenuHeight-70+20);
  }

  if (!textboxes.get(0).getSelected()) {
    if (float(textboxes.get(0).getText()) > 200) {
      textboxes.get(0).setText("200");
    }
  }

  if (!textboxes.get(3).getSelected()) {
    if (float(textboxes.get(3).getText()) > 30) {
      textboxes.get(3).setText("30");
    }
  }

  cui.endDraw();
  image(cui, width/2-createMenuWidth/2, height/2-createMenuHeight/2);
  cam.endHUD();

  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void sideMenu() {
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  cam.beginHUD();
  sui.beginDraw();
  sui.fill(60);
  sui.strokeWeight(10);
  sui.stroke(51);
  sui.rect(0, 0, sideMenuWidth, height);

  if (hoverOver(0, 0, sideMenuWidth, height)) {
    cam.setMouseControlled(false);
  } else {
    cam.setMouseControlled(true);
  }

  count = 0;
  for (Sidebar sidebar : sidebars) {
    sidebar.drawBar(sui, count);
    count++;
  }
  count = 0;

  sui.fill(60);
  sui.strokeWeight(10);
  sui.stroke(51);
  sui.rect(0, 0, sideMenuWidth, 100);
  sui.textFont(font);
  sui.textSize(78);
  sui.fill(255);
  sui.text("OBJECTS", sideMenuWidth/2-sui.textWidth("OBJECTS")/2, 75);
  sui.endDraw();
  image(sui, 0, 0);

  cam.endHUD();
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}
