float quitTextWidth;

void createMenu() {
  
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  
  cam.beginHUD();
  ui.beginDraw();
  ui.background(60);

  ui.noFill();
  ui.strokeWeight(5);
  ui.stroke(50);
  ui.rect(0, 0, menuWidth, menuHeight);
  ui.strokeWeight(1);
  ui.line(0, 38, menuWidth, 38);

  ui.fill(255);
  ui.textSize(20);
  ui.text("Nyt Objekt", 10, 30);

  ui.strokeWeight(5);
  ui.fill(60);
  ui.rect(5/2, 39, menuWidth-5, 50);
  ui.rect(5/2, 89, menuWidth-5, 50);
  if (knap(saveMouseX, saveMouseY+39, menuWidth, 50)) {
    ui.fill(70);
    ui.rect(5/2, 39, menuWidth-5, 50);
  }
  if (knap(saveMouseX, saveMouseY+89, menuWidth, 50)) {
    ui.fill(70);
    ui.rect(5/2, 89, menuWidth-5, 50);
  }

  ui.endDraw();
  image(ui, saveMouseX, saveMouseY);
  cam.endHUD();
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}

void quitMenu() {
  
  hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
  
  cam.beginHUD();
  qui.beginDraw();
  qui.background(60,90);
  
  qui.textSize(100);
  textSize(100);
  qui.fill(255,100);
  quitTextWidth = textWidth("QUIT?");
  qui.text("QUIT?", width/2-quitTextWidth/2, 200);
  
  qui.endDraw();
  image(qui, 0, 0);
  cam.endHUD();
  
  hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
}
