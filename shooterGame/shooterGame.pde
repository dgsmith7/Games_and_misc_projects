Ship s;
Enemy e;
int nMissiles = 5;
Missile[] arsenal = new Missile[nMissiles];
boolean enemyHit = false;
boolean enemyCrossed = false;
int shipScore = 0;
int enemyScore = 0;
int missileCounter = 0;

void setup() {
  size(500, 500);
  textSize(32);
  initGamePieces();
}

void draw() {
  background(125);
  s.display();
  s.move();
  e.display();
  e.move();
  displayMissiles();
  moveMissiles();
  checkMissilePositions();
  checkCollissions();
  if (enemyHit == true) {
    e = new Enemy();
    shipScore ++;
  }
  checkEnemyOffScreen();
  if (enemyCrossed == true) {
    e = new Enemy();
    enemyScore ++;
  }
  showScore();
}

void initGamePieces() {
  s = new Ship();
  e = new Enemy();
  for (int i = 0; i < nMissiles; i ++) {
    arsenal[i] = new Missile(s.x);
    arsenal[i].live = false;
  }
}

void displayMissiles() {
  for (int i = 0; i < nMissiles; i++) {
    arsenal[i].display();
  }
}

void moveMissiles() {
  for (int i = 0; i < nMissiles; i++) {
    arsenal[i].move();
  }
}

void checkMissilePositions() {
  for (int i = 0; i < nMissiles; i++) {
    arsenal[i].checkOnScreen();
  }
}

void checkCollissions() {
  enemyHit = false;
  for (int i = 0; i < nMissiles; i ++) {
    if ((arsenal[i].live == true) && (dist(arsenal[i].x, arsenal[i].y, e.x, e.y) < 35)) {
      arsenal[i].live = false;
      enemyHit = true;
    }
  }
}

void checkEnemyOffScreen() {
  enemyCrossed = false;
  if (e.x >= width) {
    enemyCrossed = true;
  }
}
void showScore() {
  fill(0, 0, 255);
  text(shipScore, 450, 50);
  fill(255, 0, 0);
  text(enemyScore, 450, 75);
}

void keyPressed() {
}

void mouseClicked() {
  if (arsenal[missileCounter].live == false) {
    arsenal[missileCounter] = new Missile(s.x);
    missileCounter++;
    if (missileCounter == nMissiles) {
      missileCounter = 0;
    }
  }
}
