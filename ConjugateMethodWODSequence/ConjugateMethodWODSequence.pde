PrintWriter output;

String[] majorUB = {"Bench Press", "Shoulder Press", "Weighted Pull-up"};
String[] majorLB = {"Back Squat", "Deadlift", "Power Clean"};

String[] minorUB = {"Close-grip Bench Press", "Weighted Dip", "Push-jerk", "Push-press"};
boolean[] minorUBFlags = {false, false, false, false};
String[] minorLB = {"Front Squat", "Overhead Squat", "Sumo Deadlift High-pull", "Close-grip Deadlift"};
boolean[] minorLBFlags = {false, false, false, false};

String[] dayOneRow = {"4 x 4 minutes row w/ 2-4 minute rest inbetween",
                      "4 x 5 minutes row w/ 3 minute rest inbetween",
                      "3 x 1500m row with 3-5 minute rest inbetween",
                      "2 x 2k row w/ 4-6 minute rest inbetween"};
Boolean[] dayOneFlags = {false, false, false, false};
String[] dayTwoRow = {"10 x 1:40 hard row then 0:20 easy row",
                      "10 x 1:00 hard row then 0:30 easy row",
                      "10 x 20 strokes hard then 5 easy",
                      "Tabatta 8 times: 0:20 hard then 0:10 easy"};
Boolean[] dayTwoFlags = {false, false, false, false};
String[] dayThreeRow = {"30 minutes row at steady pace",
                        "Row 5k",
                        "20 minute row / 5 minute rest / 20 minute row",
                        "Row 10k"};
Boolean[] dayThreeFlags = {false, false, false, false};
String[] dayFourRow = {"Row 5k with 20 hard strokes on each 1k",
                       "5-8 x 3 minutes at 22-24spm, 2 minutes 25-27spm, 1 minute 28-30spm",
                       "Row 5k w/ 10 hard strokes on 500m",
                       "Row 32-40 minutes alternating 3 minutes conversational w/ 1 minute hard"};
Boolean[] dayFourFlags = {false, false, false, false};

int dayCounter = 0;
int weekCounter = 0;
int liftCounter = 0;
int whichUB = int(floor(random(4)));
int whichLB = int(floor(random(4)));
int whichRow1 = int(floor(random(4)));
int whichRow2 = int(floor(random(4)));
int whichRow3 = int(floor(random(4)));
int whichRow4 = int(floor(random(4)));

void setup() {
  noLoop();
  output = createWriter("ConjugateWODS.txt"); 
}

