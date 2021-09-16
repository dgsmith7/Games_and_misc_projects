class Pickup {
  int x;
  int y;
  boolean live = true;
  
Pickup (int x, int y) {
this.x = x;
this.y = y;
}

  void display() {
  stroke(255,0,0);
  fill(255, 0 ,0);
  rect(x, y+5, 15,5);
  rect(x+5, y, 5, 15);
  }
  
}
