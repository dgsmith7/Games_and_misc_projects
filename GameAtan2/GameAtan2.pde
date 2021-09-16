
void setup() {
  size (500, 500);
  background(125);
  noStroke();
  strokeCap(SQUARE);
}

void draw () {
  background(125);
  displayTarget();
  displayGun();
}

void displayTarget() {
  float targetSize = 15;
  color targetColor = color(245, 50, 50);
  fill(targetColor);
  ellipse(mouseX, mouseY, targetSize, targetSize);
}

void displayGun() {
  color gunColor = color(85, 125, 65);
  float gunLen = 35;
  float gunWid = 10;
  float deltaX = mouseX - 250;
  float deltaY = mouseY - 250;
  float gunX, gunY;
  float theta = atan2(deltaY, deltaX);
  //  println(deltaX, deltaY, theta);
  gunX = 250 + cos(theta) * gunLen;
  gunY = 250 + sin(theta) * gunLen;
  stroke(gunColor);
  strokeWeight(gunWid);
  line(250, 250, gunX, gunY);
  noStroke();
}