class Planet extends Objekt{
  PImage planet;
  
  Planet(float m, float x, float y, float z, float r) {
    masse = m;
    xPos = x;
    yPos = y;
    zPos = z;
    radius = r;
    planet = loadImage("Planet"+int(random(1,5))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(planet);
    saveSpeed = new PVector(0,0,0);
    nr = objektNr;
    
    objektNr++;
  }
}
