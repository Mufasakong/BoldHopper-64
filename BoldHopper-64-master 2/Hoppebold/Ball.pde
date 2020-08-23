
class Ball {

  PVector location;  //Boldens placering
  PVector velocity;  //Boldens hastighed
  PVector gravity;   //Boldens tyngdekraft
  int topspeed;      //Boldens tophastighed 
  
  
  //NYE TING!
  float masse;       //Boldens masse
  float radius;
  
  Ball() {
    location = new PVector(mouseX, mouseY);
    velocity = new PVector(1.5, 2.0);
    gravity = new PVector(0, 0.2);
    topspeed = 100;
    
    
    //NYE TING!
    masse = 2.0f;
    radius = 25f;
  }



  void movement() {
    //Boldens placering bliver påvirket af hastigheden 
    location.add(velocity);
    //Boldens hastighed bliver påvirket af tyngdekraften
    velocity.add(gravity);
    //Bolden er begrænset af topspeed 
    velocity.limit(topspeed);

    // Bouncer fra højre eller venstre del af tegnefladen
    if ((location.x > width) || (location.x < 0)) {
      velocity.x = velocity.x * -1;
    }

    // Bouncer fra bund og top
    if (location.y > height || (location.y < 0)) {

      // Hastigheden bliver mindre hver gang den rammer jorden
      velocity.y = velocity.y * -0.95; 
      location.y = height;
    }
  }

  boolean hit ( Ball b) {
  //Anbefaler i stedet at bruge if(this == b) return false;

    float afstand = dist(b.location.x, b.location.y, location.x, location.y);
    boolean denSamme = (b == this); 
    boolean rammer = afstand < 50;
    return  rammer && !denSamme;
  }

  void display() {
    //Bolden bliver tegnet
    stroke(255);
    strokeWeight(10);
    noFill();
    ellipse(location.x, location.y, 50, 50);
  }
}
