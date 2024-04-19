class Star extends Object{
  PImage star;
  
  Star(float m, float x, float y, float r, PVector p) {
    mass = m;
    xPos = x;
    yPos = y;
    radius = r;
    saveSpeed = p;
    star = loadImage("Stjerne"+int(random(1,5))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(star);
    speed = new PVector(0,0,0);
    nr = objektNr;
    pickColor = random(80,180);
    
    objektNr++;
  }
}
