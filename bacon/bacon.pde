PImage img;

void setup() {
  size(1624, 795);
  img = loadImage("baconSlice.png");
  textSize(120);
  fill(130, 20, 20);
  noLoop();
}

void draw() {
  background(140, 230, 240);
  image(img, 50, 50);
  text("1000010", 100, 120);
  text("1000010", 100, 240);
  text("1000011", 100, 360);
  saveFrame("baconSlice.png");
}
