class Sidebar {
  int ID, nr;
  String name;
  PGraphics p;
  PShape shape;

  Sidebar(int i) {
    ID = i;
    p = createGraphics(100, 100, P3D);
  }

  void drawBar(PGraphics g, int i) {
    nr = 0;
    for (Object object : objects) {
      if (object.getID() == ID) {
        break;
      }
      nr++;
    }

    println(nr+"   "+objects.size()+"   "+ID);

    sui.fill(60);
    sui.strokeWeight(5);
    sui.stroke(51);
    g.rect(0, 100+i*150, sideMenuWidth, 150);

    g.textFont(font);
    g.textSize(40);
    g.fill(255);
    if (nr < objects.size()) {
      name = objects.get(nr).getType();
    }
    if (name != null) {
      g.text(name.toUpperCase(), 150, 140+i*150);
    }
    
    g.endDraw();
    
    p.beginDraw();
    p.translate(50, 50);
    shape = createShape(SPHERE, 40);
    shape.setTexture(objects.get(nr).getTexture());
    p.shape(shape);
    p.endDraw();
    
    g.beginDraw();
    
    g.image(p, 5, 125+i*150);
    
  }

  int getID() {
    return ID;
  }
}
