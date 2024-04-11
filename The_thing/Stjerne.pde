class Stjerne extends Objekt{
  PImage stjerne;
  
  Stjerne(float m, float x, float y, float z, float r) {
    masse = m;
    xPos = x;
    yPos = y;
    zPos = z;
    radius = r;
    stjerne = loadImage("Stjerne"+int(random(1,5))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(stjerne);
    saveSpeed = new PVector(0,0,0);
    nr = objektNr;
    
    objektNr++;
  }
}
