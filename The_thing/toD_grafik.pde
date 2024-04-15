float quitTextWidth;

void createMenu() {
  
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  
  cam.beginHUD();
  cui.beginDraw();
  cui.textFont(font);
  cui.background(60);

  cui.noFill();
  cui.strokeWeight(5);
  cui.stroke(50);
  cui.rect(0, 0, menuWidth, menuHeight);
  cui.strokeWeight(1);
  cui.line(0, 38, menuWidth, 38);

  cui.fill(255);
  cui.textSize(29);
  cui.text("Nyt Objekt", 10, 28);

  cui.strokeWeight(5);
  cui.fill(60);
  cui.rect(5/2, 39, menuWidth-5, 50);
  cui.rect(5/2, 89, menuWidth-5, 50);
  cui.rect(5/2, 139, menuWidth-5, 50);
  
  if (knap(saveMouseX, saveMouseY+39, menuWidth, 50)) {
    cui.fill(70);
    cui.rect(5/2, 39, menuWidth-5, 50);
  }
  if (knap(saveMouseX, saveMouseY+89, menuWidth, 50)) {
    cui.fill(70);
    cui.rect(5/2, 89, menuWidth-5, 50);
  }
  if (knap(saveMouseX, saveMouseY+139, menuWidth, 50)) {
    cui.fill(70);
    cui.rect(5/2, 139, menuWidth-5, 50);
  }
  
  cui.fill(255);
  cui.textFont(font2);
  cui.textSize(18);
  cui.text("Planet", 18, 70);
  cui.text("Star", 18, 120);
  cui.text("Black Hole", 18, 170);

  cui.endDraw();
  image(cui, saveMouseX, saveMouseY);
  cam.endHUD();
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

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
  
  qui.fill(150,90);
  qui.rect(width/2-400, height/2+100, 200, 100);
  qui.rect(width/2+200, height/2+100, 200, 100);
  
  textSize(80);
  qui.fill(200,90);
  qui.text("Yes", width/2-390, height/2+185);
  qui.text("No", width/2+240, height/2+185);
  
  if (knap(width/2-400, height/2+100, 200, 100)) {
    qui.fill(255,150);
    qui.rect(width/2-400, height/2+100, 200, 100);
    
    qui.fill(100,90);
    qui.text("Yes", width/2-390, height/2+185);
    
  } else if (knap(width/2+200, height/2+100, 200, 100)) {
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
