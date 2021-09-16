PImage i;
PVector anchor, free;

void setup() {
  size(1626, 462);
  i = loadImage("Screen Shot 2019-04-03 at 9.13.13 PM.png");
  anchor = new PVector(width/2, height/2);
  free = new PVector(mouseX, mouseY);
  textSize(30);
}

void draw() {
  background(0);
  image(i, 0, 0);
  fill(0);
  text("Position mouse.  Click the set anchor (red).", 10, 25);
  stroke(255, 0, 0);
  ellipse(anchor.x, anchor.y, 7, 7);
  free.x = mouseX;
  free.y = mouseY;
  stroke(0, 255, 0);
  ellipse(free.x, free.y, 7, 7);
  text("Distance = " + int(dist(anchor.x, anchor.y, free.x, free.y)), 10, 50);
}

void mouseClicked() {
  anchor.x = mouseX;
  anchor.y = mouseY;
}
