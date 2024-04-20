class BlackHole extends Object{
  
  BlackHole(float m, float x, float y, PVector p) {
    mass = m;
    xPos = x;
    yPos = y;
    saveSpeed = p;
    ID = IDs;
    radius = mToPixel(2*6.674*pow(10, -11)*m/pow(300000000,2))*107290;
    surface = loadImage("black.jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
    speed = new PVector(0,0,0);
    pickColor = random(80,180);
    type = "black hole";
    sidebars.add(new Sidebar(ID));
    IDs++;
    println(ID);
  }
}
