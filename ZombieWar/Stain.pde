class Stain {
float x;
float y;
color c;
int i;

Stain () {
}

Stain (float x, float y, color c, int i) {
this.x = x;
this.y = y+17;
this.c = c;
this.i = i;
}

void display () {
stroke(c);
fill(c);
if (i == 0) {
line(x-3, y, x+5, y);
line(x-4, y+1, x+6, y+1);
line(x-7, y+2, x+8, y+2);
line(x-7, y+3, x+8, y+3);
line(x-3, y+4, x+7, y+4);
line(x, y+5, x+5, y+5);
ellipse(x+15, y, 5,5);
ellipse(x-10, y-3, 4,3);
ellipse(x+12, y+8, 6,5);
ellipse(x+15, y+10, 3,3);
}
if (i == 1) {
line(x-3, y, x+5, y);
line(x-5, y+2, x+6, y+1);
line(x-6, y+2, x+7, y+2);
line(x-9, y+3, x+9, y+3);
line(x-3, y+4, x+7, y+4);
line(x+1, y+5, x+6, y+5);
ellipse(x+12, y-4, 7,3);
ellipse(x-10, y-2, 4,3);
ellipse(x+15, y+8, 5,5);
ellipse(x+15, y-10, 3,3);
}
if (i == 2) {
line(x-5, y, x+5, y);
line(x-8, y+1, x+5, y+1);
line(x-9, y+2, x+8, y+2);
line(x-7, y+3, x+9, y+3);
line(x-3, y+4, x+5, y+4);
line(x, y+5, x+5, y+5);
ellipse(x+11, y, 8,3);
ellipse(x-5, y-3, 5,5);
ellipse(x+13, y+8, 3,3);
ellipse(x+9, y+10, 4,5);
}
}

}
