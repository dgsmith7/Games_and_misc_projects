String[] testSet = {"00000101", "11111111", "10101010"};

void setup() {
  noLoop();
}

void draw() {
  for (int i = 0; i < testSet.length; i ++) {
    print("Binary: " + testSet[i]);
    println("   converts to decimal: " + convertBinToDec(testSet[i]));
  }
}

int convertBinToDec(String b) {
  int d = 0;
  for (int i = 0; i < 8; i++) {
    if (b.charAt(i) == '1') {
      d = d + int(pow(2, 7 - i));
    }
  }
  return d;
}
