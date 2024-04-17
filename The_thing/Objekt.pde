class Object {
  float mass, xPos, yPos, radius, distance, force, massCalculation, nr, pickColor;
  PVector speed, saveSpeed, changes;
  PShape globe;
  
  //opdaterer planetens position
  void update() {
    speed = saveSpeed;
    xPos+=speed.x;
    yPos+=speed.y;
  }
  
  //beregning af tyngdekraft
  void gravity() {
    for (Planet planet : planets) {
      
      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(planet.getX()-xPos, 2)+pow(planet.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {
        
        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= planet.getMass();
        
        changes = new PVector(forceDistributionX(xPos, planet.getX(), yPos, planet.getY(), force)/mass*0.016666*interval , 
        forceDistributionY(xPos, planet.getX(), yPos, planet.getY(), force)/mass*0.016666*interval, 0);
        
        saveSpeed.add(changes);
        
        
      }
    }
    for (Star star : stars) {
      
      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(star.getX()-xPos, 2)+pow(star.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {
        
        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= star.getMass();
        
        changes = new PVector(forceDistributionX(xPos, star.getX(), yPos, star.getY(), force)/mass*0.016666*interval , 
        forceDistributionY(xPos, star.getX(), yPos, star.getY(), force)/mass*0.016666*interval, 0);
        
        saveSpeed.add(changes);
        
      }
    }
    for (BlackHole blackhole : blackholes) {
      
      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(blackhole.getX()-xPos, 2)+pow(blackhole.getY()-yPos, 2));
      
      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {
        
        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= blackhole.getMass();
        
        changes = new PVector(forceDistributionX(xPos, blackhole.getX(), yPos, blackhole.getY(), force)/mass*0.016666*interval , 
        forceDistributionY(xPos, blackhole.getX(), yPos, blackhole.getY(), force)/mass*0.016666*interval, 0);
        
        saveSpeed.add(changes);
        
      }
    }
  }
  
  void objectDraw() {
    pushMatrix();
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
  
  float getDistance() {
    return sqrt(pow(xPos,2)+pow(yPos,2));
  }
  
  //retunerer massen
  float getMass() {
    return mass;
  }
  
  float getRadius() {
    return radius;
  }
  
  void setSpeed(PVector s) {
    saveSpeed = s;
  }
  
  void setNr(int n) {
    nr = n;
  }
  
  void setMass(float m) {
    mass = m;
  }
}