void draw() {
  while (liftCounter < 4) {
    while (minorUBFlags[whichUB] == true) {
      whichUB = int(floor(random(4)));
    }
//    output.print ("whichUB = " + whichUB + "     ");
    minorUBFlags[whichUB] = true;
    while (minorLBFlags[whichLB] == true) {
      whichLB = int(floor(random(4)));
    }
//    output.println("whichLB = " + whichLB);
    minorLBFlags[whichLB] = true;

    while (weekCounter < 3) {
      output.println("L I F T    " + (liftCounter+1) +"           W E E K    " + (weekCounter+1));
      output.println("Tuesday - Dynamic Upper Body");
      makeWarmup();
      makeUBDynamic();
      makeRowingPiece();
      makeCooldown();
      output.println("Thursday - Dynamic Lower Body");
      makeWarmup();
      makeLBDynamic();
      makeRowingPiece();
      makeCooldown();
      output.println("Friday - Max Effort Upper Body");
      makeWarmup();
      makeUBMaxEffort();
      makeRowingPiece();
      makeCooldown();
      output.println("Sunday - Max Effort Lower Body");
      makeWarmup();
      makeLBMaxEffort();
      makeRowingPiece();
      makeCooldown();
      weekCounter ++;
    }
    weekCounter = 0;
    makeTrialsWeek();
    liftCounter++;
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}

void makeWarmup() {
  output.println("   Warmup - Roll out and stretch sore areas then do up to 3 sets of 10 reps of each:");
  output.println("      Stretches, Side-strattle-hop, push-ups, pull-ups,");
  output.println("      Sit-ups, dips, GHD sit-ups, GHD back-extenions");
}

void makeUBDynamic() { // QC checked
  if ((minorUB[whichUB] == "Push-jerk") || (minorUB[whichUB] == "Push-press")) {
    output.println("   " + minorUB[whichUB] +" - 12 sets of 2 at "+(75 + ((weekCounter%3) * 5))+"% of 1-rep Max");
  } else {
    output.println("   " + minorUB[whichUB] +" - 12 sets of 2 at "+(75 + ((weekCounter%3) * 5))+"% of 1-rep Max");
    for (int i = 0; i < majorUB.length; i ++) {
      output.println("   " + majorUB[i] + " - 2-4 sets of 12-20 at 50% of 1-rep Max");
    }
  }
}

void makeLBDynamic() {
  if ((minorLB[whichLB] == "Power-clean") || (minorLB[whichLB] == "Power-snatch")) {
    output.println("   " + minorLB[whichLB] +" - 12 sets of 2 at "+(75 + ((weekCounter%3) * 5))+"% of 1-rep Max");
  } else {
    output.println("   " + minorLB[whichLB] +" - 12 sets of 2 at "+(75 + ((weekCounter%3) * 5))+"% of 1-rep Max");
    for (int i = 0; i < majorLB.length; i ++) {
      output.println("   " + majorLB[i] + " - 2-4 sets of 12-20 at 50% of 1-rep Max");
    }
  }
}

void makeUBMaxEffort() {
  if ((minorUB[whichUB] == "Push-jerk") || (minorUB[whichUB] == "Push-press")) {
    output.println("   " + minorUB[whichUB] +" - Build from empty bar up to 1-rep Max");
  } else {
    output.println("   " + minorUB[whichUB] +" - Build from empty bar up to 1-rep Max");
    for (int i = 0; i < majorUB.length; i ++) {
      output.println("   " + majorUB[i] + " - 2-4 sets of 5-12 at 75% of 1-rep Max");
    }
  }
}

void makeLBMaxEffort() {
  if ((minorLB[whichLB] == "Push-jerk") || (minorLB[whichLB] == "Push-press")) {
    output.println("   " + minorLB[whichLB] +" - Build from empty bar up to 1-rep Max");
  } else {
    output.println("   " + minorLB[whichLB] +" - Build from empty bar up to 1-rep Max");
    for (int i = 0; i < majorLB.length; i ++) {
      output.println("   " + majorLB[i] + " - 2-4 sets of 5-12 at 75% of 1-rep Max");
    }
  }
}

void makeRowingPiece() {
  output.print("   Row - ");
  switch(dayCounter) {
    case 0:
      output.println(dayOneRow[whichRow1]);
      break;
    case 1:
      output.println(dayTwoRow[whichRow2]);
      break;
    case 2:
      output.println(dayThreeRow[whichRow3]);
      break;
    case 3:
      output.println(dayFourRow[whichRow4]);
      break;
  };
        while (dayOneFlags[whichRow1] == true) {
          whichRow1 = int(floor(random(4)));
        }
        dayOneFlags[whichRow1] =true;
        while (dayTwoFlags[whichRow2] == true) {
          whichRow2 = int(floor(random(4)));
        }
        dayTwoFlags[whichRow2] =true;
        while (dayThreeFlags[whichRow3] == true) {
          whichRow3 = int(floor(random(4)));
        }
        dayThreeFlags[whichRow3] =true;
        while (dayFourFlags[whichRow4] == true) {
          whichRow4 = int(floor(random(4)));
        }
        dayFourFlags[whichRow4] =true;
  dayCounter++;
  if (dayCounter > 3) {
    dayCounter = 0;
    for (int i = 0; i < 4; i++) {
      dayOneFlags[i] = false;
      dayTwoFlags[i] = false;
      dayThreeFlags[i] = false;
      dayFourFlags[i] = false;
    }
  }
}

void makeCooldown() {
  output.println("   Cooldown - Stretch and roll soreness and tightness as needed");
  output.println();
}

void makeTrialsWeek() {
  output.println("T R I A L S     W E E K");
  output.println("Tuesday - CrossFit Total + 1");
  makeWarmup();
  output.println("   Start with empty bar and work up to 1 rep-max for these lifts:");
  output.println("      Back Squat   -   Shoulder Press   -   Deadlift   -   Bench Press");
  makeCooldown();
  output.println("Thursday - Big Cardio");
  makeWarmup();
  output.println("   Walk, row, or run further than 10k or more than one hour");
  makeCooldown();
  output.println("Friday - Rest - Weigh in for record");
  output.println("Sunday - Rest");
  output.println();
}
