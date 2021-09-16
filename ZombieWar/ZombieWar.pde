// Gif
import gifAnimation.*;

// Sound
import ddf.minim.*;
Minim minim;
AudioPlayer auBattleStart, auFirstAid, auZombieWins, auHumanWins, auHumanBirth, auZombieSpawn, auBackMusic;

// Global variables
final int START = 0;
final int PLAY = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
final int SETUP = 4;
int gameState = SETUP;
int defaultTeam = 15;
int maxTeam = 500; // max size of teams
int numHumans = defaultTeam;  
int numZombies = defaultTeam; 
int waitStart = 0;
int numFires = int(random(0, 2)+3);
float speed = 0.3;
float theOneSpeed = 2.0;
int currentFighter = 0;
boolean theOneOnFire;
Fire [] fires = new Fire [numFires];
Zombie [] zombies = new Zombie [maxTeam*3];  // Zombie respawn limited to 3 x original team
Human [] humans = new Human [maxTeam];
Stain [] humanStains = new Stain [maxTeam];
Stain [] zombieStains = new Stain [maxTeam*3];
Pickup firstAidKit = new Pickup (360, 450);
Gif [] walkAndFight = new Gif [12];
Gif p;
String [] fileName = {
  "HumanWalkLeft.gif", "HumanWalkRight.gif", "HumanFightLeft.gif", "HumanFightRight.gif", "LimpLeft.gif", "LimpRight.gif", "ZombieFightLeft.gif", "ZombieFightRight.gif", "PlayerWalkLeft.gif", "PlayerWalkRight.gif", "PlayerFightLeft.gif", "PlayerFightRight.gif"
};

void setup () {
  for (int i = 0; i < numFires; i++) {  // generate pits
    fires[i] = new Fire(random(0, 620)+50, random(0, 450)+50, random(0, 10)+15);
  }

  for (int i = 0; i < 12; i++) {  // load Gifs
    walkAndFight[i] = new Gif(this, fileName [i]);
    walkAndFight[i].play();
  }
  minim = new Minim(this);  // load sounds
  auBattleStart = minim.loadFile("BattleBell.mp3");
  auFirstAid = minim.loadFile("FirstAid.mp3");
  auZombieWins = minim.loadFile("ZombieWins.mp3");
  auHumanWins = minim.loadFile("HumanWins.mp3");
  auHumanBirth = minim.loadFile("HumanBirth.mp3");
  auZombieSpawn = minim.loadFile("ZombieSpawn.mp3");
  auBackMusic = minim.loadFile("Thriller.mp3");
  size(720, 600);  // set screen
}  // end setup

void draw () {  // game control
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
  case SETUP:
    setupScreen ();
    break;
  }
}  // end draw

