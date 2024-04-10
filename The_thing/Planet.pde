class Planet {
  float masse, xPos, yPos, radius;
  PVector speed;
  PShape globe;
  PImage planet;
  
  Planet(float m, float x, float y, float r) {
    masse = m;
    xPos = x;
    yPos = y;
    radius = r;
    planet = loadImage("Planet.jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(planet);
  }
  
  void update() {
    translate(xPos, yPos, 0);
    shape(globe);
  }
}
