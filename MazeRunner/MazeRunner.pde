int xCubes = 5;
int zCubes = 3;
Cube c1 [][]= new Cube [xCubes][zCubes];
float camX, camZ;
int dir = 0;

void setup () {
size(700, 700, P3D);
background(150);
// read maze file
//initialize maze
for (int i = 0; i<xCubes; i++) {
 for (int j = 0 ; j < zCubes; j ++) {
   c1[i][j] = new Cube ();
   c1[i][j].setX(i*500+100);
   c1[i][j].setY(100);
   c1[i][j].setZ(-1*(j*500+100));
   c1[i][j].display();
 } 
}
//initialize cam
camX = 350; //centerStartX;
camZ = -350; //centerStartZ;
}

void draw () {
background (150);
for (int i = 0; i < xCubes; i++) {
 for (int j = 0; j < zCubes; j ++) {
   c1[i][j].display();
 } 
}
camera(camX, 350, camZ, camX, 350, camZ-10, 0,1,0);
}

void mouseClicked() {
exit ();
}

void keyPressed () {
  if (key == CODED) {
    if (keyCode == UP) {
      // if dir = 0,1,2,3
      camZ-=5;
    }
    if (keyCode == DOWN) {
      camZ+=5;
    }
    if (keyCode == LEFT) {
      // pan left
      // change dir
      camX-=5;
    }
    if (keyCode == RIGHT) {
      // pan right
      // change dir
      camX+=5;
    }
  }
//  if (key == )
}


