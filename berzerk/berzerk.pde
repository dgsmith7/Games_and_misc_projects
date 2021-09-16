import processing.sound.*;
// sounds downloaded from freesound.org
// plShoot - https://freesound.org/people/bubaproducer/sounds/151022/
// plShoot license - https://creativecommons.org/licenses/by/3.0/
// all others license - public domain

SoundFile plShoot, zap, roboShoot, roboVoice, boom;
PImage logo;
int gameState = 0; //0-Ready 1-Play 2-GameOver 3-About
float quadWidth, quadHeight;
MapQuad[][] map = new MapQuad[3][4];
int[][] levels = {{9, 8, 0, 12, 11, 0, 1, 10, 3, 0, 2, 6}, 
  {9, 8, 12, 8, 1, 6, 2, 4, 3, 2, 0, 6}, 
  {9, 8, 8, 12, 3, 2, 4, 4, 1, 2, 6, 4}, 
  {9, 9, 12, 4, 1, 1, 5, 4, 3, 6, 2, 6}, 
  {9, 8, 8, 12, 10, 8, 2, 4, 3, 2, 3, 6}
};
int currentLevel = 0;
int nRobots = 7; 
int nBullets = 50;
Mover player1;
Robot[] robots = new Robot[nRobots];
Projectile[] bullets = new Projectile[nBullets];
int bulletIndex = 0;
int score = 0;
int hiScore = 0;
int livesRemaining = 3;
boolean offGrid = false;

void setup () {
  size(1200, 700);
  background(0);
  textSize(25);
  textAlign(CENTER);
  logo = loadImage("Berzerk-Logo.png");  // from http://www.pixelatedarcade.com/pictures/logos/1696/Berzerk-Logo.png
  quadWidth = width / 4;
  quadHeight = height / 3;
  loadSounds();
}

void draw() {
  background(0);
  switch(gameState) {
  case 0: 
    {  //  Ready screen
      displayReadyScreen();
      break;
    }
  case 1: 
    {  //  Play mode 
      if (offGrid == true) {
        delay(3000);
        newLevel();
      }
      displayPlayScreen();
      displayMap();
      displayAndUpdateRobots();
      if (frameCount % 1000 == 0) {
        roboVoice.play();
      }
      player1.display();
      displayAndUpdateBullets();
      checkWallAgainstPlayer();
      checkWallAgainstRobots();
      checkPlayerRobotContact();
      checkBulletHits();
      checkBulletsAndWalls();
      checkGameOver();
      displayStats();
      if (playerEscaped() == true) {
        score = score + 500;
        text("You escaped!!! - get ready for level " + (currentLevel + 1), width/2, 200);
        offGrid = true;
      } else {
        offGrid = false;
      }
      break;
    }
  case 2: 
    {  //  Game Over   
      if (hiScore < score) {
        hiScore = score;
      }
      displayStats();
      displayGameOverScreen();
      break;
    }
  case 3: 
    {  //  About   
      displayAboutScreen();
      break;
    }
  }
}

boolean playerEscaped() {
  if ((player1.x < -1 * player1.wide) || (player1.x > width) || 
    (player1.y < -1 * player1.high) || (player1.y > height)) {
    return true;
  } else {
    return false;
  }
}

void loadSounds() {
  plShoot = new SoundFile(this, "plShoot.wav");
  zap = new SoundFile(this, "zap.wav");
  roboShoot = new SoundFile(this, "roboShoot.wav");
  roboVoice = new SoundFile(this, "roboVoice.wav");
  boom = new SoundFile(this, "boom.wav");
}

void newLevel() {
  buildMap();
  buildRobots();
  buildBullets();
  player1 = new Player(150, 125);
  currentLevel++;
  if (currentLevel == 5) {
    currentLevel = 0;
  }
}

void buildMap() {// call constructors for mapquads
  int counter = 0;
  for (int i = 0; i < 3; i ++) {
    for (int j = 0; j < 4; j ++) {
      map[i][j] = new MapQuad(j * quadWidth, i * quadHeight, quadWidth, quadHeight, levels[currentLevel][counter]);
      counter ++;
    }
  }
}

