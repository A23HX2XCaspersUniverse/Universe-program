class Sidebar {
  int ID, nr, barHeight, x, y;
  String name;
  PGraphics p;
  PShape shape;
  PImage surface;
  boolean focus;

  Sidebar(int i, PImage pi) {
    ID = i;
    surface = pi;
    shape = createShape(SPHERE, 40);
    shape.setTexture(pi);
    p = createGraphics(100, 100, P3D);
    barHeight = 170;
    focus = false;
  }

  void drawBar(PGraphics g, int i) {
    nr = 0;
    for (Object object : objects) {
      if (object.getID() == ID) {
        break;
      }
      nr++;
    }

    if (focus) {
      g.fill(90);
    } else {
      g.fill(60);
    }
    g.strokeWeight(5);
    g.stroke(51);
    y = int(100+i*barHeight+barStart);
    g.rect(0, y, sideMenuWidth, barHeight);

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

    g.textFont(font2);
    g.textSize(20);
    if (nr < objects.size()) {
      g.text("Radius: "+pixelToM(objects.get(nr).getRadius())/1000+" km", 140, y+70);

      g.text("Mass: "+objects.get(nr).getMass()+" kg", 140, y+100);
    }
    
    
    if (focus) {
      g.fill(90);
      g.stroke(70);
    } else {
      g.fill(60);
      g.stroke(51);
    }
    g.strokeWeight(3);
    g.rect(sideMenuWidth-130, y+130, 100, 30);
    g.rect(sideMenuWidth-260, y+130, 100, 30);
    g.fill(255);
    g.text("Delete", sideMenuWidth-80-g.textWidth("Delete")/2, y+151);
    g.text("Edit", sideMenuWidth-210-g.textWidth("Edit")/2, y+151);

    g.endDraw();

    hint(ENABLE_DEPTH_TEST);
    cam.endHUD();
    pushMatrix();
    p.beginDraw();
    p.noFill();
    p.translate(50, 50);
    p.shape(shape);
    p.endDraw();
    popMatrix();
    cam.beginHUD();
    hint(DISABLE_DEPTH_TEST);

    g.beginDraw();

    g.image(p, 5, y+25);
  }

  int getID() {
    return ID;
  }

  int getY() {
    return y;
  }

  int getH() {
    return barHeight;
  }

  void setFocus(boolean b) {
    focus = b;
  }
}
