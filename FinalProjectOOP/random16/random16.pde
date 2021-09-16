void setup () {
int rand=int(random(1,16));
boolean match = true;
int [] holder = {16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16};

printArray (holder);
println ();

for (int i=0; i<15; i++) {
  rand = int(random(1, 16));
  match = true;
  while (match == true) {
    match = false;
    for (int j=0; (j<i); j++) {
      if (holder[j] == rand) {match = true;}
    }
    if (match == true) {rand=int(random(1, 16));}
  }
  holder[i] = rand;
  println (i+" assigned "+rand);
}
  
printArray (holder); 
println("Done!");
}
