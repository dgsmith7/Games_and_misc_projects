class Barrier {
  PVector end1, end2;
  
  Barrier (float x1, float y1, float x2, float y2) {
    end1 = new PVector(x1, y1);
    end2 = new PVector(x2, y2);
  }
  
  void display() {
    stroke(255);
    strokeWeight(5);
    line(end1.x, end1.y, end2.x, end2.y);
  }
  
}
