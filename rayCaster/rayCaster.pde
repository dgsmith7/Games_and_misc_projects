
// needs collision detection between mover and wall
// needs bots
// try sim flight with angle of bank for turns and always moving fwd  ( need to centralize all drawing to pull off rotation)
// try a map in an external file

// try using tiles instead of lines (so a map can be an array)

// try fps head to head over network

// how to move map and not player

Caster c1;
int sceneFOV = 80;  // will be constrained to an even number between 40 and 180
int turn =0;
PVector moveDir = new PVector(0, 0);

Wall[] allWalls = new Wall[7]; 
float[] scene = new float[360];
int r1l, r1h, r2l, r2h;
String m = "top";
float wide = 500;
float high = 500;

void setup() {
  size(1000, 500);
  stroke(255);
  cleanupFOV();
  initWalls();
  initCasters();
  textSize(35);
}

void draw() {
  background(0);
  noStroke();
  noCursor();
  fill(25, 50, 25);
  rectMode(CORNER);
  rect(500, 250, 500, 500);
  displayWalls();
  c1.updatePosition();
  c1.display();
  scene = c1.scan();
  displayScene();
}

void cleanupFOV() {
  if (sceneFOV % 2 != 0) {
    sceneFOV += 1;
  }
  if (sceneFOV < 40) {
    sceneFOV = 40;
  }
  if (sceneFOV > 180) {
    sceneFOV = 180;
  }
}

void initWalls() {
  allWalls[0] = new Wall(0, 0, 500, 0);
  allWalls[1] = new Wall(500, 0, 500, 500);
  allWalls[2] = new Wall(500, 500, 0, 500);
  allWalls[3] = new Wall(0, 500, 0, 0);
  allWalls[4] = new Wall(100, 100, 350, 100);
  allWalls[5] = new Wall(200, 200, 300, 300);
  allWalls[6] = new Wall(400, 200, 400, 350);
}

void displayWalls() {
  for (int i = 0; i < allWalls.length; i++) {
    allWalls[i].display();
  }
}

void initCasters() {
  c1 = new Caster();
}

void displayScene() {
  fill(255);
  text("hdg:"+c1.hdg+" r1l:"+r1l+" r1h:"+r1h+" r2l:"+r2l+" r2h:"+r2h, 50, 50);
  noStroke();
  rectMode(CENTER);
  float interval = wide / sceneFOV;
  determineRanges();
  int rectCounter = 0;
  noStroke();
  for (int i = r1l; i < r1h+1; i ++) {
    stroke(255);
    fill(0, 0, map(scene[i] * scene[i], 0, wide * wide, 100, 50));
    pushMatrix();
    translate(wide, high/2);
    rect(rectCounter * interval, 0, interval+1, (20 * high) / scene[i]);
    rectCounter++;
    popMatrix();
  }
  for (int i = r2l; i < r2h+1; i ++) {
    stroke(255);
    fill(0, 0, map(scene[i] * scene[i], 0, wide * wide, 100, 50));
    pushMatrix();
    translate(wide, high/2);
    rect(rectCounter * interval, 0, interval+1, (20 * high) / scene[i]);
    rectCounter++;
    popMatrix();
  }
}

void keyPressed() {
    int moveMag = 10;
  switch (key) {
    case 'w':{
      moveDir = new PVector(cos(radians(c1.hdg))*moveMag, sin(radians(c1.hdg))*moveMag);
      c1.position.add(moveDir );
      break;
    }
    case 'd':{
      moveDir  = new PVector(cos(radians(c1.hdg)+HALF_PI)*moveMag, sin(radians(c1.hdg)+HALF_PI)*moveMag);
      c1.position.add(moveDir );
      break;
    }
    case 'a':{
      moveDir  = new PVector(cos(radians(c1.hdg)-HALF_PI)*moveMag, sin(radians(c1.hdg)-HALF_PI)*moveMag);
      c1.position.add(moveDir );
      break;
    }
    case 's':{
      moveDir  = new PVector(cos(radians(c1.hdg)-PI)*moveMag, sin(radians(c1.hdg)-PI)*moveMag);
      c1.position.add(moveDir );
      break;
    }
  }
}

void mouseMoved() {
  if (pmouseX < mouseX) {
    c1.hdg = c1.hdg + 1;
    if (c1.hdg >= 360) {
      c1.hdg = 0;
    }
  } 
  if (pmouseX > mouseX) {
    c1.hdg = c1.hdg - 1;
    if (c1.hdg <= -1) {
      c1.hdg = 359;
    }
  }
}
 


void determineRanges() {
  int halfView = int(sceneFOV/2);
  if ((c1.hdg + halfView) + (c1.hdg - halfView) >= sceneFOV && (c1.hdg + halfView <= 359)) {
    r1l = c1.hdg - halfView;
    r1h = c1.hdg - 1;
    r2l = c1.hdg;
    r2h = c1.hdg + halfView;
    m = "top";
  } else {
    r1l = c1.hdg - halfView + (360 * int(c1.hdg - halfView < 0));
    r1h = 359;
    r2l = 0;
    r2h = c1.hdg + halfView - (360 * int(c1.hdg + halfView > 359));
    m = "bottom";
  }
}
