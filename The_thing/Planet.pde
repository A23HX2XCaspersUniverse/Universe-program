class Planet extends Object{
  PImage planet;
  
  Planet(float m, float x, float y, float r, PVector p) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    saveSpeed = p;
    planet = loadImage("Planet"+int(random(1,5))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(planet);
    speed = new PVector(0,0,0);
    nr = objektNr;
    pickColor = random(80,180);
    
    objektNr++;
  }
}
