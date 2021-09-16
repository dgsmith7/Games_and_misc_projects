class Wall {
  PVector e1, e2;
  
  Wall() {
    this.e1 = new PVector(random(wide), random(high));
    this.e2 = new PVector(random(wide), random(high));
  }
  
  Wall(float x1, float y1, float x2, float y2) {
    this.e1 = new PVector(x1, y1);
    this.e2 = new PVector(x2, y2);
  }
  
  void display() {
    stroke(255);
    line(e1.x, e1.y, e2.x, e2.y);
  }
}
