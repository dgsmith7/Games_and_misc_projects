int nBarriers = 4;
Barrier[] allBarriers = new Barrier[4 + nBarriers];
Caster caster1;
Ray r;
float wide, high;
float[] scene;
float distProj;

void setup() {
  size (1000, 400);
  wide = width / 2;
  high = height;
  initBarriers();
  initCasters();
  distProj = (wide / 2) / tan(caster1.fov / 2); 
}

void draw() {
  background(0);
  displayBarriers();
  caster1.updatePosit(mouseX, mouseY);
  caster1.display();
  scene = caster1.look(allBarriers);
  displayScene();
}


void initCasters() {
  caster1 = new Caster();
  caster1.rotateToHdg();
}

void initBarriers() {
  allBarriers[0] = new Barrier(0, 0, wide, 0);
  allBarriers[1] = new Barrier(wide, 0, wide, high);
  allBarriers[2] = new Barrier(wide, high, 0, high);
  allBarriers[3] = new Barrier(0, high, 0, 0);
  for (int i = 4; i < (4 + nBarriers); i ++) {
    allBarriers[i] = new Barrier(int(random(wide)), int(random(high)), 
                                 int(random(wide)), int(random(high)));
  }
  //allBarriers[4] = new Barrier(100, 50, wide-100, 50);
  //allBarriers[5] = new Barrier(wide-50, 100, wide-50, high-100);
  //allBarriers[6] = new Barrier(wide-100, high-50, 100, high-50);
  //allBarriers[7] = new Barrier(50, high-100, 50, 100);
}

void displayBarriers() {
  for (Barrier b: allBarriers) {
      b.display();
  }
}

void displayScene() {
  float interval = wide / scene.length;
  for (int i = 0; i < scene.length; i ++) {
    noStroke();
    fill(0, 0, map(scene[i] * scene[i], 0, wide * wide, 255, 25), 150);
    rectMode(CENTER);
    push();
    translate(wide, high/2);
//    float highAdjust = high / (scene[i] / cos(radians((i + caster1.hdg)-(caster1.fov/2))));//cos(radians(map(dist(caster1.allRays[i].pos.x, caster1.allRays[i].pos.y, caster1.posit.x, caster1.posit.y), 0, width, 60, 10)));
//    rect(i * interval + interval / 2, 0, interval + 1, high / map(scene[i], 0, wide, high, 0));
    
    rect(i * interval + interval / 3, 0, interval + 2, distProj * (.3 * high) / scene[i]);
    
    pop();
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    caster1.hdg -= 5;
    if (caster1.hdg == 0) {
      caster1.hdg = 360;
    }
    println(caster1.hdg);
    caster1.rotateToHdg();
  }
  else if (keyCode == RIGHT) {
    caster1.hdg += 5;
    if (caster1.hdg == 360) {
      caster1.hdg = 0;
    }
    println(caster1.hdg);
    caster1.rotateToHdg();
  }
}
