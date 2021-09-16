
String[] questions = new String[4];
int[] spoilerPosit = new int[3];

int answerPosit = int(random(4));
println("ap is at " + char(answerPosit + 65));

for (int i = 0 ; i < 3; i ++) {
  spoilerPosit[i] = answerPosit;
}

while (spoilerPosit[0] == answerPosit) {
  spoilerPosit[0] = int(random(4));
}
println("sp0 is at " + char(spoilerPosit[0] + 65));

while ((spoilerPosit[1] == answerPosit) || (spoilerPosit[1] == spoilerPosit[0])) {
  spoilerPosit[1] = int(random(4));
}
println("sp1 is at " + char(spoilerPosit[1] + 65));


while ((spoilerPosit[2] == answerPosit) || 
       (spoilerPosit[2] == spoilerPosit[1]) || 
       (spoilerPosit[2] == spoilerPosit[0])) {
  spoilerPosit[2] = int(random(4));
}
println("sp2 is " + char(spoilerPosit[2] + 65));
println();

questions[answerPosit] = "the Answer.";
int counter = 0;
for (int i = 0; i < 4; i ++) {
  if (i != answerPosit) {
    questions[spoilerPosit[counter]] = "spoiler " + counter;
    counter++;
  }
}

for (int i = 0; i < 4; i ++) {
  println(char(i + 65) + " - " + questions[i]);
}