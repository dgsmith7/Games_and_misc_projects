boolean export = false;
PImage img;

void setup() {
  size (2400, 400);
  noLoop();
}

void draw() {
  img = loadImage("Screen Shot 2021-08-14 at 1.53.34 PM.png");
  background(125);
  image(img, 0, 0);
  saveFrame("logoWide.png");
}
