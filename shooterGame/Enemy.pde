class Enemy {
  float x;
  float y;
  float xSpd;
  color c;
  
  Enemy() {
    x = 0;
    y = random(50, 250);
    xSpd = 5;
    c = color(255, 0 , 0);
  }
  
  void display() {
    fill(c);
    ellipse(x, y, 50, 50);
  }
  
  void move() {
    x = x + xSpd;
  }
}
