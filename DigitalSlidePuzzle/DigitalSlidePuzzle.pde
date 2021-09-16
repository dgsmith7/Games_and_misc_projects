// Digital sliding puzzle - by David Gail Smith, September 2014

//  need to clean up comments, improve modularity, resequence functions logically, try 3d graphics, improve billboards?


digit d1, d2;  // Digit holders for painting tiles
digit moves1, moves2, moves3, moves4;  // Digit holders for move counter
digit best1, best2, best3, best4;  // Digit holders for best counter
button exitButton, newButton, aboutButton;  // Control buttons
billBoard copyrightInfo, puzzleSolvedInfo, newHighScoreInfo; // Messages

PFont f;

int [][] currentState = {
  {
    16, 16, 16, 16
  }
  , 
  {
    16, 16, 16, 16
  }
  , 
  {
    16, 16, 16, 16
  }
  , 
  {
    16, 16, 16, 16
  }
};

int moveCounter = 0;
int bestScore = 9999;
boolean aboutClicked = false;
boolean solutionFound = false;
color messageColor = color(25, 175, 250);

void setup () {
  f = createFont("Arial", 16, true);
  textFont(f, 16);
  size (460, 700);
  background (75);
  fill(65);
  stroke (25, 175, 250);
  d1 = new digit();
  d2 = new digit();
  moves1 = new digit();
  moves2 = new digit();
  moves3 = new digit(); 
  moves4 = new digit (); 
  best1 =  new digit();
  best2 = new digit();
  best3 = new digit();
  best4 = new digit();
  copyrightInfo = new billBoard ("2014 by David Gail Smith", messageColor, 110, 670);
  puzzleSolvedInfo = new billBoard ("Puzzle solved.  Great job!", messageColor, 150, 640);
  newHighScoreInfo = new billBoard ("New High Score!  Awesome!", messageColor, 140, 655);
  exitButton = new button();
  newButton = new button();
  aboutButton = new button();
  drawBlankBoard();
  mixPuzzle ();
  fillBoard ();
} // End setup

void draw () {  
  drawMoveCounter(moveCounter);
  drawBestScore(bestScore);
  drawButtons();
} // End draw

// Prints current puzzle state (used for debugging)
void printCurrent () {
  for (int a=0; a<4; a++) {
    for (int b = 0; b<4; b++) {
      print(currentState[a][b]+" ");
    }
    println ();
  }
} // End print current
/*
//  Used during development to escape the program during troubleshooting
void keyPressed () {
 save("sampleImage.png");
 } // end key pressed
 */

boolean checkSolved () {  // Check to see if the puzzle has been solved
  int counter=1;
  boolean foundError = false;
  for (int j=0; j<4; j++) {
    for (int k=0; k<4; k++) {
      if (currentState[j][k] != counter) {
        foundError=true;
      }
      counter++;
    }
  }
  return (!foundError);
}

void mouseClicked () {  // Take appropriate action whenever mouse is clicked
  // if its a click on a control, figure out which one
  if ((mouseY >= 460) && (mouseY <= 475)) {  // Clicked on a button
    if ((mouseX >75) && (mouseX <100)) { // Clicked on New button
      puzzleSolvedInfo.displayOff ();
      newHighScoreInfo.displayOff ();
      mixPuzzle ();
      drawBlankBoard();
      fillBoard ();
      moveCounter = 0;
    }
    if ((mouseX >190) && (mouseX <215)) { // Clicked on Exit button
      exit();
    }
    if ((mouseX >300) && (mouseX <325)) { // Clicked on About button
      aboutClicked = !aboutClicked;  
      if (aboutClicked == true) {
        copyrightInfo.display();
      } else {
        copyrightInfo.displayOff();
      }
    }
  } else if ((solutionFound == false) && (mouseY<460)) { // If solution found, no more move tile clicking available
    // if its a tile click and game not solved, get the array position  
    int rowHolder = 4;
    int colHolder = 4;
    for (int j=0; j<4; j++) {
      for (int k=0; k<4; k++) {
        if ((mouseX > 35+(k*100)) && (mouseX <125+(k*100))) {
          colHolder=k;
        }
        if ((mouseY > 35+(j*100)) && (mouseY <125+(j*100))) {
          rowHolder = j;
        }
      }
    }
    rearrangeBoard (colHolder, rowHolder); // alter the game board
    solutionFound = checkSolved ();
    if (solutionFound == true) { // Has it been solved?
      solutionFound = true;
      puzzleSolvedInfo.display (); // If yes display the message
      if (moveCounter < bestScore) { // Update the high score if achieved
        newHighScoreInfo.display ();
        bestScore = moveCounter;
      }
    }
  }
} // end mouseClicked

