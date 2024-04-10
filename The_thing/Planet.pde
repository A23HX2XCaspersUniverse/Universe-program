class Planet {
  float masse, xPos, yPos, radius, afstand, kraft;
  PVector speed;
  PVector pavirkning;
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
  
  //opdaterer planetens position
  void update() {
    for (Planet planet : planets) {
      afstand = sqrt(pow(planet.getX()-xPos, 2)+pow(planet.getY()-yPos, 2));
      if (afstand != 0) {
        kraft = 6.674*pow(10, -11) * masse * planet.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, planet.getX(), yPos, planet.getY(), kraft) , kraftFordelingY(xPos, planet.getX(), yPos, planet.getY(), kraft));
      }
    }
    println(afstand+ "  "+kraft+"   "+pavirkning);
    translate(xPos, yPos, 0);
    shape(globe);
  }
  
  //returnerer x-position
  float getX() {
    return xPos;
  }
  
  //returnerer y-position
  float getY() {
    return yPos;
  }
  
  float getMasse() {
    return masse;
  }
}
