class Human extends Walker {
// fields
boolean theOne = false;

// default constructor
Human () {
}

// overloaded constructors
Human (float x, float y, int direction) {
this.x = x;
this.y = y;
this.direction = direction;
this.health = 10;
this.dead = true;
this.intelligence = int(random(0,3));
this.slowFactor = random(0.7,0.9);
}

void display () {
  if (fighting == true) {
  if ((direction == 1) || (direction == 2)) {picIndex = 2;}
  if ((direction == 3) || (direction == 4)) {picIndex = 3;}
} else {
  if ((direction == 1) || (direction == 2)) {picIndex = 1;}
  if ((direction == 3) || (direction == 4)) {picIndex = 0;}
}
if (theOne == true) {picIndex += 8;}
p = walkAndFight[picIndex];
image(p, x, y);
} 

}
