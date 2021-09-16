class Mover {
  float x, y, wide, high, top, right, bottom, left, speed;
  color c;
  int sequence;
  int currentDirection;
  boolean live;

  Mover() {
  }  

  Mover(float x, float y) {
    this.live = false;
    this.x = x;
    this.y = y;
    this.c = color (255, 0, 0);
    this.wide = 32;
    this.high = 32;
    this.top = this.y;
    this.right = this.x + this.wide;
    this.bottom = this.y + this.high ;
    this.left = this.x;
    this.sequence = 0;
    this.currentDirection = 0;
    this.speed = 3;
  }

  void display() {
    noStroke();
    fill(c);
    rect(x, y, wide, high);
  }

  void updatePosition(int dir) {//0 up 1 right 2 down 3 left
    if (this.live == true) {
      switch(dir) {
      case 0: 
        {
          y = y - speed;
          break;
        }
      case 1: 
        {
          x = x + speed;
          break;
        }  
      case 2: 
        {
          y = y + speed;
          break;
        }
      case 3: 
        {
          x = x - speed;
          break;
        }
      }
      sequence ++;
      if (sequence == 4) {
        sequence = 0;
      }
      currentDirection = dir;
      top = y;
      right = x + wide;
      bottom = y + high;
      left = x;
    }
  }

  boolean isTouching(Mover m) {
    boolean touchTest = false;
    if (((top <= m.bottom) && (top >= m.top)) || ((bottom >= m.top) && (bottom <= m.bottom))) { // y incurssion
      if (((m.left <= right) && (m.left >= left)) || ((m.right >= left) && (m.right <= right))) {
        touchTest = true;
      }
    }
    return touchTest;
  }

  void dies() {
    live = false;    
    x = -50;
    y = -50;
    top = y;
    right = x + wide;
    bottom = y + high ;
    left =x;
  }
}