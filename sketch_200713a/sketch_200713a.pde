float diam = 2;
float currentRadius = 45;
int rotator = 0;

void setup() {
  size(800, 800);
  fill(125);
  noLoop();
}

void draw() {
  for (float j = 0; j < 25; j++) {
    for (float i = 0; i < 360; i = i + 11.252) {
      if (rotator % 2 == 0) {
        ellipse((width/2) + cos(radians(i)) * currentRadius, (height/2) + sin(radians(i)) * currentRadius, diam, diam);
      } else {
        ellipse((width/2) + cos(radians(i + 5.625)) * currentRadius, (height/2) + sin(radians(i + 5.625)) * currentRadius, diam, diam);
      }
    }
    rotator++;
    diam += 2;
    currentRadius = currentRadius + (.98 * diam);
  }
}
