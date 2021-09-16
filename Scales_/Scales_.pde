String[] notes = {"C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"};
String[] names = {"Ionian", "Dorian", "Phyrgian", "Lydian", "Mixolydian","Aeolian (Natural Minor)", "Hypophyrgian"};
String currentOrder = "WWHWWWH";
for (int scaleIndex = 0; scaleIndex < names.length; scaleIndex ++) {
  println(names[scaleIndex] + "   " + currentOrder);
  for (int noteIndex = 0; noteIndex < notes.length; noteIndex ++) {
    println("Starting with " + notes[0] +":");
    print("     ");
    print(notes[0] + " ");
    int position = 0;
    for (int stepIndex = 0; stepIndex < currentOrder.length(); stepIndex++) {
      if (currentOrder.charAt(stepIndex) == 'W') {
        position = position + 2;
      } else {
        position = position + 1;
      }
      if (position > 11) {
        position = position - 12;
      }
      print(notes[position] + " ");
    }
    println();
    String tempN = notes[0];
    notes = subset(notes, 1);
    notes = append(notes, tempN);
  }
  println();
  char tempS = currentOrder.charAt(0);
  currentOrder = currentOrder.substring(1) + tempS;
}