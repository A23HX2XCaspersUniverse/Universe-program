class Object {
  float mass, xPos, yPos, radius, distance, force, massCalculation, pickColor;
  PVector speed, saveSpeed, changes;
  PShape globe;
  String type;
  boolean delete;
  int deleteNr, nr;

  //opdaterer planetens position
  void update() {
    speed.add(saveSpeed);
    xPos+=speed.x;
    yPos+=speed.y;
    saveSpeed = new PVector(0, 0, 0);
  }

  //beregning af tyngdekraft
  void gravity() {
    for (Planet planet : planets) {

      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(planet.getX()-xPos, 2)+pow(planet.getY()-yPos, 2));

      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {

        if (type.equals("black hole")) {
          if (abs(distance) <= planet.getRadius()+radius-10) {
            delete = true;
            deleteNr = planet.getNr();
          }
        }

        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= planet.getMass();

        changes = new PVector(forceDistributionX(xPos, planet.getX(), yPos, planet.getY(), force)/mass*0.016666*interval,
          forceDistributionY(xPos, planet.getX(), yPos, planet.getY(), force)/mass*0.016666*interval, 0);

        saveSpeed.add(changes);


        changes = new PVector(0, 0, 0);
      }
    }
    if (delete) {
        speed = collisionSpeed(speed.x, planets.get(deleteNr).getSpeedX(), speed.y, planets.get(deleteNr).getSpeedY(), mass, planets.get(deleteNr).getMass() );
        mass = planets.get(deleteNr).getMass()+mass;
        planets.remove(deleteNr);
      }
      delete = false;
      deleteNr = 0;
    for (Star star : stars) {

      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(star.getX()-xPos, 2)+pow(star.getY()-yPos, 2));

      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {

        if (type.equals("black hole")) {
          if (abs(distance) <= star.getRadius()+radius-10) {
            delete = true;
            deleteNr = star.getNr();
          }
        }

        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= star.getMass();

        changes = new PVector(forceDistributionX(xPos, star.getX(), yPos, star.getY(), force)/mass*0.016666*interval,
          forceDistributionY(xPos, star.getX(), yPos, star.getY(), force)/mass*0.016666*interval, 0);

        saveSpeed.add(changes);

        changes = new PVector(0, 0, 0);
      }
    }

    if (delete) {
      speed = collisionSpeed(speed.x, stars.get(deleteNr).getSpeedX(), speed.y, stars.get(deleteNr).getSpeedY(), mass, stars.get(deleteNr).getMass() );
      mass = stars.get(deleteNr).getMass()+mass;
      stars.remove(deleteNr);
    }
    delete = false;
    deleteNr = 0;

    for (BlackHole blackhole : blackholes) {

      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(blackhole.getX()-xPos, 2)+pow(blackhole.getY()-yPos, 2));

      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {

        if (type.equals("black hole")) {
          if (abs(distance) <= blackhole.getRadius()+radius-10) {
            delete = true;
            deleteNr = blackhole.getNr();
          }
        }

        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= blackhole.getMass();

        changes = new PVector(forceDistributionX(xPos, blackhole.getX(), yPos, blackhole.getY(), force)/mass*0.016666*interval,
          forceDistributionY(xPos, blackhole.getX(), yPos, blackhole.getY(), force)/mass*0.016666*interval, 0);

        saveSpeed.add(changes);


        changes = new PVector(0, 0, 0);
      }
    }
    if (delete) {
      speed = collisionSpeed(speed.x, blackholes.get(deleteNr).getSpeedX(), speed.y, blackholes.get(deleteNr).getSpeedY(), mass, blackholes.get(deleteNr).getMass() );
      mass = blackholes.get(deleteNr).getMass()+mass;
      blackholes.remove(deleteNr);
    }
    delete = false;
    deleteNr = 0;
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
    return sqrt(pow(xPos, 2)+pow(yPos, 2));
  }

  //retunerer massen
  float getMass() {
    return mass;
  }

  float getRadius() {
    return radius;
  }

  int getNr() {
    return nr;
  }
  
  float getSpeedX() {
    return speed.x;
  }
  
  float getSpeedY() {
    return speed.y;
  }

  void setSpeed(PVector s) {
    speed = s;
  }

  void setNr(int n) {
    nr = n;
  }

  void setMass(float m) {
    mass = m;
  }
  
  PVector collisionSpeed(float x1, float x2, float y1, float y2, float m1, float m2) {
    return new PVector((x1*m1+x2*m2)/(m1+m2),(y1*m1+y2*m2)/(m1+m2), 0);
  }
}
