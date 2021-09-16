float radius = 50;
PVector position;
float burnRate;
float groundSpeed;
float usableFuel;
float mapScale;

void setup() {
  size(800, 800);
  noFill();
  position = new PVector(mouseX, mouseY);
  burnRate = 500;     //pph
  groundSpeed = 125;  //mph
  usableFuel = 3000;  //lbs
  mapScale = 3;       //
}

void draw() {
  background(125);
  position.x = mouseX;
  position.y = mouseY;
  radius = calculateRing();
  displayRangeRing();
  displayValues();
}

float calculateRing() {
  float result = ((usableFuel / burnRate) * groundSpeed) / mapScale;
  return result;
}

void displayRangeRing() {
  for (float i = radius; i > 0; i --) {
    stroke(255, 70, 5, map(i, 0, radius, 0, 100) );
    ellipse(position.x, position.y, i, i);
  }
}

void displayValues() {
  text("UseableFuel: " + usableFuel + "   BurnRate: " + burnRate + "   GroundSpeed: " + groundSpeed, 100, 700);
}

void keyPressed() {
  switch(key) {
    case 'q':
    case 'Q': {usableFuel += 10; break;}
    case 'a':
    case 'A': {usableFuel -= 10; break;}
    case 'w':
    case 'W': {burnRate += 10; break;}
    case 's':
    case 'S': {burnRate -= 10; break;}
    case 'e':
    case 'E': {groundSpeed += 10; break;}
    case 'd':
    case 'D': {groundSpeed -= 10; break;}
  }
}
