class Object {
  float mass, xPos, yPos, radius, distance, force, massCalculation, dens;
  PVector speed, saveSpeed, changes, ekstraSpeed;
  PShape globe, square, cone;
  String type, name;
  boolean delete, ringsOn, collision;
  int deleteNr, nr, ID, cyklus;
  PImage surface, ring;
  int[] trailX = new int[0];
  int[] trailY = new int[0];

  //opdaterer planetens position
  void update() {
    
    //tilføjer position til halens længde
    if (cyklus > 1) {
      trailX = append(trailX, int(xPos));
      trailY = append(trailY, int(yPos));
    }
    
    //fjerner position fra halens længde
    if (trailX.length > 50) {
      trailX = subset(trailX, 1);
      trailY = subset(trailY, 1);
    }
    
    //opdatere cyklussen
    //cyklussen gør at det kun er hver tredje gang koden bliver indlæst at, der bliver tilføjet/fjernet positioner fra halens længden
    if (cyklus > 1) {
      cyklus = 0;
    } else {
      cyklus++;
    }
    
    //Ændre fart efter kollision
    if (collision) {
      speed.x = ekstraSpeed.x;
      speed.y = ekstraSpeed.y;
    }
    
    //opdatere objektets position
    collision = false;
    speed.add(saveSpeed);
    xPos+=speed.x;
    yPos+=speed.y;
    saveSpeed = new PVector(0, 0, 0);
  }

  //beregning af tyngdekraft
  void gravity() {
    for (Object object : objects) {

      //Tjek afstanden til den valgte planet i ArrayListen
      distance = sqrt(pow(object.getX()-xPos, 2)+pow(object.getY()-yPos, 2));

      //hvis afstanden er 0, betyder det at den har tjekket afstanden til den selv
      if (distance != 0) {
        
        if (type.equals("black hole")) { //tjekker om objektet er et sort hul
        
          //fjerner det andet objekt hvis det er tæt nok, samt øger det sorte huls masse
          if (abs(distance) <= object.getRadius()+radius) {
            if (object.getType().equals("black hole")) {
              if (object.getMass() < mass) {
                delete = true;
                deleteNr = object.getNr();
              }
            } else {
              delete = true;
              deleteNr = object.getNr();
            }
          }
          
        } else if (type.equals("star")) { //tjekker om objektet er en stjerne
        
          //fjerne det andet objekt hvis det er tæt nok, og det er en planet
          if (abs(distance) <= object.getRadius()/3+radius) {
            if (object.getMass() < mass) {
              if (!object.getType().equals("black hole")) {
                delete = true;
                deleteNr = object.getNr();
              }
            }
          }
          
        } else if (type.equals("planet")) { //tjekker om objektet er en planet
          
          //laver en kollision mellem de to objekter, hvis det de er tæt nok på hinanden
          if (object.getType().equals("planet")) {
            if (abs(distance) <= object.getRadius()+radius) {
              collision = true;
              ekstraSpeed.x=(2*object.getMass()*object.getSpeedX()-object.getMass()*speed.x+mass*speed.x)/(mass+object.getMass());
              ekstraSpeed.y=(2*object.getMass()*object.getSpeedY()-object.getMass()*speed.y+mass*speed.y)/(mass+object.getMass());
            }
          }
        }
        
        //beregner kraftpåvirkningen på objektet
        distance = pixelToM(distance);
        massCalculation = 0.00000000006674 * mass;
        force = massCalculation/pow(distance, 2);
        force *= object.getMass();

        changes = new PVector(forceDistributionX(xPos, object.getX(), yPos, object.getY(), force)/mass*0.016666*interval,
          forceDistributionY(xPos, object.getX(), yPos, object.getY(), force)/mass*0.016666*interval, 0);

        saveSpeed.add(changes);


        changes = new PVector(0, 0, 0);
      }
    }
    
    if (delete) { //tjekker om et objekt skal slettes
    
      //beregner fart efter kollision
      speed = collisionSpeed(speed.x, objects.get(deleteNr).getSpeedX(), speed.y, objects.get(deleteNr).getSpeedY(), mass, objects.get(deleteNr).getMass() );
      
      if (type.equals("black hole")) { //tjekker om objektet er et sort hul
      
        //omregner det sorte huls masse og radius
        mass = objects.get(deleteNr).getMass()+mass;
        radius = mToPixel(2*6.674*pow(10, -11)*mass/pow(300000000, 2))*107290;
        
      } else {
        
        //Omregner stjernens masse og radius
        dens = mass/(4*PI*pow(radius, 2));
        mass = objects.get(deleteNr).getMass()+mass;
        radius = sqrt(mass/(dens*4*PI));
        
      }
      
      //geninitialisere objektets form
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

  //funktion for at tegne objektet
  void objectDraw() {
    pushMatrix();
    count = 0;
    
    //tegner hale på objekt
    for (int i = 0; i < trailX.length-1; i++) {
      strokeWeight(2+(count/20));
      stroke(255, 90);
      line(trailX[i], trailY[i], 0, trailX[i+1], trailY[i+1], 0);
      count++;
    }
    
    //tegner selve objektet
    count = 0;
    noFill();
    noStroke();
    translate(xPos, yPos, 0);
    if (ringsOn) {
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
  
  //returnerer distancen mellem objekt og midten af universet
  float getDistance() {
    return sqrt(pow(xPos, 2)+pow(yPos, 2));
  }

  //retunerer massen
  float getMass() {
    return mass;
  }
  
  //returnerer radius
  float getRadius() {
    return radius;
  }
  
  //returnerer objektets nr
  int getNr() {
    return nr;
  }
  
  //returnerer objekts fart i x-aksen
  float getSpeedX() {
    return speed.x;
  }
  
  //returner objekts fart i y-aksen
  float getSpeedY() {
    return speed.y;
  }
  
  //returner objektets fartvektor
  PVector getSpeed() {
    return speed;
  }
  
  //returnerer objektets ID
  int getID() {
    return ID;
  }
  
  //returnerer objektets type
  String getType() {
    return type;
  }
  
  //returnerer objektets form
  PShape getShape() {
    return globe;
  }
  
  //returnerer objektets overfladetextur
  PImage getTexture() {
    return surface;
  }
  
  //returnerer objektets navn
  String getObjectName() {
    return name;
  }
  
  //returnerer objekts ringe
  boolean ifRings() {
    return ringsOn;
  }
  
  //setter objektets fart
  void setSpeed(PVector s) {
    speed = s;
  }
  
  //setter objektets nr
  void setNr(int n) {
    nr = n;
  }
  
  //setter objektets masse
  void setMass(float m) {
    mass = m;
  }
  
  //setter objektets textur
  void setTexture(String str) {
    globe.setTexture(loadImage(str));
  }
  
  //setter objektets radius
  void setRadius(float r) {
    if (!type.equals("black hole")) {
      radius = r;
    }
  }
  
  //setter objektets navn
  void setObjectName(String str) {
    name = str;
  }
  
  //setter objektets ringe
  void setRings(boolean b) {
    ringsOn = b;
  }
  
  //restter objektets form
  void resetGlobe() {
    globe = createShape(SPHERE, radius);
    globe.setTexture(surface);
  }
  
  //returnerer kollisionsfarten
  PVector collisionSpeed(float x1, float x2, float y1, float y2, float m1, float m2) {
    return new PVector((x1*m1+x2*m2)/(m1+m2), (y1*m1+y2*m2)/(m1+m2), 0);
  }
  
}