void rearrangeBoard(int col, int row) { // Update the game board after a legal click
  boolean validMove = false;
  // Figure out position of blank tile
  int blankCol = 0;
  int blankRow = 0;
  for (int j=0; j<4; j++) {
    for (int k=0; k<4; k++) {
      if (currentState[j][k] == 16) {
        blankCol = k;
        blankRow = j;
      }
    }
  }
  if ((blankCol == col)&&(blankRow == row)) {   // Click was on the blank tile
    validMove = false;
  } 

  //    topleft - blank can move down (+0+1) - can move right (+1+0)
  if (col ==0 && row ==0) {
    if ((blankCol == 0) && (blankRow == 1)) { // blank is beneath
      validMove = true;
    } 
    if ((blankCol== 1)&&(blankRow == 0)) { // blank is to right
      validMove= true;
    }
  }

  //   topcenter - blank can move down (+0+1) - can move left (-1+0) - can move right (+1+0)
  if ((col ==1 || col==2) && (row == 0)) {
    if ((blankCol == col) && (blankRow == 1)) { // blank is beneath 
      validMove = true;
    } 
    if ((blankCol== col+1)&&(blankRow == 0)) { // blank is to right
      validMove= true;
    }
    if ((blankCol== col-1)&&(blankRow == 0)) { // blank is to left
      validMove= true;
    }
  }

  //   topright - blank can move down (+0+1) - can move left (-1+0)
  if (col ==3 && row ==0) {
    if ((blankCol == 3) && (blankRow == 1)) { // blank is beneath
      validMove = true;
    } 
    if ((blankCol== 2)&&(blankRow == 0)) { // blank is to left
      validMove= true;
    }
  }

  //   leftcenter - blank can move up (+0-1) - can move down (+0+1) - can move right (+1+0)
  if ((col ==0) && (row ==1 || row==2)) {
    if ((blankCol == 1) && (blankRow == row)) { // blank is to right
      validMove = true;
    }
    if ((blankCol == 0) && (blankRow == row-1)) { // blank is above
      validMove = true;
    } 
    if ((blankCol == 0) && (blankRow == row+1)) { // blank is beneath
      validMove = true;
    }
  }

  //   center - blank can move up (+0-1) - can move down (+0+1) - can move left (-1+0) - can move right (+1+0)
  if ((col ==1 || col==2) && (row ==1 || row==2)) {
    if ((blankCol == col - 1) && (blankRow == row)) { // blank is to left
      validMove = true;
    }
    if ((blankCol == col + 1) && (blankRow == row)) { // blank is to right
      validMove = true;
    }
    if ((blankCol == col) && (blankRow == row-1)) { // blank is above
      validMove = true;
    } 
    if ((blankCol == col) && (blankRow == row+1)) { // blank is beneath
      validMove = true;
    }
  }

  //   rightcenter - blank can move up (+0-1) - can move down (+0+1) - can move left (-1+0)
  if ((col ==3) && (row ==1 || row==2)) {
    if ((blankCol == 2) && (blankRow == row)) { // blank is to left
      validMove = true;
    }
    if ((blankCol == 3) && (blankRow == row-1)) { // blank is above
      validMove = true;
    } 
    if ((blankCol == 3) && (blankRow == row+1)) { // blank is beneath
      validMove = true;
    }
  }

  //   bottomleft - blank can move up (+0-1) - can move right (+1+0)
  if (col ==0 && row ==3) {
    if ((blankCol == 0) && (blankRow == 2)) { // blank is above
      validMove = true;
    } 
    if ((blankCol == 1) && (blankRow == 3)) { // blank is to right
      validMove = true;
    }
  }

  //   bottomcenter - blank can move up (+0-1) - can move left (-1+0) - can move right (+1+0)
  if ((col ==1 || col==2) && (row ==3)) {
    if ((blankCol == col) && (blankRow == 2)) { // blank is above 
      validMove = true;
    } 
    if ((blankCol== col+1)&&(blankRow == 3)) { // blank is to right
      validMove= true;
    }
    if ((blankCol== col-1)&&(blankRow == 3)) { // blank is to left
      validMove= true;
    }
  }

  //   bottomright - blank can move up (+0-1) - can move left (-1+0)
  if (col ==3 && row ==3) {
    if ((blankCol == 3)&&(blankRow ==2)) { // blank is above
      validMove = true;
    } 
    if ((blankCol == 2)&&(blankRow == 3)) { // blank is to left
      validMove = true;
    }
  }

  if (validMove == true) {    
    currentState[blankRow][blankCol]=currentState[row][col]; 
    currentState[row][col]=16;
    moveCounter++;
  }
  drawBlankBoard ();
  fillBoard ();
} // end rearrangeBoard


