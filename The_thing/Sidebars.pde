class Sidebar {
  int ID, nr, barHeight, x, y;
  String name;
  PGraphics p;
  PShape shape;
  PImage surface;
  boolean focus;
  
  //konstruktøt
  Sidebar(int i, PImage pi) {
    ID = i;
    surface = pi;
    shape = createShape(SPHERE, 40);
    shape.setTexture(pi);
    p = createGraphics(100, 100, P3D);
    barHeight = 170;
    focus = false;
  }
  
  //funktion der tegner baren
  void drawBar(PGraphics g, int i) {
    nr = 0;
    
    //henter nummeret på sidebaren
    for (Object object : objects) {
      if (object.getID() == ID) {
        break;
      }
      nr++;
    }
    
    //setter baggrundsfarven på baren
    if (focus) {
      g.fill(90);
    } else {
      g.fill(60);
    }
    
    //tegner selve baren
    g.strokeWeight(5);
    g.stroke(51);
    y = int(100+i*barHeight+barStart);
    g.rect(0, y, sideMenuWidth, barHeight);
    
    //skriver objektets navn/type
    g.textFont(font);
    g.textSize(40);
    g.fill(255);
    if (nr < objects.size()) {
      if (!objects.get(nr).getObjectName().equals("")) {
        name = objects.get(nr).getObjectName();
      } else {
        name = objects.get(nr).getType();
      }
    }
    if (name != null) {
      g.text(name.toUpperCase(), 140, y+40);
    }
    
    //Skriver objektets masse og radius
    g.textFont(font2);
    g.textSize(20);
    if (nr < objects.size()) {
      g.text("Radius: "+pixelToM(objects.get(nr).getRadius())/1000+" km", 140, y+70);

      g.text("Mass: "+objects.get(nr).getMass()+" kg", 140, y+100);
    }
    
    //setter baggrundsfarve for knapper på baren
    if (focus) { //tjekker om baren er i fokus
      g.fill(90);
      g.stroke(70);
    } else {
      g.fill(60);
      g.stroke(51);
    }
    
    //tegner knapperne
    g.strokeWeight(3);
    g.rect(sideMenuWidth-130, y+130, 100, 30);
    g.rect(sideMenuWidth-260, y+130, 100, 30);
    g.fill(255);
    g.text("Delete", sideMenuWidth-80-g.textWidth("Delete")/2, y+151);
    g.text("Edit", sideMenuWidth-210-g.textWidth("Edit")/2, y+151);

    g.endDraw();
    
    //tegner objektet i siden
    hint(ENABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3
    cam.endHUD();
    pushMatrix();
    p.beginDraw();
    p.noFill();
    p.translate(50, 50);
    p.shape(shape);
    p.endDraw();
    popMatrix();
    cam.beginHUD();
    hint(DISABLE_DEPTH_TEST); //https://stackoverflow.com/questions/66303006/drawing-2d-text-over-3d-objects-in-processing-3

    g.beginDraw();
    
    //projekterer objektet på billedet
    g.image(p, 5, y+25);
  }
  
  //returnerer barens ID
  int getID() {
    return ID;
  }
  
  //returnerer barens Y-position
  int getY() {
    return y;
  }
  
  //returnerer barens X-position
  int getH() {
    return barHeight;
  }
  
  //setter baren i fokus
  void setFocus(boolean b) {
    focus = b;
  }
}
