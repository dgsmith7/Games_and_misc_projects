class Ship {
  float x;
  float y;
  color c;
  
  Ship() {
    x = width/2;
    y = 450;
    c = color(0, 0, 255);
  }
  
  void display() {
    fill(c);
    ellipse(x, y, 40, 40);
  }
  
  void move() {
    x = mouseX;
  }
}
