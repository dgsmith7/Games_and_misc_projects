import java.lang.Runtime;
import java.io.*;

//int state = 2; // 0 - turn on the monitor  1 - turn off the monitor  2 - don't worry about the monitor
//Process p;

void setup() {
  size (250, 250);
}

void draw() {
  background(125);
//draw stuff
}

void shutDownMonitor() {
  String commandToRun = "pmset displaysleepnow";
  execBashCmd(commandToRun);
  println("Sending the command: " + commandToRun);
}

void keyPressed() {
  if ((key == 's') || (key == 'S')) {
    shutDownMonitor();
  }
}

void execBashCmd (String commandToRun) {
  String returnedValues;                                                                   
  try {

    Process p = Runtime.getRuntime().exec(commandToRun, null, null);
    int i = p.waitFor();
    if (i == 0) {
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
      while ( (returnedValues = stdInput.readLine ()) != null) {
        println(returnedValues);
      }
    }
    else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
      while ( (returnedValues = stdErr.readLine ()) != null) {
        println(returnedValues);
      }
    }
  }
  catch (Exception e) {
    println("Error running command!");  
    println(e);
  }
  println("\n---------------------------------------------");
  println("DONE!");
  exit();

}