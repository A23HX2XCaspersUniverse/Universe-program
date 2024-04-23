class Object {
  float mass, xPos, yPos, radius, distance, force, massCalculation, pickColor;
  PVector speed, saveSpeed, changes;
  PShape globe, square, cone;
  String type, name;
  boolean delete;
  int deleteNr, nr, ID;
  PImage surface, ring;
  int[] trailX = new int[0];
  int[] trailY = new int[0];

  //opdaterer planetens position
  void update() {
    trailX = append(trailX, int(xPos));
    trailY = append(trailY, int(yPos));
    if (trailX.length > 300) {
      trailX = subset(trailX, 1);
      trailY = subset(trailY, 1);
    }
    speed.add(saveSpeed);
    xPos+=speed.x;
    yPos+=speed.y;
    saveSpeed = new PVector(0, 0, 0);
  }

  //beregning af tyngdekraft
  void gravity() {
    for (Object planet : objects) {

      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(planet.getX()-xPos, 2)+pow(planet.getY()-yPos, 2));

      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {

        if (type.equals("black hole")) {
          println(radius);
          if (abs(distance) <= planet.getRadius()+radius) {
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
      speed = collisionSpeed(speed.x, objects.get(deleteNr).getSpeedX(), speed.y, objects.get(deleteNr).getSpeedY(), mass, objects.get(deleteNr).getMass() );
      mass = objects.get(deleteNr).getMass()+mass;
      radius = mToPixel(2*6.674*pow(10, -11)*mass/pow(300000000, 2))*107290;
      globe = createShape(SPHERE, radius);
      globe.setTexture(surface);
      for (int i = 0; i < sidebars.size(); i++) {
        if (objects.get(deleteNr).getID() == sidebars.get(i).getID()) {
          sidebars.remove(i);
          break;
        }
      }
      objects.remove(deleteNr);
    }
    delete = false;
    deleteNr = 0;
  }


  void objectDraw() {
    pushMatrix();
    count = 0;
    for (int i = 0; i < trailX.length-1; i++) {
      strokeWeight(2+(count/60));
      stroke(255, 90);
      line(trailX[i], trailY[i], 0, trailX[i+1], trailY[i+1], 0);
      count++;
    }
    count = 0;
    noFill();
    noStroke();
    translate(xPos, yPos, 0);
    if (square != null) {
      shape(square);
    }
    rotateX(PI/2);
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

  int getID() {
    return ID;
  }

  String getType() {
    return type;
  }

  PShape getShape() {
    return globe;
  }

  PImage getTexture() {
    return surface;
  }

  String getObjectName() {
    return name;
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

  void setTexture(String str) {
    globe.setTexture(loadImage(str));
  }

  void setRadius(float r) {
    if (type.equals("black hole")) {
      radius = r;
    }
  }
  
  void setObjectName(String str) {
    name = str;
  }

  PVector collisionSpeed(float x1, float x2, float y1, float y2, float m1, float m2) {
    return new PVector((x1*m1+x2*m2)/(m1+m2), (y1*m1+y2*m2)/(m1+m2), 0);
  }
  
  void collision() {
  }
}
