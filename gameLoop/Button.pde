class Button {   /// calss for button objects
  float x, y, wide, high;
  color c;
  String m;
  boolean active;
  
  Button(float wide, float high, color c, String m) {
    this.x = 0;    
    this.y = 0;    
    this.wide = wide;    
    this.high = high;    
    this.c = c;    
    this.m = m; 
    this.active = false;
  }

  void setXY(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    this.active = true;  // button only active if being displayed
    noStroke();
    fill(c);
    rect(x, y, wide, high);
    fill(0);
    text(m, x + 20, y + 20);  // text alignment
  }
  
  boolean hasMouseOver() {  // returns true if mouse is over button
    if ((mouseX >=x && mouseX <= x + wide) && (mouseY >= y && mouseY <= y + high)) {
      return true;
    } else {
      return false;
    }
  }
}
