void createMenu() {

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
}
