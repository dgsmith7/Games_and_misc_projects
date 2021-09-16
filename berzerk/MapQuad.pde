class MapQuad {
  float x, y;
  boolean top, right, bottom, left;
  float w, h;
  int thickness;
  color c;

  MapQuad() {
    this.x = 50;
    this.y = 50;
    this.top = true;
    this.right = true;
    this.bottom = true;
    this.left = true;
    this.w = 50;
    this.h = 50;
    this.thickness = 10;
    this.c = color(#2FE02D);
  }

  MapQuad(float x, float y, float w, float h, int which) {
    String s;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    s = binary(which, 4);
    this.top = (s.charAt(0) == '1'); 
    this.right = (s.charAt(1) == '1'); 
    this.bottom = (s.charAt(2) == '1');
    this.left = (s.charAt(3) == '1');
    this.thickness = 5;
    this.c = color(#2FE02D);
  }

  void display() {
    stroke(c);
    strokeCap(SQUARE);
    strokeWeight(thickness * 2 + 1);
    if (this.top == true) {
      line(x, y, x + w, y);
    }
    if (this.right == true) {
      line(x + w, y, x + w, y + h);
    }
    if (this.bottom == true) {
      line(x + w, y + h, x, y + h);
    }
    if (this.left == true) {
      line(x, y + h, x, y);
    }
    strokeWeight(0);
  }

  boolean isTouching(Mover m) { // detects collission with walls for any given Mover (passed object)
    boolean touchTest = false;
    if (m.live == true) {
      if ((m.right >= x)&&(m.left <= x+w)&&
        (m.bottom>=y)&&(m.top<=y+h)) {// in box
        //      text("In the box", x+50, y + 100);
        if (this.top == true) {      
          if (m.top <= y + thickness) {
            //          text("Touching top", x+50, y+50); 
            touchTest = true;
          }
        } 
        if (this.right == true) {
          if (m.right >= x + w - thickness) {
            //          text("Touching right", x+50, y+50); 
            touchTest = true;
          }
        } 
        if (this.bottom == true) {
          if (m.bottom >= y + h - thickness) {
            //          text("Touching bottom", x+50, y+50); 
            touchTest = true;
          }
        } 
        if (this.left == true) {
          if (m.left <= x + thickness) {
            //          text("Touching left", x+50, y+50); 
            touchTest = true;
          }
        }
      }
    }
    return touchTest;
  }
}