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
        
        afstand *= 149900000/200;
        kraft = 6.674*pow(10, -11) * masse * planet.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, planet.getX(), yPos, planet.getY(), kraft)/masse*0.16666*200/149900000 , kraftFordelingY(xPos, planet.getX(), yPos, planet.getY(), kraft)/masse*0.16666*200/149900000,0);
        saveSpeed.add(pavirkning);
        println(pavirkning);
      }
    }
    for (Stjerne stjerne : stjernes) {
      
      //Tjek afstanden til den valgte stjerne i ArrayListen
      afstand = sqrt(pow(stjerne.getX()-xPos, 2)+pow(stjerne.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (afstand != 0) {
        
        afstand *= 149900000/200;        
        kraft = 6.674*pow(10, -11) * masse * stjerne.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, stjerne.getX(), yPos, stjerne.getY(), kraft)/masse*0.16666*200/149900000 , kraftFordelingY(xPos, stjerne.getX(), yPos, stjerne.getY(), kraft)/masse*0.16666,0*200/149900000);
        saveSpeed.add(pavirkning);
      }
    }
    for (SortHul sorthul : sorthuls) {
      
      //Tjek afstanden til den valgte stjerne i ArrayListen
      afstand = sqrt(pow(sorthul.getX()-xPos, 2)+pow(sorthul.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (afstand != 0) {
        
        afstand *= 149900000/200;
        kraft = 6.674*pow(10, -11) * masse * sorthul.getMasse()/pow(afstand, 2);
        pavirkning = new PVector(kraftFordelingX(xPos, sorthul.getX(), yPos, sorthul.getY(), kraft)/masse*0.16666*200/149900000 , kraftFordelingY(xPos, sorthul.getX(), yPos, sorthul.getY(), kraft)/masse*0.16666,0*200/149900000);
        saveSpeed.add(pavirkning);
      }
    }
    
    
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