void drawButtons() { // Display the control buttons
  newButton.x = 75;
  newButton.y = 460;
  newButton.display();
  fill (25, 175, 250);
  text ("N E W", 110, 475);
  fill (50);
  exitButton.x = 190;
  exitButton.y = 460;
  exitButton.display();
  fill (25, 175, 250);
  text ("E X I T", 225, 475);
  fill (50);
  aboutButton.x = 300;
  aboutButton.y = 460;
  aboutButton.display();
  fill (25, 175, 250);
  text ("A B O U T", 335, 475);
  fill (50);
} // End draw buttons

void drawBlankBoard() { // Draws a blank game board
  background (75);
  aboutClicked = false;
  fill(65);
  strokeWeight(5);
  stroke (25, 175, 250);
  rect(15, 15, 430, 430, 10);
  strokeWeight(1);
  rect(22, 22, 416, 416, 10);
  fill (50);
  for (int i=0; i<4; i++) {
    for (int j=0; j<4; j++) {
      rect((35+(i*100)), 35+(j*100), 90, 90, 10);
    }
  }
} // End draw blank board

void fillBoard () { // Draws the tiles to reflect the puzzle state
  int which = 0;
  for (int j=0; j<4; j++) {
    for (int k=0; k<4; k++) {
      drawNumber((currentState[j][k]), 35+(k*100), 35+(j*100));  
      which++;
      if ((currentState[j][k]) == 16 ) {
        strokeWeight(1);
        stroke (50);
        noFill();
        rect((35+(k*100)), 35+(j*100), 90, 90, 10);
        stroke (25, 175, 250);
        fill(50);
      }
    }
  }
} // End fill board

void mixPuzzle () {  //  Scramble the tiles randomly
  /*
   generate 16 unique random numbers between 1 
   and 16 inclusive then assign them to the current state
   of the puzzle
   */
  int rand=int(random(1, 17));
  boolean match = true;
  int [] holder = {
    16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16
  };
  solutionFound = false;
  for (int i=0; i<16; i++) {
    rand = int(random(1, 17));
    match = true;
    while (match == true) {
      match = false;
      for (int j=0; (j<i); j++) {
        if (holder[j] == rand) {
          match = true;
        }
      }
      if (match == true) {
        rand=int(random(1, 17));
      }
    }
    holder[i] = rand;
  }

  /*  for tetsing
   int [] tempHolder = {
   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 15
   };
   holder = tempHolder;
   */  //end for testing


  // Put the 16 unique random numbers into the current state
  int currentCounter=0;
  for (int k=0; k<4; k++) {
    for (int l=0; l<4; l++) {
      currentState[k][l] =  holder[currentCounter];
      currentCounter++;
    }
  }
}  //  End mix puzzle

