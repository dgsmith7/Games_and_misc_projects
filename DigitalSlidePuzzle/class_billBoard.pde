// This class defines the messages that are displayed
class billBoard { 
  String message;
  float signX, signY;
  color signColor;

  billBoard (String messageText, color newColor, int x, int y) {
    message = messageText;
    signColor = newColor;
    signX = x;
    signY = y;
  }

  void display () {
    fill(signColor);
    text (message, signX, signY); 
    fill(75);
  }

  void displayOff () {
      fill(75); 
      rect(90, 620, 300, 60);
  }
}

