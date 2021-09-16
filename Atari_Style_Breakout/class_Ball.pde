class Ball {

color ballColor = color (255, 0, 0);
int size = 14;
float xPosit = width/2;
float yPosit = 494;
float rise=-1;
float run=-1;

Ball () {}

void display () {
  fill(ballColor);
  ellipse(xPosit, yPosit, size, size); 
}

}
