// map maker for raycaster FPS game engine
// add zoom in and out
// add a spawn brick
// add save to file

boolean menuUp = false;
int mapIndexX = 0; 
int mapIndexY = 0;
ArrayList<ArrayList<Tile>> map = new ArrayList<ArrayList<Tile>>();

void setup() {
  size(700, 700);
  initMap();
}

void draw() {
  background(0);
  displayMap();
  // display any messages and menu if needed
  if (menuUp) {
    displayMenu();
  } 
  textSize(20);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Y index - " + mapIndexY + "  X index - " + mapIndexX, width / 2, height * .90);
  text("Map width = "+map.get(0).size()+" Map height = "+map.size()+"  Press M for menu", width / 2, height * .95);
  // display tile focus
  //fill(255, 75);
  noFill();
  stroke(255, 0 ,0);
  rect(300, 300, 100, 100);
  stroke(0);
}

void initMap() { // completed
  for (int i = 0; i < 10; i ++) {
    ArrayList<Tile> newRow = new ArrayList<Tile>();
    for (int j = 0; j < 10; j ++) {
      newRow.add(new Tile(0));
    }
    map.add(newRow);
  }
}

void displayMap() {  
  //build view
  int yIndex = mapIndexY - 3;
  int xIndex = mapIndexX - 3;
  int view[][] = new int[6][7]; 
  int temp = 0;
  for (int y = 0; y < 6; y ++) {
    for (int x = 0; x < 7; x ++) {
      boolean yValid = (yIndex + y >= 0 && yIndex + y < map.size());
      boolean xValid = (xIndex + x >= 0 && xIndex + x < map.get(0).size());
      if (yValid && xValid) {
        temp = map.get(yIndex + y).get(xIndex + x).value;
      } else {
        temp = 99;
      }
      view[y][x] = temp;
    }
  }
  //show view
  color c = color(0, 0, 255);
  for (int y = 0; y < 6; y ++) {
    for (int x = 0; x < 7; x ++) {
        switch(view[y][x]) {
          case 0: {c = color(125); break;} // floor - grey
          case 1: {c = color(100, 150, 250); break;} // low wall - lt blue
          case 2: {c = color(50, 100, 250); break;} // med wall - darker blue
          case 3: {c = color(0, 75, 250); break;} // high wall - darkest blue
          case 4: {c = color(175, 175, 100); break;} // pit - brown
          case 5: {c = color(250, 150, 0); break;} // lava - red
          case 99: {c = color(0);} // not a valid map tile - 0
        }
    fill(c);
    rect(x*100, y*100, 100, 100);
    }
  //  println();
  }
//  println("-----------");
}

void addColToMap() { // completed
  for (int i = 0; i < map.size(); i ++) {
    map.get(i).add(new Tile(0));
  }
}

void addRowToMap() { // completed
  ArrayList<Tile> newRow = new ArrayList<Tile>();
  for (int j = 0; j < map.get(0).size(); j ++) {
    newRow.add(new Tile(0));
  }
  map.add(newRow);
}

void delColFromMap(){ // completed
  if (map.get(0).size() > 10) {
    for (int i = 0; i < map.size(); i ++) {
      map.get(i).remove(map.get(i).size()-1);
    }
  }
}

void delRowFromMap(){ // completed
  if (map.size() > 10) {
    map.remove(map.size()-1);
  }
}

void addWall(int h) {
  map.get(mapIndexY).get(mapIndexX).set(h);
}

void addPit() {
  map.get(mapIndexY).get(mapIndexX).set(4);
}

void addLava() {
  map.get(mapIndexY).get(mapIndexX).set(5);
}

void saveMap() {
  println("=================================");
  for (int i = 0; i < map.size(); i ++) {
    for (int j = 0; j < map.get(i).size(); j ++) {
      print(map.get(i).get(j).value +" ");
    }
    println();
  }
}

void displayMenu() {
  textSize(20);
  textAlign(CENTER);
  float menuX = .1 * width;
  float menuY = .1 * height;
  float menuWide = .8 * width;
  float menuHigh = .8 * height;
  fill(125, 75);
  rect(menuX, menuY, menuWide, menuHigh, 10, 10, 10, 10);
  fill(255, 175);
  text("M - Toggle Menu", menuX + .5 * menuWide, menuY + .1 * menuHigh);
  text("ARROWS - Slide Map", menuX + .5 * menuWide, menuY + .15 * menuHigh);
  text("C - Add column to right side map", menuX + .5 * menuWide, menuY + .2 * menuHigh);
  text("R - Add row to bottom of map", menuX + .5 * menuWide, menuY + .25 * menuHigh);
  text("X - Remove column from right side map", menuX + .5 * menuWide, menuY + .3 * menuHigh);
  text("E - Remove row from bottom of map", menuX + .5 * menuWide, menuY + .35 * menuHigh);
  text("1 - Add low wall", menuX + .5 * menuWide, menuY + .4 * menuHigh);
  text("2 - Add medium wall", menuX + .5 * menuWide, menuY + .45 * menuHigh);
  text("3 - Add high wall", menuX + .5 * menuWide, menuY + .5 * menuHigh);
  text("P - Add pit", menuX + .5 * menuWide, menuY + .55 * menuHigh);
  text("L - Add lava", menuX + .5 * menuWide, menuY + .6 * menuHigh);
  text("S - Save map", menuX + .5 * menuWide, menuY + .65 * menuHigh);
}

void keyPressed() {
  switch (key) {
    case 'm':
    case 'M': {menuUp = !menuUp; break;}
    case '1': {addWall(1); break;}
    case '2': {addWall(2); break;}
    case '3': {addWall(3); break;}
    case 'c':
    case 'C': {addColToMap(); break;}
    case 'r':
    case 'R': {addRowToMap(); break;}
    case 'x':
    case 'X': {delColFromMap(); break;}
    case 'e':
    case 'E': {delRowFromMap(); break;}
    case 'p':
    case 'P': {addPit(); break;}
    case 'l':
    case 'L': {addLava(); break;}
    case 's':
    case 'S': {saveMap(); break;}
  }
  switch (keyCode) {
    case DOWN: mapIndexY++; if (mapIndexY >  map.size()-1) mapIndexY = map.size()-1; break;
    case UP: mapIndexY--; if (mapIndexY < 0) mapIndexY = 0; break;
    case RIGHT: mapIndexX++; if (mapIndexX >  map.get(0).size()-1) mapIndexX = map.get(0).size()-1;  break;
    case LEFT: mapIndexX--; if (mapIndexX < 0) mapIndexX = 0; break;
  }
}
