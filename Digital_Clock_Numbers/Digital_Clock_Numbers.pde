void setup () {
  
/* These functions draw digital clock numbers that are 30x55 pixels
   with a border of 10 pixels on each side, 20 on top and 15 on bottom.
   Call the function with "drawOne" or "drawZero" (for example) and an 
   x-y origin. The origin is the upper left corner of the top left borders.
*/

// Delete or comment the rest of this setup to cancel demo
 size (410,90);
 background (0);
 stroke (25,175,250);
int startX = 0; 
 int startY = 0;
 drawZero (startX, startY);
 startX=startX+40;
drawOne(startX, startY);
 startX=startX+40;
drawTwo(startX, startY);
 startX=startX+40;
drawThree(startX, startY);
 startX=startX+40;
drawFour(startX, startY);
 startX=startX+40;
drawFive(startX, startY);
 startX=startX+40;
drawSix(startX, startY);
 startX=startX+40;
drawSeven(startX, startY);
 startX=startX+40;
drawEight(startX, startY);
 startX=startX+40;
drawNine(startX, startY);
 startX=startX+40;
}

void drawZero (int x, int y) {
drawTopMiddle(x, y);
drawBottomMiddle (x, y);
drawTopLeft(x, y);
drawTopRight(x, y);
drawBottomLeft(x, y);
drawBottomRight(x, y);
}

void drawOne (int x, int y) {
drawTopRight(x, y);
drawBottomRight(x, y);
}

void drawTwo (int x, int y) {
drawTopMiddle(x, y);
drawMiddle (x, y);
drawBottomMiddle (x, y);
drawTopRight(x, y);
drawBottomLeft(x, y);
}

void drawThree (int x, int y) {
drawTopMiddle(x, y);
drawMiddle (x, y);
drawBottomMiddle (x, y);
drawTopRight(x, y);
drawBottomRight(x, y);
}

void drawFour (int x, int y) {
drawMiddle (x, y);
drawTopLeft(x, y);
drawTopRight(x, y);
drawBottomRight(x, y);
}

void drawFive (int x, int y) {
drawTopMiddle(x, y);
drawMiddle (x, y);
drawBottomMiddle (x, y);
drawTopLeft(x, y);
drawBottomRight(x, y);
}

void drawSix (int x, int y) {
drawTopMiddle(x, y);
drawMiddle (x, y);
drawBottomMiddle (x, y);
drawTopLeft(x, y);
drawBottomLeft(x, y);
drawBottomRight(x, y);
}

void drawSeven (int x, int y) {
drawTopMiddle(x, y);
drawTopRight(x, y);
drawBottomRight(x, y);
}

void drawEight (int x, int y) {
drawTopMiddle(x, y);
drawMiddle (x, y);
drawBottomMiddle (x, y);
drawTopLeft(x, y);
drawTopRight(x, y);
drawBottomLeft(x, y);
drawBottomRight(x, y);
}

void drawNine (int x, int y) {
drawTopMiddle(x, y);
drawMiddle (x, y);
drawBottomMiddle (x, y);
drawTopLeft(x, y);
drawTopRight(x, y);
drawBottomRight(x, y);
}

void drawTopMiddle(int x, int y) {
 line (x+19,y+20, x+30,y+20); 
  line (x+17,y+21, x+32,y+21); 
 line (x+15,y+22, x+34,y+22);
 line (x+17,y+23, x+32,y+23); 
 line (x+19,y+24, x+30,y+24); 
}

void drawMiddle(int x, int y) {
 line (x+19,y+45, x+30,y+45); 
  line (x+17,y+46, x+32,y+46); 
 line (x+15,y+47, x+34,y+47);
 line (x+17,y+48, x+32,y+48); 
 line (x+19,y+49, x+30,y+49); 
}
void drawBottomMiddle(int x, int y) {
 line (x+19,y+70, x+30,y+70); 
  line (x+17,y+71, x+32,y+71); 
 line (x+15,y+72, x+34,y+72);
 line (x+17,y+73, x+32,y+73); 
 line (x+19,y+74, x+30,y+74); 
}

void drawTopLeft(int x, int y) {
 line (x+10,y+29, x+10,y+40); 
 line (x+11,y+27, x+11,y+42); 
 line (x+12,y+25, x+12,y+44); 
 line (x+13,y+27, x+13,y+42); 
 line (x+14,y+29, x+14,y+40); 
}
void drawTopRight(int x, int y) {
 line (x+35,y+29, x+35,y+40); 
 line (x+36,y+27, x+36,y+42); 
 line (x+37,y+25, x+37,y+44); 
 line (x+38,y+27, x+38,y+42); 
 line (x+39,y+29, x+39,y+40); 
}
void drawBottomLeft(int x, int y) {
 line (x+10,y+54, x+10,y+65); 
 line (x+11,y+52, x+11,y+67); 
 line (x+12,y+50, x+12,y+69); 
 line (x+13,y+52, x+13,y+67); 
 line (x+14,y+54, x+14,y+65); 
}
void drawBottomRight(int x, int y) {
 line (x+35,y+54, x+35,y+65); 
 line (x+36,y+52, x+36,y+67); 
 line (x+37,y+50, x+37,y+69); 
 line (x+38,y+52, x+38,y+67); 
 line (x+39,y+54, x+39,y+65); 
}

