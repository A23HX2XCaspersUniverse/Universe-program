class Star extends Object{
  
  Star(float m, float x, float y, float r, PVector p) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    saveSpeed = p;
    ID = IDs;
    surface = loadImage("Stjerne"+int(random(1,5))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
    speed = new PVector(0,0,0);
    pickColor = random(80,180);
    type = "star";
    sidebars.add(new Sidebar(ID));
    IDs++;
    println(ID);
  }
}
