class Fire {
  float x;
  float y;
  float r;

  Fire () {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  Fire (float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  void display () {
    stroke(120, 75, 30);
    strokeWeight(4);
    line(x-r, y+r/2, x+r, y+r);
    line(x-r, y+r, x, y+r/2);
    line(x-r, y, x+r*2, y+r);
    strokeWeight (1);
    stroke(255, 175, 25);
    fill(255, 175, 25);
    for (int i = 0; i < 5; i++) {
      float xlocalizer = (((r/4)*i)-r/2);
      beginShape ();
      vertex (x+xlocalizer, y+13);
      vertex (x+int(random(0, 3))+xlocalizer, y+13-r );
      vertex (x+int(random(0, 3)+3)+xlocalizer, y+13-int(random(0, 3)));
      vertex (x+int(random(0, 3)+6)+xlocalizer, y+13-r+int(random(0, 7)));
      vertex (x+(r/3)+xlocalizer, y+13);
      endShape (CLOSE);
    }
  }
}