void drawMoveCounter (int moves) { // Draws the move counter
  int firstDigit =0, secondDigit=0, thirdDigit=0, fourthDigit=0;
  if (moves>9999) {
    moves = 0;
  }
  if (moves>=1000) {
    firstDigit=moves/1000; 
    secondDigit=(moves%1000)/100; 
    thirdDigit=(moves%1000%100)/10; 
    fourthDigit=(moves%1000%100%10);
  } else {
    firstDigit=0;
  }
  if ((moves>=100)&&(moves<1000)) {
    secondDigit=moves/100; 
    thirdDigit=(moves%100)/10; 
    fourthDigit=moves%100%10;
  } 
  if ((moves>=10)&&(moves<100)) {
    thirdDigit=moves/10; 
    fourthDigit=moves%10;
  }
  if (moves<10) {
    thirdDigit=0; 
    fourthDigit=moves;
  }

  fill (50);
  stroke (25, 175, 250);
  rect (40, 500, 170, 90, 20);
  stroke (25, 175, 250);
  moves1.display(firstDigit, 40, 500);
  moves2.display(secondDigit, 80, 500);
  moves3.display(thirdDigit, 120, 500);
  moves4.display(fourthDigit, 160, 500);
  fill (25, 175, 250);
  text ("M O V E S", 105, 610);
  fill (50);
} // end drawMoveCounter

void drawBestScore (int moves) {  // Draws high score counter
  int firstDigit =0, secondDigit=0, thirdDigit=0, fourthDigit=0;
  if (moves>9999) {
    moves = 0;
  }
  if (moves>=1000) {
    firstDigit=moves/1000; 
    secondDigit=(moves%1000)/100; 
    thirdDigit=(moves%1000%100)/10; 
    fourthDigit=(moves%1000%100%10);
  } else {
    firstDigit=0;
  }
  if ((moves>=100)&&(moves<1000)) {
    secondDigit=moves/100; 
    thirdDigit=(moves%100)/10; 
    fourthDigit=moves%100%10;
  } 
  if ((moves>=10)&&(moves<100)) {
    thirdDigit=moves/10; 
    fourthDigit=moves%10;
  }
  if (moves<10) {
    thirdDigit=0; 
    fourthDigit=moves;
  }
  fill (50);
  stroke (25, 175, 250);
  rect (250, 500, 170, 90, 20);
  stroke (25, 175, 250);
  best1.display(firstDigit, 250, 500);
  best2.display(secondDigit, 290, 500);
  best3.display(thirdDigit, 330, 500);
  best3.display(fourthDigit, 370, 500);
  fill (25, 175, 250);
  text ("B E S T", 290, 610);
  fill (50);
} // end drawBestScore

void drawNumber(int which, float x, float y) {  // Draws numbers on tiles
  int first = firstDigit (which);
  int second = secondDigit (which);
  if (which < 16) {
    d1.display(first, x, y);
    d2.display(second, x+40, y);
  } else {
    d1.display(10, x, y);
    d2.display(10, x+40, y);
  }
} // end drawNumber

int firstDigit (int number) { // returns first digit for numbers 0-99
  if (number <10) {
    return 0;
  } else {
    return number/10;
  }
} // End first digit

int secondDigit (int number) {  // returns second digit for numbers 0-99
  if (number <10) {
    return number;
  } else {
    return number%10;
  }
} //  End second digit
