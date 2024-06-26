class Star extends Object{
  
  //konstruktør
  Star(float m, float x, float y, float r, PVector p, String texture, String str) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    saveSpeed = p;
    ID = IDs;
    fill(255);
    if (texture.equals("")) {
      surface = loadImage("textures/Stjerne"+int(random(1, 5))+".jpg");
    } else {
      surface = loadImage(texture);
    }
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
    speed = new PVector(0,0,0);
    name = str;
    type = "star";
    sidebars.add(new Sidebar(ID, surface));
    IDs++;
  }
}
