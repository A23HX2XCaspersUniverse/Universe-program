class Planet extends Object {

  Planet(float m, float x, float y, float r, PVector p, String texture, String name) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    saveSpeed = p;
    ID = IDs;
    if (name != "") {
      surface = loadImage("Planet"+int(random(1, 5))+".jpg");
    } else {
      surface = loadImage(texture);
    }
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
    speed = new PVector(0, 0, 0);
    pickColor = random(80, 180);
    type = "planet";
    sidebars.add(new Sidebar(ID));
    IDs++;
    println(ID);
  }
}
