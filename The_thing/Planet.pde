class Planet extends Object {
  
  //konstruktør
  Planet(float m, float x, float y, float r, PVector p, String texture, String str, boolean b) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    saveSpeed = p;
    ID = IDs;
    fill(255);
    if (texture.equals("")) {
      surface = loadImage("textures/Planet"+int(random(1, 14))+".jpg");
    } else {
      surface = loadImage(texture);
    }
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
    speed = new PVector(0, 0, 0);
    ekstraSpeed = new PVector(0, 0, 0);
    name = str;
    type = "planet";
    ring = loadImage("textures/rings.png");
    square = createShape(BOX, int(radius*5), int(radius*5), 0);
    square.setTexture(ring);
    if (b) {
      ringsOn = true;
    }
    sidebars.add(new Sidebar(ID, surface));
    IDs++;
  }
}
