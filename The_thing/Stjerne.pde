class Star extends Object{
  PImage star;
  
  Star(float m, float x, float y, float r) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    star = loadImage("Stjerne"+int(random(1,5))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(star);
    saveSpeed = new PVector(0,0,0);
    nr = objektNr;
    
    objektNr++;
  }
}
