class SortHul extends Objekt{
  PImage stjerne;
  
  SortHul(float m, float x, float y) {
    masse = m*pow(10,-24);
    xPos = x;
    yPos = y;
    radius = 2*6.674*pow(10, -11)*m/pow(300000000,2);
    println(radius);
    stjerne = loadImage("black.jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(stjerne);
    saveSpeed = new PVector(0,0,0);
  }
}
