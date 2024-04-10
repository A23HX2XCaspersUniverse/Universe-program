class Planet extends Objekt{
  PImage planet;
  
  Planet(float m, float x, float y, float r) {
    masse = m;
    xPos = x;
    yPos = y;
    radius = r;
    planet = loadImage("Planet"+int(random(1,6))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(planet);
    println(xPos);
    saveSpeed = new PVector(0,0,0);
  }
}
