class Player extends Mover {

  Player() {
    super();
  }

  Player(float x, float y) {
    this.live = true;
    this.x = x;
    this.y = y;
    this.c = color (#2FE02D);
    this.wide = 24;
    this.high = 40;
    this.top = this.y;
    this.right = this.x + this.wide;
    this.bottom = this.y + this.high ;
    this.left = this.x;
    this.sequence = 0;
    this.currentDirection = 0;
    this.speed = 3;
  }

  void display() {
    if (this.live == true) {
      fill(c);
      noStroke();
       switch(sequence) {
         case 1: 
         case 3: {
           rect(x+8, y, 8, 8); // head
           rect(x+8, y+12, 8, 4); // shoulders
           rect(x+4, y+16, 4, 4); // left arm
           rect(x, y+20, 4, 4); // left hand
           rect(x+16, y+16, 4, 4); // right arm
           rect(x+20, y+20, 4, 4); // right hand
           rect(x+10, y+16, 4, 8); // torso
           rect(x+8, y+24, 8, 4); // hips
           rect(x, y+28, 12, 4); // left leg
           rect(x, y+32, 4, 4); // left foot 
           rect(x+16, y+28, 4, 12); // right leg
           rect(x+16, y+36, 8, 4); // right foot
           break;
         }
         default: {
           rect(x+8, y, 8, 8); // head
           rect(x+8, y+12, 8, 4); // shoulders
           rect(x, y+16, 4, 8); // left arm
           rect(x+20, y+16, 4, 8); // right arm
           rect(x+8, y+16, 8, 16); // torso / legs
           rect(x+8, y+32, 12, 4); // right foot
           rect(x+8, y+36, 4, 4); // left foot           
           break;
         }
       }
    } 
  }
}