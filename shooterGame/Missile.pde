class Missile {
  float x; 
  float y;
  color c;
  boolean live;
  
  Missile(float _x) {
     x = _x;
     y = 425;
     c = color(255);
     live = true;
  }
  
  void display() {
    if (live == true) {
      fill(c);
      ellipse(x, y, 20, 20);
    }
  }
  
  void move() {
    y = y - 3;
  }
  
  void checkOnScreen() {
    if (y < 0) {
      live = false;
    }
  }
}
