// This class defines the control buttons
class button { 
  float x, y;
  color buttonColor;

  button () {
    buttonColor = color(25, 175, 250);
    x = 0;
    y = 0;
  }

  void display () {
    stroke(0);
    fill(buttonColor);
    rect(x, y, 25, 15, 20);
    stroke(255);
    line(x+16, y+3, x+17, y+3);
    line(x+19, y+3, x+20, y+3);
    line(x+20, y+4, x+21, y+4);
    line(x+22, y+4, x+22, y+5);
    line(x+22, y+7, x+22, y+8);
    noStroke ();
  }
}

