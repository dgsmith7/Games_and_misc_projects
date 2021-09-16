class Projectile extends Mover {

  Projectile() {
  }

  Projectile(float x, float y) {
    this.x = x;
    this.y = y;
    this.c = color (#2FE02D);
    this.wide = 11;
    this.high = 2;
    this.top = this.y;
    this.right = this.x + this.wide;
    this.bottom = this.y + this.high ;
    this.left = this.x;
    this.sequence = 0;
    this.currentDirection = 0;
    this.speed = 3;
  }

  void orient() { // points bullet in correct direction for display
    switch(currentDirection) {
    case 0:
    case 2: 
      {
        if (wide > high) {
          float temp = wide;
          wide = high;
          high = temp;
        }
        break;
      }
    case 1:
    case 3: 
      {
        if (high > wide) {
          float temp = wide;
          wide = high;
          high = temp;
        }
        break;
      }
    }
  }

  void fire(Mover m) {
    this.live = true;
    this.currentDirection = m.currentDirection;
    this.sequence = m.currentDirection;
    this.orient();
    switch(m.currentDirection) {
    case 0: 
      {
        this.x = m.x + m.wide/2; 
        this.y = m.y - this.high -1; 
        break;
      }
    case 1: 
      {
        this.x = m.x + m.wide + 1; 
        this.y = m.y + m.high/2; 
        break;
      }
    case 2: 
      {
        this.x = m.x + m.wide/2; 
        this.y = m.y + m.high + 1; 
        break;
      }
    case 3: 
      {
        this.x = m.x - this.wide - 1; 
        this.y = m.y + m.high/2; 
        break;
      }
    }
  }

  void display() {
    if (this.live == true) {
          strokeWeight(2);
          stroke(c);
          rect(left, top, wide, high);
    }
  }

  void updatePosition() {
    super.updatePosition(currentDirection);
    if ((x < 0) || (x > width) || (y < 0) || (y > height)) {
      x = -25;
      y = bulletIndex * 10;
      live = false;
      top = y;
      right = x + wide;
      bottom = y + high ;
      left = x;
    }
  }
  
  boolean isTouching(Mover m){
    boolean touchTest = false;
    if ((this.left > m.left) &&
        (this.right < m.right) &&
        (this.top > m.top) &&
        (this.bottom < m.bottom)) {
      touchTest = true;
    }
    return touchTest;
  }
}