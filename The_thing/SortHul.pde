class BlackHole extends Object{
  PImage blackhole;
  
  BlackHole(float m, float x, float y, PVector p) {
    mass = m;
    xPos = x;
    yPos = y;
    saveSpeed = p;
    radius = mToPixel(2*6.674*pow(10, -11)*m/pow(300000000,2))*107290;
    println(radius);
    blackhole = loadImage("black.jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(blackhole);
    speed = new PVector(0,0,0);
    nr = objektNr;
    pickColor = random(80,180);
    
    objektNr++;
  }
}
