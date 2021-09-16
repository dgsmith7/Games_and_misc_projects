class Zombie extends Walker {
// fields
 
// default constructor 
Zombie () {
}

// overloaded constructors
Zombie (float x, float y, int direction) {
this.x = x;
this.y = y;
this.direction = direction;
this.health=10;
this.dead = true;
this.intelligence = int(random(0,3));
this.slowFactor =  random(0.6,0.8);
}

void display () {
  if (fighting == true) {
  if ((direction == 1) || (direction == 2)) {picIndex = 6;}
  if ((direction == 3) || (direction == 4)) {picIndex = 7;}
} else {
  if ((direction == 1) || (direction == 2)) {picIndex = 5;}
  if ((direction == 3) || (direction == 4)) {picIndex = 4;}
}
p = walkAndFight[picIndex];
image(p, x, y);
} 

}
