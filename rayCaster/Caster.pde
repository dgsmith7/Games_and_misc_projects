class Caster {
  PVector position;
  int hdg;
  float size;
  float view[];
  float range;

  Caster() {
    this.position = new PVector(mouseX, mouseY);
    this.hdg = 0;
    this.size = 10;
    this.view = new float[360];
    this.range = sqrt(wide * wide + high * high);
  }

  void updatePosition() {
//    if ((mouseX < wide - (this.size / 2)) && (mouseX > 0 + (this.size / 2))) {
//      this.position.x = mouseX;
//    }
//    if ((mouseY < high - (this.size / 2)) && (mouseY > 0 + (this.size / 2))) {
//      this.position.y = mouseY;
//    }
  }

  void display() {
    stroke(255);
    noFill();
    ellipse(this.position.x, this.position.y, this.size, this.size);
  stroke(0, 0, 255);
  line(c1.position.x, c1.position.y, c1.position.x + cos(radians(r1l)) * 150, c1.position.y + sin(radians(r1l)) * 150);
  line(c1.position.x, c1.position.y, c1.position.x + cos(radians(r2h)) * 150, c1.position.y + sin(radians(r2h)) * 150);
  }

  float[] scan() {
    float[] view = new float[360];
    for (int i = 0; i < 360; i ++) {
      PVector ray = new PVector(0, 0);
      ray.add(this.position);
      PVector dir = new PVector(cos(radians(i)) * this.range, sin(radians(i)) * this.range);
      ray.add(dir);
      float record = range+1;
      for (Wall w : allWalls) {
        PVector pt = determineEnd(w, ray);
        if (pt != null) {
          float d = cos(radians(abs(hdg-i))) * PVector.dist(this.position, pt);
          if (d < record) {
            record = d;
          }
        }
      }
      view[i] = record;
    } 
    return view;
  }

  PVector determineEnd(Wall wall, PVector r) {
    float x1 = wall.e1.x;
    float y1 = wall.e1.y;
    float x2 = wall.e2.x;
    float y2 = wall.e2.y;
    float x3 = this.position.x;
    float y3 = this.position.y;
    float x4 = r.x;
    float y4 = r.y;
    float denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (denom == 0) {
      return null;
    } 
    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom;
    float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denom;
    if (t > 0 && t < 1 && u > 0) {
      PVector end = new PVector();
      end.x = x1 + t * (x2 - x1);
      end.y = y1 + t * (y2 - y1);
      return end;
    } else {
      return null;
    }
  }
}
