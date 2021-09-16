class Walker {
  
  int health; // 10 maximum
  float x, y;  // location;
  int direction; // 1-up, 2-right, 3-down, 4-left
  int intelligence; // 0-dumb-ass  1-normal  2-genius
  color bloodColor;
  int picIndex;
  boolean dead = true;
  boolean fighting = false;
  float slowFactor;
  
Walker () {
}
 
void fight () {
fighting = true;
}

void die () {
}

void spawn () {
}

 
}
