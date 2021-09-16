/*Using Processing, create a new sketch that utilizes arrays. Randomize the starting location or speed or size as applicable.
 
 The number of objects should be adjustable by changing one variable. (Comment it out!)
 
 The animation can be based in reality (such as a ball falling down a staircase) or be more abstract. However, the sketch should have a specific theme.
 
 If you want to do the gravity effect, it should be a perfect graviry effect (Follow the reality, like finally it will stop).
 
 You have to use functions to manage your code. (20 points)
 
 Creativity is always recommended!
 
 slide controls:
 number of rounds
 rate of fire
 powder load
 ammo color mix
 paint quantity (litrers .5 - 10)
 
 buttons:
 print button
 see canvas button
 fire salvo button
 cease fire button
 new canvas
 
 methods:
 explosion/impact
 view canvas
 fire weapon
 print canvas
 */
 
 
int particleCount;
float depth;
float[] x;
float[] y;
float[] z;
float[] spdX;
float[] spdY;
float[] spdZ;
float[] radius;
color[] col;
float[] gravity;
float[] damping;
float[] friction;
int j = 0;

void setup() {
  size(1200, 700, P3D);
  depth = 1000;
  particleCount = 75;
  x = new float[particleCount];
  y = new float[particleCount];
  z = new float[particleCount];
  spdX = new float[particleCount];
  spdY = new float[particleCount];
  spdZ = new float[particleCount];
  radius = new float[particleCount];
  col = new color[particleCount];
  gravity = new float[particleCount];
  damping = new float[particleCount];
  friction = new float[particleCount];

  for (int i=0; i<particleCount; i++) {
    x[i] = width/2;
    y[i] = height/2; //20;
    z[i] = 0;
    spdX[i] = random(-10, 10);
    spdY[i] = random(-30, 1);
    spdZ[i] = random(-10, 10);
    radius[i] = 5; // random(2.0, 20.0);
    col[i] = color(random(75), random(85)+170, random(85)+170, 150); //color (250, 100, 100); //color (#32FAFA, 100); 
    gravity[i] = .25; //random(0.5, 1.0);
    damping[i] = .5; //higher num equals less damping  random(0.5, 0.75);
    friction[i] = .5; // higher num equals less friction  random(0.5, 0.75);
  }
}

void buildWalls() {
  stroke (175);
//  fill (100,200,230, 150);
noFill ();
  translate (width/2, height/2, -depth/2);
  box (width, height, depth);
  translate (-width/2, -height/2, depth/2);
  noStroke ();
}

void makeImpactEffect (int pointer) {

}

void draw() {
  background(100, 200, 230);
  noStroke();
  sphereDetail(30);
  ambient(250, 100, 100);
  ambientLight (40, 20, 40);
  lightSpecular(255, 215, 215);
  directionalLight(185, 195, 255, -1, 1.25, -1);
  shininess(255);

  buildWalls ();
  for (int i=0; i<particleCount; i++) {
    //stroke(col[i]);
    fill(col[i]);
    //ellipse(x[i], y[i], radius[i]*2, radius[i]*2);
    pushMatrix ();
    translate (x[i], y[i], z[i]);
    sphere(radius[i]*2);
    popMatrix ();
    x[i] += spdX[i];
    spdY[i] += gravity[i];
    y[i] += spdY[i];
    z[i] += spdZ[i];
    j++;
    if (x[i] > width-radius[i]) { // hits right wall
      makeImpactEffect (i);
      x[i] = width-radius[i];
      spdX[i] *= -1;
    }

    if (x[i] < radius[i]) { // hits left wall
      makeImpactEffect (i);
      x[i] = radius[i];
      spdX[i] *= -1;
    }

    if (y[i] > height-radius[i]) {  // contacts surface
      y[i] = height-radius[i];
      spdY[i] *= -1;
      spdY[i] *= damping[i];
      spdX[i] *= friction[i];
      spdZ[i] *= damping[i];
    }

    if (y[i] < radius[i]) { // hits ceiling
      makeImpactEffect (i);
      y[i] = radius[i];
      spdY[i] *= -1;
    }
    if (z[i] > (radius[i])) {  // contacted glass in between viewer and target
      makeImpactEffect (i);
      z[i] = radius[i];
      spdZ[i] *= -1;
    }
    if (z[i] < (-depth-radius[i])) {  // contacted far target wall
      makeImpactEffect (i);
      z[i] = (-depth-radius[i]);
      spdZ[i] *= -1;
    }
  }
}

