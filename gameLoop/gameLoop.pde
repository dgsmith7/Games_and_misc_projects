//This a skeleton for a game loop
/// added button class for buttons
// button array is globally declared and 
// then initialized in setup.  Buttons all 
// set to inactive in draw loop, then activated only 
// if displayed.  Mouseclick checks to see if 
// mouse is over a button and button active, then
// resetes state (basically just like key pressed).


int gameState = 0; // 0 = splashscreen, 1 = play, 2 = pause, 3 = settings, 4 = highscore screen    
int nButtons = 8;    /// added this for buttons
Button[] buttons = new Button[nButtons];    /// added this for buttons

void setup() {
  size(500, 500);
  textSize(20);
  initButtons();    /// added this for buttons
}

void draw() {
  background(100);
  resetButtons();    /// added this for buttons
  switch(gameState) {
    case 0: splashScreen();
          break;
    case 1: playGame();          
          break;
    case 2: pauseGame();
          break;
    case 3: changeSettings();
          break;
    default: aboutScreen();
  }
}

void splashScreen() {
  text("Splash screen", 50, 50);
  text("P-Play  S-Settings  A-About  E-Exit", 50, 100);
  ///  Added this for buttons
  buttons[0].setXY(50, 350);
  buttons[0].display();
  buttons[1].setXY(150, 350);
  buttons[1].display();
  buttons[2].setXY(250, 350);
  buttons[2].display();
  buttons[6].setXY(350, 350);
  buttons[6].display();
}

void playGame() {
  text("Play mode - game happening now", 50, 50);
  text("P-Pause  Q-quit  E-exit", 50, 100);
  /// Added this stuff for buttons
  buttons[7].setXY(50, 350);
  buttons[7].display();
  buttons[3].setXY(150, 350);
  buttons[3].display();
  buttons[6].setXY(250, 350);
  buttons[6].display();
}

void pauseGame() {
  text("Game paused", 50, 50);
  text("R-Resume  E-Exit", 50, 100);
  ///  Added this for buttons
  buttons[4].setXY(50, 350);
  buttons[4].display();
  buttons[6].setXY(150, 350);
  buttons[6].display();
}

void changeSettings() {
  text("Tweak settings on this page", 50, 50);
  text("H-Home  E-Exit", 50, 100);
  ///  Added this for buttons
  buttons[5].setXY(50, 350);
  buttons[5].display();
  buttons[6].setXY(150, 350);
  buttons[6].display();
}

void aboutScreen() {
  text("About page - By Best Student Ever, 2018", 50, 50);
  text("H-Home  S-Settings  E-Exit", 50, 100);
  ///  Added this for buttons
  buttons[5].setXY(50, 350);
  buttons[5].display();
  buttons[1].setXY(150, 350);
  buttons[1].display();
  buttons[6].setXY(250, 350);
  buttons[6].display();
}

void keyPressed() {
    switch(gameState) {
    case 0: //splashScreen;
          switch(key) {
            case 'p': gameState = 1; break;
            case 's': gameState = 3; break;
            case 'a': gameState = 4; break;
            case 'e': exit();
          }
          break;
    case 1: //playGame
          switch(key) {
            case 'p': gameState = 2; break;
            case 'q': gameState = 0; break;
            case 'e': exit();
          }
          break;
    case 2: //pauseGame
          switch(key) {
            case 'r': gameState = 1; break;
            case 'e': exit();
          }
          break;
    case 3: //changeSettings
          switch(key) {
            case 'h': gameState = 0; break;
            case 'e': exit();
          }
          break;
    default: //about
          switch(key) {
            case 'h': gameState = 0; break;
            case 's': gameState = 3; break;
            case 'e': exit();
          }
    }
}

/********************************************
** Everything below added for the buttons  **
*********************************************/

void mouseClicked() {  // same as keypressed but added function 
                       // call to get index, and changed "key" to 
                       // index number for switching
  int whichButton = buttonIndex();
    switch(gameState) {
    case 0: //splashScreen;
          switch(whichButton) {
            case 0: gameState = 1; break;
            case 1: gameState = 3; break;
            case 2: gameState = 4; break;
            case 6: exit();
          }
          break;
    case 1: //playGame
          switch(whichButton) {
            case 7: gameState = 2; break;
            case 3: gameState = 0; break;
            case 6: exit();
          }
          break;
    case 2: //pauseGame
          switch(whichButton) {
            case 4: gameState = 1; break;
            case 6: exit();
          }
          break;
    case 3: //changeSettings
          switch(whichButton) {
            case 5: gameState = 0; break;
            case 6: exit();
          }
          break;
    default: //about
          switch(whichButton) {
            case 5: gameState = 0; break;
            case 1: gameState = 3; break;
            case 6: exit();
          }
    }
}

void initButtons() { // constrcutor calls for buttons
  buttons[0] = new Button(85, 40, color(0, 0, 255), "Play");
  buttons[1] = new Button(85, 40, color(0, 0, 255), "Settings");
  buttons[2] = new Button(85, 40, color(0, 0, 255), "About");
  buttons[3] = new Button(85, 40, color(0, 0, 255), "Quit");
  buttons[4] = new Button(85, 40, color(0, 0, 255), "Resume");
  buttons[5] = new Button(85, 40, color(0, 0, 255), "Home");
  buttons[6] = new Button(85, 40, color(0, 0, 255), "Exit");
  buttons[7] = new Button(85, 40, color(0, 0, 255), "Pause");
}

int buttonIndex() { // called from mouseClicked - figures out which 
                    // buttons are active and have mouse over
  int which = 0;
  for (int i = 0; i < nButtons; i ++) {
    if (buttons[i].hasMouseOver() && buttons[i].active) {
      which = i;
      break;
    }
  }
  return which;
}

void resetButtons() {  // resets all buttons to inactive for state changes
  for (int i = 0; i < nButtons; i ++) {
    buttons[i].active = false;
  }
}
