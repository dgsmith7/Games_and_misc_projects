// Atari Style Breakout by David G. Smith 26 Oct 2014
// modified 2 Nov 2014


// load sound player library
import ddf.minim.*;
Minim minim;
AudioPlayer au_paddle ,au_new;
AudioPlayer [] au_brick = new AudioPlayer [5];

final int START = 0;
final int PLAY = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
final int SERVE = 4;
int brickCounter;
int timer = millis();
int gameState = START;
int ballsLeft =3;
Brick paddle = new Brick ();
Brick bricks[] = new Brick [144];
Ball gameBall = new Ball ();
int[] brickX;
int[] brickY;
color[] colors;
boolean[] mark;
final int BRICKNUM=144;
int ballSpeed;
int score = 0;
int bricksOut =0;

void setup() {
// setup audio players
  minim = new Minim(this) ;
  for (int i = 0; i<au_brick.length; i++) {
au_brick [i] = minim.loadFile("brickSound.mp3");
  }
au_paddle = minim.loadFile("paddleSound.mp3") ;
au_new = minim.loadFile("newGameSound.mp3") ;

  size(720, 600);
  for (int i=0; i<BRICKNUM; i++) {
    //The color order from the bottom up is yellow, 
    //green, orange and red.   Build brick array and set Colors:
    bricks[i] = new Brick ();
    bricks[i].intact = true;
  }
  for (int i=0; i<18; i++) {
    bricks[i].xPosit = i*40;
    bricks[i].yPosit = 60;
    bricks[i].brickColor = color(255, 0, 0);
    bricks[i].scoreValue = 8;
  }
  for (int i=18; i<36; i++) {
    bricks[i].xPosit = (i-18)*40;
    bricks[i].yPosit = 80;
    bricks[i].brickColor = color(255, 0, 0);
    bricks[i].scoreValue = 7;
  }
  for (int i=36; i<54; i++) {
    bricks[i].xPosit = (i-36)*40;
    bricks[i].yPosit = 100;
    bricks[i].brickColor = color(255, 127, 0);
    bricks[i].scoreValue = 6;
  }
  for (int i=54; i<72; i++) {
    bricks[i].xPosit = (i-54)*40;
    bricks[i].yPosit = 120;
    bricks[i].brickColor = color(255, 127, 0);
    bricks[i].scoreValue = 5;
  }
  for (int i=72; i<90; i++) {
    bricks[i].xPosit = (i-72)*40;
    bricks[i].yPosit = 140;
    bricks[i].brickColor = color(0, 255, 0);
    bricks[i].scoreValue = 4;
  }
  for (int i=90; i<108; i++) {
    bricks[i].xPosit = (i-90)*40;
    bricks[i].yPosit = 160;
    bricks[i].brickColor = color(0, 255, 0);
    bricks[i].scoreValue = 3;
  }  
  for (int i=108; i<126; i++) {
    bricks[i].xPosit = (i-108)*40;
    bricks[i].yPosit = 180;
    bricks[i].brickColor = color(255, 255, 0);
    bricks[i].scoreValue = 2;
  }  
  for (int i=126; i<144; i++) {
    bricks[i].xPosit = (i-126)*40;
    bricks[i].yPosit = 200;
    bricks[i].brickColor = color(255, 255, 0);
    bricks[i].scoreValue = 1;
  }
  for (int i=0; i<BRICKNUM; i++) {
    bricks[i].top = bricks[i].yPosit;
    bricks[i].bottom = bricks[i].yPosit+bricks[i].tall-1;
    bricks[i].left = bricks[i].xPosit;
    bricks[i].right = bricks[i].xPosit+bricks[i].wide-1;
  }
  gameBall.xPosit = width/2;
  gameBall.yPosit = 491;
  ballSpeed = 2;
  paddle.xPosit = width/2;
  paddle.yPosit=500;
  paddle.wide=100;
  paddle.brickColor = color (255, 255, 0);
}

void stop() {
  minim.stop() ;
  super.stop() ; 
}

void draw() {
  switch(gameState) {
  case START:
    startScreen();
    break;
  case PLAY:
    playGame();
    break;
  case PAUSE:
    pauseScreen ();
    break;
  case GAMEOVER:
    gameOverScreen ();
    break;
  case SERVE:
    serveScreen ();
    break;
  }
}

void keyPressed () { // change game state based on keys
  if ((gameState == GAMEOVER) && (key == 's' || key == 'S')) {
    gameState = START;
  }
  if ((gameState == START) && (key == ' ')) {
    gameState = PLAY; 
  }
  if ((gameState == PLAY) && (key == 'p' || key == 'P')) {
    gameState = PAUSE;
  }
  if ((gameState == PAUSE) && (key == 'r' || key == 'R')) {
    gameState = PLAY;
  }
  if ((gameState == SERVE) && (key == 'l' || key == 'L')) {
    gameState = PLAY; 
  }
}

