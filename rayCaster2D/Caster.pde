class Caster {
  PVector posit;
  Ray[] allRays;
  int fov = 75;
  float hdg = 90;

  Caster() {
    this.posit = new PVector(width/2, height/2);
    this.allRays = new Ray[fov];
    for (int i = 0; i < fov; i ++) {
      allRays[i] = new Ray(this.posit, radians(i));
    }
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    point(posit.x, posit.y);
    for (int i = 0; i < fov; i ++) {
      allRays[i].display();
    }
  }

  void rotateToHdg() {
    for (int i = 0; i < this.allRays.length; i++) {
      allRays[i].dir = PVector.fromAngle(radians(i + this.hdg));
          }
  }
  
  void updatePosit(float x, float y) {
    this.posit.set(x, y);
  }

  float[] look(Barrier[] walls) {
    float[] sceneView = new float[this.allRays.length];
    for (int i = 0; i < this.allRays.length; i++) {
      Ray ray = this.allRays[i];
      PVector closest = null;
      float record = width * 2;
      for (Barrier w: walls) {
        PVector pt = ray.cast(w);
        if (pt != null) {
//          float d = PVector.dist(this.posit, pt);// * sin(radians((hdg-(fov/2) + i)));
          float d = cos(radians(i + hdg)) * PVector.dist(this.posit, pt);// * sin(radians((hdg-(fov/2) + i)));
          if (d < record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (closest != null) {
        stroke(255, 150);
        line(this.posit.x, this.posit.y, closest.x, closest.y);
      }
    sceneView[i] = record;
    }
    return sceneView;
  }
  
}
