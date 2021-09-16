class Robot extends Mover {
  boolean smart;

  Robot(float x, float y) {
    this.live = true;
    this.x = x;
    this.y = y;
    this.c = color (#2FE02D);
    this.wide = 32;
    this.high = 32;
    this.top = this.y;
    this.right = this.x + this.wide;
    this.bottom = this.y + this.high ;
    this.left = this.x;
    this.sequence = 0;
    this.currentDirection = 0;
    this.speed = 3;
    if (int(random(2)) == 1) {
      this.smart = true;
    } else {
      this.smart = false;
    }
  }

  void display() {
    if (this.live == true) {
      fill(c);
      noStroke();
       switch(sequence) {
         case 1: 
         case 3: {
           rect(x+8, y, 16, 4); // head
           rect(x+4, y+4, 24, 8); // shoulders
           rect(x, y+8, 4, 12); // left arm
           rect(x+28, y+8, 4, 12); // right arm
           rect(x+8, y+12, 16, 8); // torso
           rect(x+8, y+20, 4, 8); // left leg
           rect(x+4, y+24, 8, 4); // left foot 
           rect(x+20, y+20, 4, 8); // right leg
           rect(x+20, y+28, 8, 4); // right foot
           break;
         }
         default: {
           rect(x+8, y, 16, 4); // head
           rect(x+4, y+4, 24, 8); // shoulders
           rect(x, y+8, 4, 12); // left arm
           rect(x+28, y+8, 4, 12); // right arm
           rect(x+8, y+12, 16, 8); // torso
           rect(x+8, y+20, 4, 8); // left leg
           rect(x+4, y+28, 8, 4); // left foot 
           rect(x+20, y+20, 4, 8); // right leg
           rect(x+20, y+24, 8, 4); // right foot
           break;
         }
       }
    } 
  }

  void determineNextMove() {
    // smart
    if (abs(player1.x - x) >= 25)  {
      if (player1.x < x) {
        currentDirection = 3;
      } else {
        currentDirection = 1;
      }
    } else    
    {
      if (player1.y < y) {
        currentDirection = 0;
      } else {
        currentDirection = 2;
      }
    }
  }

  boolean shouldShoot() {
    if ((abs(player1.x - x) < 25) || (abs(player1.y - y) < 25)) {
      return true;
    } else {
      return false;
    }
  }
}