class Brick {

  int xPosit;
  int yPosit;
  int wide = 40;
  int tall = 20;
  color brickColor = color(255, 255, 0);
  boolean intact = true;
  int scoreValue = 0;
  int top;
  int bottom;
  int left;
  int right;

  Brick () {
  }

  void display () {
     if (intact == true) {
      fill(brickColor);
    } else {
      fill(0);
    }
    rectMode(CORNER);
    rect(xPosit, yPosit, wide, tall);
  }
}

