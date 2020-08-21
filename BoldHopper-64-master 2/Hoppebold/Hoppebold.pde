ArrayList <Ball> bolde = new ArrayList <Ball>();
Ball ball;

void setup() {
  size(600, 600);
  //ellipseMode(CENTER);
}

void draw() {
  background(0);

  for (Ball b : bolde) {
    b.movement();
    b.display();
  }

  for (Ball b1 : bolde) { 
      for (Ball b2 : bolde) {
        if(b1.hit(b2)==true){
       println("true");
       b1.velocity.x= b1.velocity.x*-1;
       b1.velocity.y= b1.velocity.y*-1;
      // b2.velocity.x= b2.velocity.x*-1;
        }
      }
    }
  }


void mousePressed() {
  //Bold bliver tilføjet når der trykkes
  bolde.add(new Ball());
}
