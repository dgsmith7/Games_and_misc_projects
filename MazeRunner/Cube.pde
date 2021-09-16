class Cube {
  float x, y, z;

  Cube () {
    init ();
  }

  float getX () {
    return x;
  }

  void setX (float x) {
    this.x = x;
  }

  float getY () {
    return y;
  }

  void setY (float y) {
    this.y = y;
  }

  float getZ () {
    return z;
  }

  void setZ (float z) {
    this.z = z;
  }

  void init () {
    x = 100;
    y = 100;
    z = -100;
  }

  void display () {
//    noStroke();
    stroke(0);
//        fill(255);
    fill(125,0,0,50);
//    noFill ();
    beginShape ();    // front wall
    vertex (x, y, z);
    vertex (x+500, y, z);
    vertex (x+500, y+500, z);
    vertex (x+350, y+500, z);
    vertex (x+350, y+150, z);
    quadraticVertex (x+350, y+50, z, x+250, y+50, z);
    quadraticVertex (x+150, y+50, z, x+150, y+150, z);
    vertex (x+150, y+150, z);
    vertex (x+150, y+500, z);
    vertex (x, y+500, z);
    vertex (x, y, z);
    endShape ();

    beginShape ();    // left wall
    vertex (x, y, z);
    vertex (x, y, z-500);
    vertex (x, y+500, z-500);
    vertex (x, y+500, z-350);
    vertex (x, y+150, z-350);
    quadraticVertex (x, y+50, z-350, x, y+50, z-250);
    quadraticVertex (x, y+50, z-150, x, y+150, z-150);
    vertex (x, y+150, z-150);
    vertex (x, y+500, z-150);
    vertex (x, y+500, z);
    vertex (x, y, z);
    endShape ();

    beginShape ();    // back wall
    vertex (x, y, z-500);
    vertex (x+500, y, z-500);
    vertex (x+500, y+500, z-500);
    vertex (x+350, y+500, z-500);
    vertex (x+350, y+150, z-500);
    quadraticVertex(x+350, y+50, z-500, x+250, y+50, z-500);
    quadraticVertex(x+150, y+50, z-500, x+150, y+150, z-500);
    vertex (x+150, y+150, z-500);
    vertex (x+150, y+500, z-500);
    vertex (x, y+500, z-500);
    vertex (x, y, z-500);
    endShape ();

    beginShape ();  // right wall
    vertex (x+500, y, z-500);
    vertex (x+500, y+500, z-500);
    vertex (x+500, y+500, z-350);
    vertex (x+500, y+150, z-350);
    quadraticVertex (x+500, y+50, z-350, x+500, y+50, z-250);
    quadraticVertex (x+500, y+50, z-150, x+500, y+150, z-150);
    vertex (x+500, y+150, z-150);
    vertex (x+500, y+500, z-150);
    vertex (x+500, y+500, z);
    vertex (x+500, y, z);
    vertex (x+500, y, z-500);
    endShape ();

    beginShape (); // top panel
    vertex (x, y, z);
    vertex (x, y, z-500);
    vertex (x+500, y, z-500);
    vertex (x+500, y, z);
    vertex (x, y, z);
    endShape ();
    
    beginShape (); // floor panel
    vertex (x, y+500, z);
    vertex (x, y+500, z-500);
    vertex (x+500, y+500, z-500);
    vertex (x+500, y+500, z);
    vertex (x, y+500, z);
    endShape ();
    

    beginShape ();  // left front floor panel and walls
    vertex (x, y+500, z);
    vertex (x, y+500, z-150);
    vertex (x+150, y+500, z-150);
    vertex (x+150, y+500, z);
    vertex (x, y+500, z);
    endShape();
    beginShape();
    vertex(x, y+500, z-150);
    vertex(x+150, y+500, z-150);
    vertex(x+150, y+150, z-150); //interior top corner
    vertex(x, y+150, z-150);
    vertex(x, y+500, z-150);
    endShape();    
    beginShape();
    vertex(x+150, y+500, z);
    vertex(x+150, y+500, z-150);
    vertex(x+150, y+150, z-150);
    vertex(x+150, y+150, z);
    vertex(x+150, y+500, z);
    endShape();

    beginShape (); // left rear floor panel and walls
    vertex(x, y+500, z-350);
    vertex (x, y+500, z-500);
    vertex (x+150, y+500, z-500);
    vertex (x+150, y+500, z-350);
    vertex (x, y+500, z-350);
    endShape();
    beginShape();
    vertex(x, y+500, z-350);
    vertex(x+150, y+500, z-350);
    vertex(x+150, y+150, z-350); //interior top corner
    vertex(x, y+150, z-350);
    vertex(x, y+500, z-350);
    endShape();
    beginShape();
    vertex(x+150, y+500, z-350);
    vertex(x+150, y+500, z-500);
    vertex(x+150, y+150, z-500);
    vertex(x+150, y+150, z-350);
    vertex(x+150, y+500, z-350);
    endShape();

    beginShape (); // right rear floor panel and interior walls
    vertex(x+350, y+500, z-350);
    vertex (x+350, y+500, z-500);
    vertex (x+500, y+500, z-500);
    vertex (x+500, y+500, z-350);
    vertex(x+350, y+500, z-350);
    endShape();
    beginShape();
    vertex(x+350, y+500, z-350);
    vertex(x+500, y+500, z-350);
    vertex(x+500, y+150, z-350); //interior top corner
    vertex(x+350, y+150, z-350);
    vertex(x+350, y+500, z-350);
    endShape();
    beginShape();
    vertex(x+350, y+500, z-350);
    vertex(x+350, y+500, z-500);
    vertex(x+350, y+150, z-500);
    vertex(x+350, y+150, z-350);
    vertex(x+350, y+500, z-350);
    endShape();

    beginShape (); // right front floor panel and interior walls
    vertex(x+350, y+500, z);
    vertex (x+350, y+500, z-150);
    vertex (x+500, y+500, z-150);
    vertex (x+500, y+500, z);
    vertex(x+350, y+500, z);
    endShape();
    beginShape();
    vertex(x+350, y+500, z-150);
    vertex(x+500, y+500, z-150);
    vertex(x+500, y+150, z-150); //interior top corner
    vertex(x+350, y+150, z-150);
    vertex(x+350, y+500, z-150);
    endShape();
    beginShape();
    vertex(x+350, y+500, z);
    vertex(x+350, y+500, z-150);
    vertex(x+350, y+150, z-150);
    vertex(x+350, y+150, z);
    vertex(x+350, y+500, z);
    endShape();

    beginShape (); // left arch front interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+150, y+50, z-150, x+150, y+150, z-150);
    vertex (x, y+150, z-150);
    quadraticVertex (x, y+50, z-150, x, y+50, z-250);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // left arch back interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+150, y+50, z-350, x+150, y+150, z-350);
    vertex (x, y+150, z-350);
    quadraticVertex (x, y+50, z-350, x, y+50, z-250);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // back arch left interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+150, y+50, z-350, x+150, y+150, z-350);
    vertex (x+150, y+150, z-500);
    quadraticVertex (x+150, y+50, z-500, x+250, y+50, z-500);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // back arch right interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+350, y+50, z-350, x+350, y+150, z-350);
    vertex (x+350, y+150, z-500);
    quadraticVertex (x+350, y+50, z-500, x+250, y+50, z-500);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // right arch back interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+350, y+50, z-350, x+350, y+150, z-350);
    vertex (x+500, y+150, z-350);
    quadraticVertex (x+500, y+50, z-350, x+500, y+50, z-250);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // right arch front interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+350, y+50, z-150, x+350, y+150, z-150);
    vertex (x+500, y+150, z-150);
    quadraticVertex (x+500, y+50, z-150, x+500, y+50, z-250);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // front arch right interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+350, y+50, z-150, x+350, y+150, z-150);
    vertex (x+350, y+150, z);
    quadraticVertex (x+350, y+50, z, x+250, y+50, z);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape ();

    beginShape (); // front arch left interior ceiling
    vertex (x+250, y+50, z-250);  //  APEX
    quadraticVertex(x+150, y+50, z-150, x+150, y+150, z-150);
    vertex (x+150, y+150, z);
    quadraticVertex (x+150, y+50, z, x+250, y+50, z);
    vertex (x+250, y+50, z-250);  //  APEX
    endShape (CLOSE);



/*
beginShape ();
vertex(x+150, y+150, z-150); // lower left front
quadraticVertex(x+150, y+50, z-150, x+250, y+50, z-150); //front control to lower right front - left half
quadraticVertex(x+350, y+50, z-150, x+350, y+150, z-150); //front control to lower right front - right half
vertex(x+350, y+50, z-150); // upper right front
vertex(x+350, y+50, z-350); //upper right rear
vertex(x+350, y+150, z-350);//lower right rear
quadraticVertex(x+350, y+50, z-350, x+250, y+50, z-350); //rear control to lower left rear - right half
quadraticVertex(x+150, y+50, z-350, x+150, y+150, z-350); //rear control to lower left rear - left half
vertex(x+150, y+50, z-350); //upper left rear
vertex(x+150, y+50, z-150); // upper left front
vertex(x+150, y+150, z-150); // lower left front
vertex(x+150, y+50, z-150); // upper left front
vertex(x+350, y+50, z-150); // upper right front
vertex(x+350, y+150, z-150);//lower right front
quadraticVertex(x+350, y+50, z-150, x+350, y+50, z-250); //right control to lower right rear - front half
quadraticVertex(x+350, y+50, z-350, x+350, y+150, z-350); //right control to lower right rear - rear halk
vertex(x+350, y+50, z-350);//upper right rear
vertex(x+150, y+50, z-350); //upper left rear
vertex(x+150, y+150, z-350);//lower left rear
quadraticVertex(x+150, y+50, z-350,x+150, y+50, z-250); // left control to lower left front - rear half
quadraticVertex(x+150, y+50, z-150,x+150, y+150, z-150); // left control to lower left front - front half
quadraticVertex(x+150, y+50, z-150,x+250, y+50, z-250); // apex control to lower right rear
quadraticVertex(x+350, y+50, z-350,x+350, y+150, z-350); // apex control to lower right rear
quadraticVertex(x+350, y+50, z-350, x+250, y+50, z-350); //rear control to lower left rear - right half
quadraticVertex(x+150, y+50, z-350, x+150, y+150, z-350); //rear control to lower left rear - left half
quadraticVertex(x+150, y+50, z-350,x+250, y+50, z-250); // apex control to lower right front
quadraticVertex(x+350, y+50, z-150,x+350, y+150, z-150); // apex control to lower right front
endShape();
*/
  }
}