void startScreen () { 
  background (0);
  ballsLeft = 3;
  score=0;
  for (int i=0; i<BRICKNUM; i++) {
    bricks[i].intact = true;
    bricks[i].display ();
  }
  paddle.wide=100;
  paddle.xPosit = mouseX;  // paddle at edges
  if (mouseX> width-100) {
    paddle.xPosit = width-paddle.wide;
  }
  if (mouseX<=0) {
    paddle.xPosit=0;
  } 
  paddle.yPosit=500;
  paddle.brickColor = color(255, 255, 0);
  paddle.display ();
  textAlign(CENTER);
  textSize(24);
  fill(255, 255, 0);
  text("Press SPACE to start a new game.\nControl paddle with mouse.\nPress P to pause during Gameplay.\nPress ESC to exit.", width/2, height/2);
  if (au_new.isPlaying () == false)  {au_new.rewind ();} 
  au_new.play ();
}

void serveScreen () {
  background (0);
    for (int i=0; i<BRICKNUM; i++) {
    bricks[i].display ();
  }
  paddle.wide=100;
  paddle.xPosit = mouseX;  // paddle at edges
  if (mouseX> width-100) {
    paddle.xPosit = width-paddle.wide;
  }
  if (mouseX<=0) {
    paddle.xPosit=0;
  } 
  paddle.yPosit=500;
  paddle.brickColor = color(255, 255, 0);
  paddle.display ();
  gameBall.xPosit = width/2;
  gameBall.yPosit = 491;
  gameBall.rise = -1;
  gameBall.run=-1;
  textAlign(CENTER);
  textSize(24);
  fill(255, 255, 0);
  text("Press L to launch next ball.\nESC to exit.", width/2, height/2);
}

void pauseScreen () {
  textAlign(CENTER);
  textSize(24);
  fill(255, 255, 0);
  text("Game Paused.\nPress R to resume.\nESC to exit.", width/2, height/2);
}

void gameOverScreen () {
  paddle.brickColor = color (255, 255, 0);
  paddle.display ();
  textAlign(CENTER);
  textSize(24);
  fill(255, 255, 0);
  text("Game Over.\nYour score was "+score+".\nPress S for start screen.\nESC to exit.", width/2, height/2);
  ballsLeft = 3; 
  gameBall.xPosit = width/2;
  gameBall.yPosit = 491;
  gameBall.rise = -1;
  gameBall.run=-1;
}

void playGame () {
  background(0);  
  float newRun;
  background(0);
  fill(255, 255, 0);
  textAlign(LEFT);
  textSize (24);
  text("Score: "+score, 50, 550);
  textAlign(RIGHT);
  text("Balls Remaining: "+(ballsLeft-1), 670, 550);
  rectMode(CORNER);
  for (int i=0; i<BRICKNUM; i++) {
    bricks[i].display ();
  }
  hits();
  paddle.wide=100;
  paddle.xPosit = mouseX;  // paddle at edges
  if (mouseX> width-100) {
    paddle.xPosit = width-paddle.wide;
  }
  if (mouseX<=0) {
    paddle.xPosit=0;
  } 
  paddle.yPosit=500;
  paddle.display ();
  newRun = gameBall.run*ballSpeed; // keep ball from zeroing out
  if ((newRun > -0.7)&&(newRun<0)) {// keep ball from zeroing out
    newRun = -0.7;
  }
  if ((newRun < 0.7)&&(newRun >0)) {// keep ball from zeroing out
    newRun = 0.7;
  }
  gameBall.xPosit += newRun;
  gameBall.yPosit += gameBall.rise*ballSpeed;
  gameBall.display();
  checkPaddleContact ();
  checkWallContact ();
}