void keyPressed() {  // check for keys
  if ((key == CODED)&&(gameState == PLAY)) {
    if (keyCode == UP) {
      humans[0].direction = 1;
      humans[0].y -= theOneSpeed; 
      if (humans[0].y < 35) {
        humans[0].y = 35;
      }
    }
    if (keyCode == DOWN) {
      humans[0].direction = 3;
      humans[0].y += theOneSpeed; 
      if (humans[0].y > 530) {
        humans[0].y = 530;
      }
    }
    if (keyCode == LEFT) {
      humans[0].direction = 4;
      humans[0].x -= theOneSpeed; 
      if (humans[0].x < 10) {
        humans[0].x = 10;
      }
    }
    if (keyCode == RIGHT) {
      humans[0].direction = 2;
      humans[0].x += theOneSpeed; 
      if (humans[0].x > 690) {
        humans[0].x = 690;
      }
    }
  } else {
    if ((gameState == GAMEOVER) && (key == 's' || key == 'S')) {
      gameState = SETUP;
      newGameParameterReset ();
    }
    if ((gameState == START) && (key == 's' || key == 'S')) {
      gameState = SETUP;
    } 
    if ((gameState == SETUP) && (key == 'f' || key == 'F')) {
      gameState= START;
    }
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
}

void newGameParameterReset () {
  numHumans = defaultTeam;  
  numZombies = defaultTeam;
  humans[0].dead=false;
} 

void mouseClicked () {  // check for clicks
  if (gameState == SETUP) {
    if ((mouseX > 200) && (mouseX < 225)) { //  Zombie buttons
      if ((mouseY >= 450) && (mouseY < 475)) { // up button
        numZombies += 1; 
        auZombieSpawn.play ();
        auZombieSpawn.rewind ();
        if (numZombies > maxTeam) {
          numZombies = maxTeam;  
          setupScreen ();
        }
      }
      if ((mouseY >= 510) && (mouseY < 535)) { // down button
        numZombies -= 1; 
        auHumanWins.play ();
        auHumanWins.rewind();
        if (numZombies < 1) {
          numZombies = 1;  
          setupScreen ();
        }
      }
    }
    if ((mouseX > 500) && (mouseX < 525)) { // Human buttons
      if ((mouseY >= 450) && (mouseY < 475)) { // up button
        numHumans += 1; 
        auHumanBirth.play ();
        auHumanBirth.rewind();
        if (numHumans > maxTeam) {
          numHumans = maxTeam;  
          setupScreen ();
        }
      }
      if ((mouseY >= 510) && (mouseY < 535)) { // down button
        numHumans -= 1; 
        auZombieWins.play ();
        auZombieWins.rewind();
        if (numHumans < 1) {
          numHumans = 1;  
          setupScreen ();
        }
      }
    }
  }
}

void drawButtons () {  // draws buttons for team size selection
  fill (0);
  stroke (200);
  rect (200, 450, 25, 25, 10);
  rect (200, 510, 25, 25, 10);
  rect (500, 450, 25, 25, 10);
  rect (500, 510, 25, 25, 10);
  stroke (255, 0, 0);  // draws + and - on buttons
  line(213, 457, 213, 467);
  line(208, 462, 218, 462);
  line(208, 522, 218, 522);
  line(513, 457, 513, 467);
  line(508, 462, 518, 462);
  line(508, 522, 518, 522);
}

void drawVeil () { // draws the Title screen 
  fill (100, 100, 100, 25);
  rect (50, 50, 620, 500, 10);
  textAlign(CENTER);
  textSize(48);
  fill(255, 0, 0);
  text ("Z O M B I E   W A R", width/2, 110);
}

void startScreen() {
  auBackMusic.loop();
  background (183);
  drawVeil ();
  textAlign(CENTER);
  textSize(24);
  fill(0);
  text("You are HUMAN. Your team is Black.\nYour HUMAN is blue.\nControl yourself with arrow keys.\nZOMBIES are purple. Run into them to pick a fight.\nYour teammates are fighting too.", width/2, 150);
  text("Setup complete. Press S to return to SETUP.\nPress SPACE to begin battle.\nPress P to pause during Gameplay.\nPress ESC to exit.", width/2, 425);

  for (int i = 0; i < numZombies; i++) {  // initialize and randomly place zombie team
    float x = random(0, 620)+50;
    float y = random(0, 175)+50;
    int d = 3; // int(random(0, 4)+1);
    zombies[i] = new Zombie(x, y, d);
    zombies[i].dead = false;
    zombieStains[i] = new Stain(zombies[i].x, zombies[i].y, color(180, 10, 40), int(random(0, 3)));
  }

  humans[0] = new Human(width/2, 490, 1); // initialize and put "player" in bottom center
  humanStains[0] = new Stain(humans[0].x, humans[0].y, color(180, 10, 40), int(random(0, 3)));
  humans[0].theOne = true;
  humans[0].dead = false;
  humans[0].health = 40;

  for (int i = 1; i < numHumans; i++) {  // initialize and randomly place human team
    float x = random(0, 620)+50;
    float y = random(0, 175)+325;
    int d = 1; // int(random(0, 4)+1);
    humans[i] = new Human(x, y, d);
    humans[i].dead = false;
    humanStains[i] = new Stain(humans[i].x, humans[i].y, color(180, 10, 40), int(random(0, 3)));
  }
}  // end startScreen

void pauseScreen () {
  background (183);
  drawVeil ();
  textAlign(CENTER);
  textSize(24);
  fill(200);
  text("Game Paused.\nPress R to resume.\nESC to exit.", width/2, height/2);
}  // end pauseScreen

void gameOverScreen () {
  drawVeil ();
  textAlign(CENTER);
  textSize(24);
  fill(200);
  if (humans[0].health == 0) {
    text("You were turned into a ZOMBIE when \nyou ran out of health.", width/2, 200);
  }
  if (theOneOnFire == true) {
    text("Ooh that burns!\nYou will be a crispy treat for some lucky Zombie.", width/2, 200);
  }
  if (liveZombieCount() == 0) {
    text("The HUMANS prevailed. Life goes on...\nuntil the next fight.", width/2, 200);
  }
  text("Game Over.\nThe "+whoWon ()+" won.\nPress S for setup screen.\nESC to exit.", width/2, height/2);
  auBackMusic.play();
}  //  end gameOverScreen

void setupScreen () {
  background (183);
  drawVeil ();
  textAlign(CENTER);
  textSize(24);
  fill(0);
  text("Click on the buttons to adjust the initial team sizes.\nPress F to fight.\nESC to exit.", width/2, height/2);
  text("Zombie Team: "+numZombies, 230, 500);
  text("Human Team: "+numHumans, 500, 500);
  drawButtons ();
}  // end playGame

void playGame() {
  background (183);
  textAlign(LEFT);
  textSize(20);
  fill(255, 0, 0);
  text("HEALTH:  ", 25, 25);
  fill(70, 135, 220);
  text("You: "+humans[0].health, 125, 25);
  fill(0);
  text("HUMANS: "+getHumanTeamHealth(), 225, 25);
  fill(185, 95, 115);
  text("ZOMBIES: "+getZombieTeamHealth(), 425, 25); 
  fill(255, 0, 0);
  text("POPULATION:    ", 25, 585);
  fill(0);
  text(liveHumanCount()+" HUMANS  ", 175, 585);
  fill(185, 95, 115);
  text(liveZombieCount()+" ZOMBIES       ", 325, 585);
  fill(0);
  textAlign(CENTER);
  drawfires ();
  drawStains (); //paint stains for the dead

  // draw zombies 
    for (int i = 0; i < numZombies; i++) {
    if (zombies[i].dead == false ) {
      zombies[i].display();
    }
    if (zombies[i].direction == 1) {
      zombies[i].y-=(.5*speed*zombies[i].slowFactor); 
      if (zombies[i].y<35) {
        zombies[i].y = 35;
        zombies[i].direction = 3;
      }
    } 
    if (zombies[i].direction == 3) {
      zombies[i].y+=(.5*speed*zombies[i].slowFactor); 
      if (zombies[i].y>530) {
        zombies[i].y = 530;
        zombies[i].direction = 1;
      }
    }
    if (zombies[i].direction == 2) {
      zombies[i].x+=(.5*speed*zombies[i].slowFactor); 
      if (zombies[i].x>690) {
        zombies[i].x = 690;
        zombies[i].direction = 4;
      }
    }
    if (zombies[i].direction == 4) {
      zombies[i].x-=(.5*speed*zombies[i].slowFactor); 
      if (zombies[i].x<10) {
        zombies[i].x = 10;
        zombies[i].direction = 2;
      }
    }
  }
// draw the one
  humans[0].display ();
//  draw other humans
  for (int i = 1; i < numHumans; i++) {
    if (humans[i].dead == false) {
      humans[i].display();
    }
    if (humans[i].direction == 1) {
      humans[i].y-=speed*humans[i].slowFactor; 
      if (humans[i].y<35) {
        humans[i].y = 35;
        humans[i].direction = 3;
      }
    }
    if (humans[i].direction == 3) {
      humans[i].y+=speed*humans[i].slowFactor; 
      if (humans[i].y>530) {
        humans[i].y = 530;
        humans[i].direction = 1;
      }
    }
    if (humans[i].direction == 2) {
      humans[i].x+=speed*humans[i].slowFactor; 
      if (humans[i].x>690) {
        humans[i].x = 690;
        humans[i].direction = 4;
      }
    }
    if (humans[i].direction == 4) {
      humans[i].x-=speed*humans[i].slowFactor; 
      if (humans[i].x<10) {
        humans[i].x = 10;
        humans[i].direction = 2;
      }
    }
  }
  // periodically drop a first aid kit in a random spot for about 2 minutes
  if (firstAidKit.live==true) {
    firstAidKit.display();
  }
  if (frameCount%1800==0) {
    waitStart = frameCount;
    firstAidKit.x=int(random(680)+10); 
    firstAidKit.y=int(random(510)+20); 
    firstAidKit.live=true;
  }
  if (frameCount == (waitStart+3600)) {
    firstAidKit.live = false;
  }

  checkForFight ();  //  see if there is a fight on the board and adjudicate
  checkForBurns ();  // see if anyone walked into the fire
  checkForPickUp ();  // see if first aid kit was picked up by the one
  makeIntelligentMoves ();  // change directions of players (except the one)

  if (boardComplete () == true) {  // check if the fight is over
    gameState = GAMEOVER;
  }
}  // end playGame

void drawStains () {
  for (int i = 0; i < numZombies; i++) {
    if (zombies[i].dead == true ) {
      zombieStains[i].display ();
    }
  }
  for (int i = 1; i < numHumans; i++) {
    if (humans[i].dead == true) {
      humanStains[i].display();
    }
  }
}

void drawfires () {
  for (int i = 0; i < numFires; i++) {
    fires[i].display();
  }
}

int getHumanTeamHealth() {
  int h = 0;
  for (int i = 0; i < numHumans; i++) {
    h+=humans[i].health;
  }
  return h;
}

int getZombieTeamHealth() {
  int h = 0;
  for (int i = 0; i < numZombies; i++) {
    h+=zombies[i].health;
  }
  return h;
}

void checkForFight () { //collision detection
  ellipseMode(CENTER);
  for (int i=0; i < numZombies; i++) {
    for (int j=0; j < numHumans; j ++) {
      if ((zombies[i].dead == false) && (humans[j].dead == false)) {
        float zcx = zombies[i].x+5;
        float zcy = zombies[i].y+10;
        float hcx = humans[j].x+5;
        float hcy = humans[j].y+10;
        if (((zcx<hcx+10) && (zcx > hcx-10)) && ((zcy<hcy+20) && (zcy>hcy-20))) {
          noFill(); 
          stroke(255, 0, 0); 
          ellipse(zombies[i].x+5, zombies[i].y+5, 35, 35);
          int winner=int(random(0, 2));
          if (winner == 0) {// zombie gets a shot in
            humans[j].health -=2; 
            if (humans[j].health<=0) {// human dies
              if (j==0) {
                gameState = GAMEOVER;
              }
              humans[j].dead = true; 
              auZombieWins.play();
              auZombieWins.rewind();
              humanStains[j].x = humans[j].x; 
              humanStains[j].y = humans[j].y; 
              humanStains[j].display(); 
              numZombies++;  
              if (numZombies > (3*maxTeam)) {
                numZombies = (3*maxTeam);
              }
              if (numZombies <= (3*maxTeam)) {
                zombies[numZombies-1] = new Zombie(humans[j].x, humans[j].y, 1); 
                zombies[numZombies-1].dead = false;
                zombieStains[numZombies-1] = new Stain(zombies[numZombies-1].x, zombies[numZombies-1].y, color(180, 10, 40), int(random(0, 3)));
                auZombieSpawn.play();
                auZombieSpawn.rewind();
              }
            }
          } else {// human get a shot in
            zombies[i].health -=2;
            if (zombies[i].health<=0) {// zombie dies
              zombies[i].dead = true; 
              zombieStains[i].x = zombies[i].x; 
              zombieStains[i].y = zombies[i].y; 
              zombieStains[i].display(); 
              auHumanWins.play();
              auHumanWins.rewind();
            }
          }
        }
      }
    }
  }
}

void checkForBurns () { // see if anyone walked into a fire
theOneOnFire = false;
  for (int i=0; i < numZombies; i++) {
    for (int j = 0; j < numFires; j++) {
      if (zombies[i].dead == false) {
        float zcx = zombies[i].x+5;
        float zcy = zombies[i].y+10;
        float pcx = fires[j].x;
        float pcy = fires[j].y;
        if (((zcx<pcx+fires[j].r*1.5) && (zcx > pcx-fires[j].r*1.5)) && ((zcy<pcy+fires[j].r) && (zcy>pcy-fires[j].r))) {
          zombies[i].dead = true; 
          zombieStains[i].x = fires[j].x; 
          zombieStains[i].y = fires[j].y; 
          zombieStains[i].c=color(75, 0); 
          zombies[i].health=0;
          auHumanWins.play();
          auHumanWins.rewind();
        }
      }
    }
  }
  for (int i=0; i < numHumans; i++) {
    for (int j = 0; j < numFires; j++) {
      if (humans[i].dead == false) {
        float hcx = humans[i].x+5;
        float hcy = humans[i].y+10;
        float pcx = fires[j].x;
        float pcy = fires[j].y;
        if (((hcx<pcx+fires[j].r*1.5) && (hcx > pcx-fires[j].r*1.5)) && ((hcy<pcy+fires[j].r) && (hcy>pcy-fires[j].r))) {
          humans[i].dead = true; 
          humanStains[i].x = fires[j].x; 
          humanStains[i].y = fires[j].y;
          humanStains[i].c=color(75, 0); 
          if  (i!=0) {humans[i].health=0;}
          auZombieWins.play();
          auZombieWins.rewind();
          if (i==0) {
            theOneOnFire = true;
            gameState = GAMEOVER;
          }
        }
      }
    }
  }
}

void checkForPickUp () {//  did the one grab the first aid kit
  float hcx = humans[0].x+5;
  float hcy = humans[0].y+10;
  float pcx = firstAidKit.x+5;
  float pcy = firstAidKit.y+5;
  if ((((hcx<pcx+10) && (hcx > pcx-10)) && ((hcy<pcy+10) && (hcy>pcy-10))) && (firstAidKit.live == true)) {
    humans[0].health += 25;
    firstAidKit.live = false;
    auFirstAid.play();
    auFirstAid.rewind();
  }
}

void makeIntelligentMoves () {  // bot movement algorithms 
  int when = frameCount;
  if (when%600==0) {// 0 intelligence means change direction every 20 seconds
    for (int i=0; i<numZombies; i++) {
      if (zombies[i].intelligence == 0) {
        zombies[i].direction = int(random(0, 5));
      }
    }
    for (int i=1; i<numHumans; i++) {
      if (humans[i].intelligence == 0) {
        humans[i].direction = int(random(0, 5));
      }
    }
  }
  if (when%1800==0) {// 1 intelligence means change direction every 60 seconds
    for (int i=0; i<numZombies; i++) {
      if (zombies[i].intelligence == 1) {
        zombies[i].direction = int(random(0, 5));
      }
    }
    for (int i=1; i<numHumans; i++) {
      if (humans[i].intelligence == 0) {
        humans[i].direction = int(random(0, 5));
      }
    }
  } 
  if (when%2700==0) {// 2 intelligence means change direction every 90 seconds
    for (int i=0; i<numZombies; i++) {
      if (zombies[i].intelligence == 2) {
        zombies[i].direction = int(random(0, 5));
      }
    }
    for (int i=1; i<numHumans; i++) {
      if (humans[i].intelligence == 0) {
        humans[i].direction = int(random(0, 5));
      }
    }
  }
  for (int i = 0; i < numZombies; i+=3 ) { // program every third zombie
    if ((zombies[i].intelligence == 2) && (humans[0].dead == false)) {  // chase the one
      if (zombies[i].x < humans[0].x) {
        zombies[i].direction = 2;
      }
      if (zombies[i].x > humans[0].x) {
        zombies[i].direction = 4;
      }
      if ((zombies[i].x > humans[0].x-2)&&(zombies[i].x < humans[0].x+2)) {
        if (zombies[i].y < humans[0].y) {
          zombies[i].direction = 3;
        } else {
          zombies[i].direction = 1;
        }
      }
    }
    if ((zombies[i].intelligence == 1) && (firstAidKit.live == true)) {  // converge on first aid via x then y
      if (zombies[i].x< firstAidKit.x) {
        zombies[i].direction = 2;
      }
      if (zombies[i].x > firstAidKit.x) {
        zombies[i].direction = 4;
      }
      if ((zombies[i].x > firstAidKit.x-2)&&(zombies[i].x < firstAidKit.x+2)) {
        if (zombies[i].y < firstAidKit.y) {
          zombies[i].direction = 3;
        } else {
          zombies[i].direction = 1;
        }
      }
    }
    if ((zombies[i].intelligence == 0) && (firstAidKit.live == true)) { // converge on first aid via y then x
      if (zombies[i].y< firstAidKit.y) {
        zombies[i].direction = 3;
      }
      if (zombies[i].y > firstAidKit.y) {
        zombies[i].direction = 1;
      }
      if ((zombies[i].y > firstAidKit.y-2) && (zombies[i].y < firstAidKit.y+2)) {
        if (zombies[i].x < firstAidKit.x) {
          zombies[i].direction = 2;
        } else {
          zombies[i].direction = 4;
        }
      }
    }
  }
  for (int i = 1; i < numHumans; i+=3 ) { // program every third human
    if ((humans[i].intelligence == 2) && (humans[0].dead == false)) {  // chase the one
      if (humans[i].x < humans[0].x) {
        humans[i].direction = 2;
      }
      if (humans[i].x > humans[0].x) {
        humans[i].direction = 4;
      }
      if ((humans[i].x > humans[0].x-2)&&(humans[i].x < humans[0].x+2)) {
        if (humans[i].y < humans[0].y) {
          humans[i].direction = 3;
        } else {
          humans[i].direction = 1;
        }
      }
    }
    if ((humans[i].intelligence == 1) && (firstAidKit.live == true)) {  // converge on first aid via x then y
      if (humans[i].x< firstAidKit.x) {
        humans[i].direction = 2;
      }
      if (humans[i].x > firstAidKit.x) {
        humans[i].direction = 4;
      }
      if ((humans[i].x > firstAidKit.x-2)&&(humans[i].x < firstAidKit.x+2)) {
        if (humans[i].y < firstAidKit.y) {
          humans[i].direction = 3;
        } else {
          humans[i].direction = 1;
        }
      }
    }
    if ((humans[i].intelligence == 0) && (firstAidKit.live == true)) { // converge on first aid via y then x
      if (humans[i].y< firstAidKit.y) {
        humans[i].direction = 3;
      }
      if (humans[i].y > firstAidKit.y) {
        humans[i].direction = 1;
      }
      if ((humans[i].y > firstAidKit.y-2) && (humans[i].y < firstAidKit.y+2)) {
        if (humans[i].x < firstAidKit.x) {
          humans[i].direction = 2;
        } else {
          humans[i].direction = 4;
        }
      }
    }
  }
}

void stop() {  // Sound requirements 
  minim.stop() ;
  super.stop() ;
}  //  end stop 

boolean boardComplete () { // check to see if the current board is cleared
  if ((liveHumanCount() == 0) || (liveZombieCount() == 0)) {
    return true;
  } else {
    return false;
  }
}  // end boardComplete

String whoWon () {
  String message = "Error";
  if ((liveHumanCount() == 0) || (humans[0].dead = true)) {
    message = "ZOMBIES";
  }
  if (liveZombieCount() == 0) {
    message = "HUMANS";
  }
  return message;
}

int liveZombieCount () {
  int c = 0;
  for (int i = 0; i < numZombies; i++) {
    if (zombies[i].dead == false) {
      c++;
    }
  }
  return c;
}

int liveHumanCount () {
  int c = 0;
  for (int i = 0; i < numHumans; i++) {
    if (humans[i].dead == false) {
      c++;
    }
  }
  return c;
}

