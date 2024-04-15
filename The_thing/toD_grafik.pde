float quitTextWidth;

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
  oui.text("Nyt Objekt", 10, 28);

  oui.strokeWeight(5);
  oui.fill(60);
  oui.rect(5/2, 39, objektMenuWidth-5, 50);
  oui.rect(5/2, 89, objektMenuWidth-5, 50);
  oui.rect(5/2, 139, objektMenuWidth-5, 50);
  
  if (button(saveMouseX, saveMouseY+39, objektMenuWidth, 50)) {
    oui.fill(70);
    oui.rect(5/2, 39, objektMenuWidth-5, 50);
  }
  if (button(saveMouseX, saveMouseY+89, objektMenuWidth, 50)) {
    oui.fill(70);
    oui.rect(5/2, 89, objektMenuWidth-5, 50);
  }
  if (button(saveMouseX, saveMouseY+139, objektMenuWidth, 50)) {
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
  qui.background(60,90);
  
  qui.textSize(130);
  textSize(100);
  qui.fill(255,200);
  quitTextWidth = textWidth("QUIT?");
  qui.text("QUIT?", width/2-quitTextWidth/2, 200);
  
  qui.stroke(100,90);
  qui.strokeWeight(4);
  qui.fill(150,90);
  qui.rect(width/2-400, height/2+100, 200, 100);
  qui.rect(width/2+200, height/2+100, 200, 100);
  
  textSize(80);
  qui.fill(200,90);
  qui.text("Yes", width/2-390, height/2+185);
  qui.text("No", width/2+240, height/2+185);
  
  qui.stroke(200,90);
  
  if (button(width/2-400, height/2+100, 200, 100)) {
    qui.fill(255,150);
    qui.rect(width/2-400, height/2+100, 200, 100);
    
    qui.fill(100,90);
    qui.text("Yes", width/2-390, height/2+185);
    
  } else if (button(width/2+200, height/2+100, 200, 100)) {
    qui.fill(255,150);
    qui.rect(width/2+200, height/2+100, 200, 100);
    
    qui.fill(100,90);
    qui.text("No", width/2+240, height/2+185);
  }
  
  qui.endDraw();
  image(qui, 0, 0);
  cam.endHUD();
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void createMenu() {
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  
  cam.beginHUD();
  cui.beginDraw();
  cui.background(60);
  
  cui.endDraw();
  image(cui, width/2-createMenuWidth/2, height/2-createMenuHeight/2);
  cam.endHUD();
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}