void displayMap() {
  for (int i = 0; i < 3; i ++) {
    for (int j = 0; j < 4; j ++) {
      map[i][j].display();
    }
  }
}

void buildRobots() {
  int robotCounter = 0;
  for (int i = 0; i < 3; i ++) {
    for (int j = 1; j < 4; j ++) {
      if (robotCounter < nRobots) {
        robots[robotCounter] = new Robot(map[i][j].x + 100 + random(-40, 40), 
          map[i][j].y + 100 + random(-40, 40));
        robotCounter ++;
      }
    }
  }
}

void displayAndUpdateRobots() {
  for (int i = 0; i < nRobots; i ++) {
    robots[i].display();
    robots[i].determineNextMove();
    if (frameCount % 7 == 0) {
      robots[i].updatePosition(robots[i].currentDirection);
    }
    if (frameCount % 100 == 0) {
    if (robots[i].shouldShoot() == true) {
      bullets[bulletIndex].fire(robots[i]);
      roboShoot.play();
      bulletIndex ++;
      if (bulletIndex == 50) {
        bulletIndex = 0;
      }
    }
    }
  }
}

  void buildBullets() {
    for (int i = 0; i < nBullets; i ++) {
      bullets[i] = new Projectile(- 25, i * 10);
    }
  }

  void displayAndUpdateBullets() {
    for (int i = 0; i < nBullets; i ++) {
      bullets[i].display();
      bullets[i].updatePosition();
    }
  }

  void playerDies() {
    delay(1000);
    player1.live = false;
    player1.x = 50;
    player1.y = 50;
    player1.top = player1.y;
    player1.right = player1.x + player1.wide;
    player1.bottom = player1.y + player1.high ;
    player1.left = player1.x;
    livesRemaining--;
  }

  void checkWallAgainstPlayer() {       // if wall collissions, mover.zap
    boolean playerContact = false;
    for (int i = 0; i < 3; i ++) {
      for (int j = 0; j < 4; j ++) {
        if (map[i][j].isTouching(player1) == true) {  // Mover is touching a wall
          playerContact = true;
        }
      }
    }
    if (playerContact == true) {
      zap.play();
      playerDies();
    }
  }

  void checkWallAgainstRobots() {       // if wall collissions, mover.zap
    for (int i = 0; i < 3; i ++) {
      for (int j = 0; j < 4; j ++) {
        for (int k = 0; k < nRobots; k ++) {
          if (map[i][j].isTouching(robots[k]) == true) {  // Mover is touching a wall
            zap.play();
            robots[k].dies();
          }
        }
      }
    }
  }

  void checkPlayerRobotContact() {  // if mover collissions, player.zap, robot.zap
    for (int k = 0; k < nRobots; k ++) {
      if (robots[k].isTouching(player1) == true) {  // Mover is touching a wall
        boom.play();
        robots[k].dies();
        score = score + 100;
        zap.play();
        playerDies();
      }
    }
  }

  void checkBulletHits() {   // if bullet collission, mover.zap
    for (int i = 0; i < nBullets; i++) {
      for (int j = 0; j < nRobots; j ++) {
        if (bullets[i].isTouching(robots[j])) {
          boom.play();
          robots[j].dies();
          score = score + 100;
          bullets[i].x = -25;
          bullets[i].y = bulletIndex * 10;
          bullets[i].live = false;
        }
        if (bullets[i].isTouching(player1)) {
          zap.play();
          playerDies();
          bullets[i].x = -25;
          bullets[i].y = bulletIndex * 10;
          bullets[i].live = false;
        }
      }
    }
  }

  void checkBulletsAndWalls() {
    for (int i = 0; i < 3; i ++) {
      for (int j = 0; j < 4; j ++) {
        for (int k = 0; k < nBullets; k ++) {
          if (map[i][j].isTouching(bullets[k]) == true) {  // Mover is touching a wall
            bullets[k].x = -25;
            bullets[k].y = bulletIndex * 10;
            bullets[k].live = false;
          }
        }
      }
    }
  }

  void checkGameOver() {   // if number of lives < 0, gamestate is 3
    if (livesRemaining == 0) {
      roboVoice.play();
      gameState = 2;
      currentLevel = 0;
    } else {
      if (player1.live == false) {
        player1.live = true;
      }
    }
  }

  void displayStats() {   // show score, lives remaining, etc.
    noStroke();
    fill(255, 100);
    text(score, 100, 50);
    text("High: " + hiScore, width/2, 50);
    for (int i = 0; i < livesRemaining; i ++) {
      rect((width - 100) + (i * (player1.wide + 10)), 50 - player1.high, player1.wide, player1.high);
    }
    if (player1.live == false) {
      text(livesRemaining + " lives left", width/2, 150);
    }
  }

  void displayReadyScreen() {
    imageMode(CENTER);
    image(logo, width/2, 150);
    textSize(10);
    text("Logo from http://www.pixelatedarcade.com/pictures/logos/1696/Berzerk-Logo.png", width/2, height /2);
    textSize(25);
    text("P - Play   E - Exit   A - About", width/2, height - 50);
  }

  void displayPlayScreen() {
    textSize(15);
    fill(255, 75);
    text("Q - Quit   SPACE - Fire   ARROWS - Move", width/2, height - 25);
    textSize(25);
    fill(255);
  }

  void displayGameOverScreen() {
    text("G A M E   O V E R", width /2, height /2);
    text("SPACE - continue   E - Exit", width/2, height - 50);
  }

  void displayAboutScreen() {
    text("B E R Z E R K  for Processing", width/2, 100);
    text("By David G. Smith", width/2, 150);
    text("Escape the Maze!  Walls are electrified.", width /2, height /2);
    text("Robots are not your friends!", width/2, height/2 + 30);
    text("Watch out for evil Otto!", width/2, height/2 + 60);
    text("Controls - Move with arrow keys, SPACE to fire", width/2, height/2 + 90);
    text("SPACE - continue   E - Exit", width/2, height - 50);
  }

  void keyPressed() {
    switch(gameState) {
    case 0: 
      {  //  Ready screen  
        switch(key) {
        case 'p':
        case 'P': 
          {
            background(0);
            newLevel();
            score = 0;
            livesRemaining = 3;
            gameState = 1;
            roboVoice.play();
            break;
          }
        case 'e':
        case 'E': 
          {
            exit();
          }
        case 'a':
        case 'A': 
          {
            gameState = 3;
            break;
          }
        }
        break;
      }
    case 1: 
      {  //  Play mode  
        switch(key) {
        case ' ': 
          {  //fire weapon
            if (keyPressed == true) {
              bullets[bulletIndex].fire(player1);
              plShoot.play();
              bulletIndex ++;
              if (bulletIndex == 50) {
                bulletIndex = 0;
              }
            }
            break;
          }
        case 'q':
        case 'Q': 
          {  
            currentLevel = 0;
            gameState = 2;
            break;
          }
        }
        switch(keyCode) {
        case UP: 
          {  // move up
            player1.updatePosition(0);
            break;
          }
        case DOWN: 
          {  //  move down
            player1.updatePosition(2);
            break;
          }
        case LEFT: 
          {  //  move left
            player1.updatePosition(3);
            break;
          } 
        case RIGHT: 
          {  //  move right
            player1.updatePosition(1);
            break;
          }
        }
        break;
      }
    case 2: 
      {  //  Game Over   
        switch(key) {
        case 'e':
        case 'E': 
          {
            exit();
          }
        case ' ': 
          {
            gameState = 0;
            break;
          }
        }
        break;
      }
    case 3: 
      {  //  About  
        switch(key) {
        case 'e':
        case 'E': 
          {
            exit();
            break;
          }
        case ' ': 
          {
            gameState = 0;
            break;
          }
        }
        break;
      }
    }
  }