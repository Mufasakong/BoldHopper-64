ArrayList <Ball> bolde = new ArrayList <Ball>();


void setup() {
  size(600,600);
  //ellipseMode(CENTER);
}
  
  void draw() {
  background(0);
  
  for (Ball b: bolde) {
   b.movement();
   b.display();
 }
  
  
}

void mousePressed(){
  //Bold bliver tilføjet når der trykkes
  bolde.add(new Ball());
}