void hits() { //check for ball collission with bricks
  int which=128;
  float brickTopY;
  float brickBottomY;
  float brickLeftX;
  float brickRightX;
  float ballTopY;
  float ballBottomY;
  float ballLeftX;
  float ballRightX;
  float ballCenterX;
  float ballCenterY;
  if ((gameBall.yPosit-gameBall.size/2 <220) && (gameBall.yPosit+gameBall.size/2 >60)) { // if ball in "brick zone"
    for (int i = 0; i<BRICKNUM; i++) {//check each brick's edges for edge of ball
      brickTopY = bricks[i].top;
      brickBottomY = bricks[i].bottom;
      brickLeftX = bricks[i].left;
      brickRightX = bricks[i].right;
      ballTopY = gameBall.yPosit-gameBall.size/2;
      ballBottomY = gameBall.yPosit+gameBall.size/2;
      ballLeftX = gameBall.xPosit-gameBall.size/2;
      ballRightX = gameBall.xPosit+gameBall.size/2;
      ballCenterX = gameBall.xPosit;
      ballCenterY = gameBall.yPosit;
      if (((ballTopY<=brickBottomY)&&(ballCenterY>brickBottomY)) || ((ballBottomY>=brickTopY)&&(ballCenterY<brickTopY))) {// ball hit from bottom or top
        for (int j = 0; j <720; j+=40) {//figure out which column
          if ((ballCenterX >=j) && (ballCenterX <= j+40)) {//found the correct column
            which = i + (j/40); 
            if (bricks[which].intact == true) { //break brick if brick is intact
              bricks[which].intact=false;
              au_brick[brickCounter].play (); au_brick[brickCounter].cue(0);
              brickCounter ++;
              if (brickCounter==au_brick.length) {brickCounter = 0;}
              score=score+bricks[which].scoreValue;
              gameBall.rise = gameBall.rise* -1;
              j=720;
            }// end break brick if brick is intact
          } // end found correct column
        } // end figure out which column
        i=BRICKNUM;
      } // end ball hit from bottom or top
      else {// not from bottom or top
        if (((ballRightX>brickLeftX)&&(ballCenterX<=brickLeftX)) || ((ballLeftX<brickRightX)&&(ballCenterX>=brickRightX))) {// ball hit from left or right
          for (int j = 60; j <220; j+=20) {//figure out which row
            if ((ballCenterY >=j) && (ballCenterY <= j+20)) {//found the correct row
              which = (((j-60)/20)*18)+i; 
              if (bricks[which].intact == true) { //break brick if brick is intact
                bricks[which].intact=false;
              au_brick[brickCounter].play (); au_brick[brickCounter].cue(0);
              brickCounter ++;
              if (brickCounter==au_brick.length) {brickCounter = 0;}
                gameBall.run = gameBall.run* -1;
                score=score+bricks[which].scoreValue;
                j=220;
              }// end break brick if brick is intact
            } // end found correct row
          } // end figure out which row
          i=BRICKNUM;
        }// end ball hit from left or right
      } // end not from bottom or top
    } // end check each brick's edges
  } // end if in brick zone
  if (boardComplete() == true) {// check board finished
    for (int i = 0; i < BRICKNUM; i++) {// check each brick status
      bricks[i].intact = true;
    }// end check each brick status
    gameState = SERVE;
  }// end check board finished
} // end hits ()

boolean boardComplete () { // check to see if the current board is cleared
  boolean done = true;
  int bricksIntact = 0;
  for (int i=0; i<BRICKNUM; i++) {
    if (bricks[i].intact == true) {
      bricksIntact ++;
      done = false;
    } 
    bricksOut = 144-bricksIntact;
  }
  return done;
}

void checkPaddleContact () {  // determine if ball hits or missed paddle and generate rebound angle based on paddle in fifths
  float fifthOfPaddle = paddle.wide / 5;
  if (gameBall.yPosit > 495) {  // ball about to miss paddle
  } else { // paddle under ball
    if ((gameBall.yPosit > 492) && ((gameBall.xPosit+gameBall.size>paddle.xPosit)&&(gameBall.xPosit-gameBall.size<paddle.xPosit+(paddle.wide)))) {
              au_paddle.play (); au_paddle.cue(0);
      gameBall.rise = -1*gameBall.rise;
      gameBall.yPosit = 490;
      if ((gameBall.xPosit-paddle.xPosit) > 4*fifthOfPaddle && (gameBall.xPosit-paddle.xPosit) <=paddle.wide) {//far right side of paddle
        gameBall.run = 1.5;
      }
      if ((gameBall.xPosit-paddle.xPosit) > 3*fifthOfPaddle && (gameBall.xPosit-paddle.xPosit) <=4*fifthOfPaddle) {//middle right side of paddle
        gameBall.run = 1.3;
      }
      if ((gameBall.xPosit-paddle.xPosit) > 2*fifthOfPaddle && (gameBall.xPosit-paddle.xPosit) <=3*fifthOfPaddle) {//middle of paddle
        gameBall.run = gameBall.run*-0.8;
      }
      if ((gameBall.xPosit-paddle.xPosit) > fifthOfPaddle && (gameBall.xPosit-paddle.xPosit) <=2*fifthOfPaddle) {//middle left side of paddle
        gameBall.run = -1.3;
      }
      if ((gameBall.xPosit-paddle.xPosit) >= 0 && (gameBall.xPosit-paddle.xPosit) <=fifthOfPaddle) {//far left side of paddle
        gameBall.run = -1.5;
      }
    }
  } 
  if (gameBall.yPosit > height+gameBall.size/2) { // paddle miss
      ballsLeft = ballsLeft - 1; 
  if (ballsLeft == 3) {
      gameState = START;}
  if ((ballsLeft<3) && (ballsLeft > 0)) {
      gameState = SERVE;
    } else {
      gameState = GAMEOVER;
    }
  }
}

void checkWallContact () { 
  //if ball hits wall, reverse run.  if ball hits top, reverse rise, if ball hits bottom decreases lives
  if ((gameBall.xPosit < (0+gameBall.size/2)) || (gameBall.xPosit > (width-gameBall.size/2))) {
    gameBall.run = -1*gameBall.run;
  }
  if (gameBall.yPosit < 0+gameBall.size/2) {
    gameBall.rise = -1*gameBall.rise;
  }
}


