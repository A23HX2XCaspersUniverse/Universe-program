class Sidebar {
  int ID, nr, barHeight;
  String name;
  PGraphics p;
  PShape shape;

  Sidebar(int i) {
    ID = i;
    p = createGraphics(100, 100, P3D);
    barHeight = 170;
  }

  void drawBar(PGraphics g, int i) {
    nr = 0;
    for (Object object : objects) {
      if (object.getID() == ID) {
        break;
      }
      nr++;
    }

    g.fill(60);
    g.strokeWeight(5);
    g.stroke(51);
    g.rect(0, 100+i*barHeight+barStart, sideMenuWidth, barHeight);

    g.textFont(font);
    g.textSize(40);
    g.fill(255);
    if (nr < objects.size()) {
      name = objects.get(nr).getType();
    }
    if (name != null) {
      g.text(name.toUpperCase(), 140, 140+i*barHeight+barStart);
    }
    
    g.textFont(font2);
    g.textSize(20);
    g.text("Radius: "+pixelToM(objects.get(nr).getRadius())+" km", 140, 170+i*barHeight+barStart);
    
    g.text("Mass: "+objects.get(nr).getMass()+" kg", 140, 200+i*barHeight+barStart);
    
    g.endDraw();
    
    hint(ENABLE_DEPTH_TEST);
    cam.endHUD();
    p.beginDraw();
    p.translate(50, 50);
    shape = createShape(SPHERE, 40);
    shape.setTexture(objects.get(nr).getTexture());
    p.shape(shape);
    p.endDraw();
    cam.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    
    g.beginDraw();
    
    g.image(p, 5, 125+i*barHeight+barStart);
    
  }

  int getID() {
    return ID;
  }
}
