class Objekt {
  float masse, xPos, yPos, radius, afstand, kraft;
  PVector speed, saveSpeed, pavirkning;
  PShape globe;
  
  //opdaterer planetens position
  void update() {
    speed = saveSpeed;
    xPos+=speed.x;
    yPos+=speed.y;
  }
  
  //beregning af tyngdekraft
  void tyngdekraft() {
    pushMatrix();
    for (Planet planet : planets) {
      
      //Tjek afstanden til den valgte planet i ArrayListen
      afstand = sqrt(pow(planet.getX()-xPos, 2)+pow(planet.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (afstand != 0) {
        
        kraft = 6.674*pow(10, -11) * masse * planet.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, planet.getX(), yPos, planet.getY(), kraft)/masse*0.16666*4 , kraftFordelingY(xPos, planet.getX(), yPos, planet.getY(), kraft)/masse*0.16666*4,0);
        saveSpeed.add(pavirkning);
      }
    }
    for (Stjerne stjerne : stjernes) {
      
      //Tjek afstanden til den valgte stjerne i ArrayListen
      afstand = sqrt(pow(stjerne.getX()-xPos, 2)+pow(stjerne.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (afstand != 0) {
        
        kraft = 6.674*pow(10, -11) * masse * stjerne.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, stjerne.getX(), yPos, stjerne.getY(), kraft)/masse*0.16666*4 , kraftFordelingY(xPos, stjerne.getX(), yPos, stjerne.getY(), kraft)/masse*0.16666*4,0);
        saveSpeed.add(pavirkning);
      }
    }
    
    println(xPos);
    
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
    saveSpeed = s;
  }
}
