class Fragment extends Object {
  
  Fragment (float x, float y, float r, PVector p, PImage texture) {
    saveSpeed = p.mult(0.000002);
    mass = (4*PI*pow(0.4, 2))/(4*PI*pow(mToPixel(637100000L*2.5), 2));
    mass *= 3*pow(10, 23);
    p.setMag(r);
    p.rotate(PI*random(-(1/4), (1/4)));
    xPos = p.x+x;
    yPos = p.y+y;
    radius = 0.4*sizeInterval;
    ID = IDs;
    fill(255);
    surface = texture;
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
    speed = new PVector(0, 0, 0);
    type = "fragment";
    ring = loadImage("rings.png");
    square = createShape(BOX, int(radius*5), int(radius*5), 0);
    square.setTexture(ring);
    ringsOn = false;
    IDs++;
  }
}
