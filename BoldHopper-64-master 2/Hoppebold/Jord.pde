class Jord {

  PVector location;
  float d;
  float masse;
  float radius;

  Jord(float diameter) {

    location = new PVector(random(0,width),height );
    d= diameter;
    masse =20f;
    radius = d;
  }

  void display(){
  fill(255);
  ellipse(location.x,location.y,d,d);
  
  }
}
