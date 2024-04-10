class Planet {
  float masse, xPos, yPos, radius, afstand, kraft;
  PVector speed;
  PVector pavirkning;
  PShape globe;
  PImage planet;
  
  Planet(float m, float x, float y, float r) {
    println("m: "+m+"  x: "+x+"  y: "+y+"  r: "+r);
    masse = m;
    xPos = x;
    yPos = y;
    radius = r;
    planet = loadImage("Planet"+int(random(1,6))+".jpg");
    globe = createShape(SPHERE, radius);
    globe.setTexture(planet);
    println(xPos);
    speed = new PVector(0,0,0);
  }
  
  //opdaterer planetens position
  void update() {
    pushMatrix();
    for (Planet planet : planets) {
      
      //Tjek afstanden til den valgte planet i ArrayListen
      afstand = sqrt(pow(planet.getX()-xPos, 2)+pow(planet.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (afstand != 0) {
        
        kraft = 6.674*pow(10, -11) * masse * planet.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, planet.getX(), yPos, planet.getY(), kraft)/masse*0.16666*4 , kraftFordelingY(xPos, planet.getX(), yPos, planet.getY(), kraft)/masse*0.16666*4,0);
        speed.add(pavirkning);
      }
    }
    //println(afstand+ "  "+kraft+"   "+pavirkning);
    
    println(xPos);
    
    xPos+=speed.x;
    yPos+=speed.y;
    
    translate(xPos, yPos, 0);
    shape(globe);
    popMatrix();
  }
  
  //returnerer x-position
  float getX() {
    return xPos;
  }
  
  //returnerer y-position
  float getY() {
    return yPos;
  }
  
  //retunerer massen
  float getMasse() {
    return masse;
  }
  
  void setSpeed(PVector s) {
    speed = s;
  }
}
