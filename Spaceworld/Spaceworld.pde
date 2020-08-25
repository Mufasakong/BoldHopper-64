PImage[] SpaceBar = new PImage[80];
int x = 1;

void setup() {
  size( 1000, 600 );
  smooth();
  for(int i = 1; i < SpaceBar.length; i++) {
  SpaceBar[i] = loadImage( "Space " + "(" + i + ")" + ".gif");
    }
  }

void draw() {
  PImage img = SpaceBar[frameCount%80];
  if(img != null)
  image(img, 0, 0, width, height);
}
