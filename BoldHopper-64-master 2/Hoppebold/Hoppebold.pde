ArrayList <Ball> bolde = new ArrayList <Ball>();
ArrayList <Jord> jorden = new ArrayList <Jord>();

void setup() {
  size(600, 600);
  //ellipseMode(CENTER);
  for (int i = 0; i<14; i++) {
    jorden.add(new Jord(120));
  }
}

void draw() {
  background(0);
  ground();
  for (Ball b : bolde) {
    b.movement();
    b.display();
  }

  for (Ball b1 : bolde) {
    for (Jord j1 : jorden) {
      
if(b1.hit2(j1)){
  
  println("true");
          float afstand = b1.location.dist(j1.location);
        //Hvor meget er de over hinanden?
        float overlap = 0.5 * (afstand - b1.radius - j1.radius);
        //Flyt dem så de ikke længere gør
        float flytX = overlap * (b1.location.x - j1.location.x) / afstand;
        float flytY = overlap * (b1.location.y - j1.location.y) / afstand; 

        b1.location.x -= flytX;
        b1.location.y -= flytY;

        /********** DYNAMISK OPFØRSEL *************/
        //Her håndteres der hastigheder og masser.

        //Ved ikke og jeg kan påvirke dem så ændrer dem ikke lige med det samme.
        PVector b1Coord = b1.location.copy(), 
          j1Coord = j1.location.copy();
        //Find vektoren mellem de to kolliderende kugler som svarer til normalen på kontaktfladen
        PVector normal = b1Coord.sub(j1Coord).normalize();
        //Find tangenten til de to cirkler (Hatter vektoren)
        PVector tangent = new PVector(-normal.y, normal.x);

        //Skal have opdelt begge hastigheder i x og y retning ved at prikke vektorerne med normalen og tangenten.
        //Her er det normalen som er vigtig, idet det forventes at kuglerne beholder tangenthastigheden (ved ikke om det er fysisk forsvarligt)

        float dpNorm1 = b1.velocity.x * normal.x + b1.velocity.y * normal.y; 
        float dpNorm2 = b1.velocity.x * normal.x + b1.velocity.y * normal.y; 

        //Bruger ligningen for det fuldstændige elastiske stød: https://en.wikipedia.org/wiki/Elastic_collision
        float v1 = ((b1.masse - b1.masse) * dpNorm1 + 2.0f * b1.masse * dpNorm2) / (b1.masse + b1.masse);

        //Samlet set må den nye retning være følgende:
        //b1.velocity.x = tangent.x * dpTan1 + normal.x * v1;
        b1.velocity.y *=-0.95;// tangent.y * dpTan1 + normal.y * v1;
        println(v1);
      }
      
} 
    
    for (Ball b2 : bolde) {
      if (b1.hit(b2)==true) {
        /********** STATISK OPFØRSEL *************/
        //Her holdes der styr på at boldene ikke kommer ind i hinanden
        //Bestem afstanden
        float afstand = b1.location.dist(b2.location);
        //Hvor meget er de over hinanden?
        float overlap = 0.5 * (afstand - b1.radius - b2.radius);
        //Flyt dem så de ikke længere gør
        float flytX = overlap * (b1.location.x - b2.location.x) / afstand;
        float flytY = overlap * (b1.location.y - b2.location.y) / afstand; 

        b1.location.x -= flytX;
        b1.location.y -= flytY;

        b2.location.x += flytX;
        b2.location.y += flytY;


        /********** DYNAMISK OPFØRSEL *************/
        //Her håndteres der hastigheder og masser.

        //Ved ikke og jeg kan påvirke dem så ændrer dem ikke lige med det samme.
        PVector b1Coord = b1.location.copy(), 
          b2Coord = b2.location.copy();
        //Find vektoren mellem de to kolliderende kugler som svarer til normalen på kontaktfladen
        PVector normal = b1Coord.sub(b2Coord).normalize();
        //Find tangenten til de to cirkler (Hatter vektoren)
        PVector tangent = new PVector(-normal.y, normal.x);

        //Skal have opdelt begge hastigheder i x og y retning ved at prikke vektorerne med normalen og tangenten.
        //Her er det normalen som er vigtig, idet det forventes at kuglerne beholder tangenthastigheden (ved ikke om det er fysisk forsvarligt)
        float dpTan1 = b1.velocity.x * tangent.x + b1.velocity.y * tangent.y; 
        float dpTan2 = b2.velocity.x * tangent.x + b2.velocity.y * tangent.y;

        float dpNorm1 = b1.velocity.x * normal.x + b1.velocity.y * normal.y; 
        float dpNorm2 = b2.velocity.x * normal.x + b2.velocity.y * normal.y; 

        //Bruger ligningen for det fuldstændige elastiske stød: https://en.wikipedia.org/wiki/Elastic_collision
        float v1 = ((b1.masse - b2.masse) * dpNorm1 + 2.0f * b2.masse * dpNorm2) / (b1.masse + b2.masse);
        float v2 = (2 * b1.masse * dpNorm1 + (b2.masse - b1.masse) * dpNorm2) / (b1.masse + b2.masse);

        //Samlet set må den nye retning være følgende:
        b1.velocity.x = tangent.x * dpTan1 + normal.x * v1;
        b1.velocity.y = tangent.y * dpTan1 + normal.y * v1;

        b2.velocity.x = tangent.x * dpTan2 + normal.x * v2;
        b2.velocity.y = tangent.y * dpTan2 + normal.y * v2;
        println(v1);
      }
    }
  }
}




void ground() {
  for (Jord jord : jorden) {
    jord.display();
  }
}


void mousePressed() {
  //Bold bliver tilføjet når der trykkes
  bolde.add(new Ball());
}
