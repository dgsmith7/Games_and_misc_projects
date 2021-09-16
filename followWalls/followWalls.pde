int[][] walls = {{1,1,1,1,3,1,1,1,1,1},
                 {2,0,0,1,0,0,0,0,0,1},
                 {1,0,0,1,0,0,0,0,0,1},
                 {1,0,0,0,0,0,1,0,0,1},
                 {1,0,0,0,0,0,1,0,0,1},
                 {1,1,1,0,0,0,1,0,0,1},
                 {1,0,0,0,0,1,1,1,1,1},
                 {1,0,0,0,0,0,0,0,0,1},
                 {1,0,0,0,0,0,0,0,0,1},
                 {1,1,1,1,1,1,1,1,1,1}};

//char followDirection = 'r';
char followDirection = 'l';

int currentRow = 1;
int currentCol = 0;
int currentDir = 1; //0 up  1 rt  2 dwn  3 lt

void setup() {
  size(500, 500);
  textSize(32);
}

void draw() {
  background(125);
  drawWalls();
  showMessage();
  displayMover();
  if (finished() == true) {
    println("Congrats.");
    noLoop();
  }
}

void drawWalls() {
  for (int i = 0; i < 10; i ++) {
    for (int j = 0; j < 10; j++) {
      if (walls[i][j] == 1) {
        fill(0, 0, 255);
      } else {
        fill(125);        
      }
      rect(j*50, i*50, 50,50);
    }
  }
}

void showMessage() {
  textSize(15);
  fill(255);
  text("m - move     r - follow wall right    l - follow wall left", 10, 25);
  text("Following wall" + getDirString(), 10, 475);
}

String getDirString() {
  if (followDirection == 'r') {
    return " right.";
  } else {
    return " left.";
  }
}

void displayMover() {
  fill(255, 0, 0);
  rect(currentCol * 50, currentRow * 50, 50, 50);
  fill(0);
  pushMatrix();
  translate(currentCol * 50 + 25, currentRow * 50 + 25);
  rotate(HALF_PI * currentDir);
  triangle(0, 0, 10, 10, -10, 10);
  popMatrix();
}

void followWallRight() {
  boolean rightClear = false;
  boolean frontClear = false;
  int checkRightDir = currentDir + 1;
  if (checkRightDir == 4) checkRightDir = 0;
  switch (checkRightDir) {
    case 0: rightClear = (walls[currentRow-1][currentCol] != 1); break;
    case 1: rightClear = (walls[currentRow][currentCol+1] != 1); break;
    case 2: rightClear = (walls[currentRow+1][currentCol] != 1); break;
    case 3: rightClear = (walls[currentRow][currentCol-1] != 1); break;
  }
  switch (currentDir) {
    case 0: frontClear = (walls[currentRow-1][currentCol] != 1); break;
    case 1: frontClear = (walls[currentRow][currentCol+1] != 1); break;
    case 2: frontClear = (walls[currentRow+1][currentCol] != 1); break;
    case 3: frontClear = (walls[currentRow][currentCol-1] != 1); break;
  }
  if (rightClear == false && frontClear == true) {
    switch(currentDir) {
      case 0: currentRow--; break;
      case 1: currentCol++; break;
      case 2: currentRow++; break;
      case 3: currentCol--; break;
    }
  }
  else if (rightClear == false && frontClear == false) {
    currentDir--; 
    if (currentDir == -1) currentDir = 3;
    switch(currentDir) {
      case 0: currentRow--; break;
      case 1: currentCol++; break;
      case 2: currentRow++; break;
      case 3: currentCol--; break;
    }
  }
  else if (rightClear == true) {
    currentDir++;
    if (currentDir == 4) currentDir = 0;
    switch(currentDir) {
      case 0: currentRow--; break;
      case 1: currentCol++; break;
      case 2: currentRow++; break;
      case 3: currentCol--; break;
    }
  }
}

void followWallLeft() {
  boolean leftClear = false;
  boolean frontClear = false;
  int checkLeftDir = currentDir - 1;
  if (checkLeftDir == -1) checkLeftDir = 3;
  switch (checkLeftDir) {
    case 0: leftClear = (walls[currentRow-1][currentCol] != 1); break;
    case 1: leftClear = (walls[currentRow][currentCol+1] != 1); break;
    case 2: leftClear = (walls[currentRow+1][currentCol] != 1); break;
    case 3: leftClear = (walls[currentRow][currentCol-1] != 1); break;
  }
  switch (currentDir) {
    case 0: frontClear = (walls[currentRow-1][currentCol] != 1); break;
    case 1: frontClear = (walls[currentRow][currentCol+1] != 1); break;
    case 2: frontClear = (walls[currentRow+1][currentCol] != 1); break;
    case 3: frontClear = (walls[currentRow][currentCol-1] != 1); break;
  }
  if (leftClear == false && frontClear == true) {
    println("left not clear but front is");
    switch(currentDir) {
      case 0: currentRow--; break;
      case 1: currentCol++; break;
      case 2: currentRow++; break;
      case 3: currentCol--; break;
    }
  }
  else if (leftClear == false && frontClear == false) {
    println("left and front blocked - turning.");
    currentDir++; 
    if (currentDir == 4) currentDir = 0;
    switch(currentDir) {
      case 0: currentRow--; break;
      case 1: currentCol++; break;
      case 2: currentRow++; break;
      case 3: currentCol--; break;
    }
  }
  else if (leftClear == true) {
    println("left clear but didnt check front - turning and moving");
    currentDir--;
    if (currentDir == -1) currentDir = 3;
    switch(currentDir) {
      case 0: currentRow--; break;
      case 1: currentCol++; break;
      case 2: currentRow++; break;
      case 3: currentCol--; break;
    }
  }
}

void keyPressed() {
  switch (key) {
    case 'm': {switch(followDirection) {
                case 'r': followWallRight();
                          break;
                case 'l': followWallLeft();
                break;
              }
              break;
    }
    case 'r': {followDirection = 'r';
              break;
    }
    case 'l': {followDirection = 'l';
              break;
    }
  }
}

boolean finished() {
  if (walls[currentRow][currentCol] == 3) {
    return true;
  } else {
    return false;
  }
}
