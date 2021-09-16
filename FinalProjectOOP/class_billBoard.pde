// This class defines an object, ball
class billBoard { 
  // This part is for object's attributes
  String message;
  float signX, signY;
  color signColor;

  billBoard (String messageText, color newColor, int x, int y) {
    // This part is the contructor
    message = messageText;
    signColor = newColor;
    signX = x;
    signY = y;
  }

  // The following function is a message or method because 
  // it is defined within a class

  void display () {
    // This part defines the behaviors
    fill(signColor);
    text (message, signX, signY); 
    fill(75);
  }

  void displayOff () {
      fill(75); 
      rect(90, 620, 300, 60);
  }
}

