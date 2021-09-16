/* This class defines digital clock numbers that are 30x55 pixels
 with a border of 10 pixels on each side, 20 on top and 15 on bottom.
 */
class digit { 
  boolean top, topLeft, topRight, middle, bottomLeft, bottomRight, bottom;
  color noLightColor, lightColor; 
  float upperCornerX, upperCornerY;
  int value;

  digit () {
    noLightColor=color(45);
    lightColor=color(25, 175, 250);
    top=false;
    topLeft=false; 
    topRight=false;
    middle=false;
    bottomLeft=false;
    bottomRight=false;
    bottom=false;
  }

  void drawHorizontalElement(int x1, int y1, int x2, int y2) {
    line (upperCornerX+x1, upperCornerY+y1, upperCornerX+x2, upperCornerY+y2); 
    line (upperCornerX+x1-2, upperCornerY+y1+1, upperCornerX+x2+2, upperCornerY+y2+1); 
    line (upperCornerX+x1-4, upperCornerY+y1+2, upperCornerX+x2+4, upperCornerY+y2+2);
    line (upperCornerX+x1-2, upperCornerY+y1+3, upperCornerX+x2+2, upperCornerY+y2+3); 
    line (upperCornerX+x1, upperCornerY+y1+4, upperCornerX+x2, upperCornerY+y2+4);
  }

  void drawVerticalElement(int x1, int y1, int x2, int y2) {
    line (upperCornerX+x1, upperCornerY+y1, upperCornerX+x2, upperCornerY+y2); 
    line (upperCornerX+x1+1, upperCornerY+y1-2, upperCornerX+x2+1, upperCornerY+y2+2); 
    line (upperCornerX+x1+2, upperCornerY+y1-4, upperCornerX+x2+2, upperCornerY+y2+4); 
    line (upperCornerX+x1+3, upperCornerY+y1-2, upperCornerX+x2+3, upperCornerY+y2+2); 
    line (upperCornerX+x1+4, upperCornerY+y1, upperCornerX+x2+4, upperCornerY+y2);
  }

  void display (int which, float px, float py) {
    // This part defines the behaviors
    upperCornerX=px;
    upperCornerY=py;
    value=which;
    stroke (lightColor);  
    switch (value) {
    case 0: 
      {
        top = true;
        topLeft=true; 
        topRight=true;
        middle=false;
        bottomLeft=true;
        bottomRight=true;
        bottom=true;
        break;
      }
    case 1:
      {
        top = false;
        topLeft=false; 
        topRight=true;
        middle=false;
        bottomLeft=false;
        bottomRight=true;
        bottom=false;    
        break;
      }
    case 2:
      {
        top = true;
        topLeft=false; 
        topRight=true;
        middle=true;
        bottomLeft=true;
        bottomRight=false;
        bottom=true;    
        break;
      }
    case 3:
      {
        top = true;
        topLeft=false; 
        topRight=true;
        middle=true;
        bottomLeft=false;
        bottomRight=true;
        bottom=true;    
        break;
      }
    case 4:
      {
        top = false;
        topLeft=true; 
        topRight=true;
        middle=true;
        bottomLeft=false;
        bottomRight=true;
        bottom=false;    
        break;
      }
    case 5:
      {
        top = true;
        topLeft=true; 
        topRight=false;
        middle=true;
        bottomLeft=false;
        bottomRight=true;
        bottom=true;    
        break;
      }
    case 6: 
      {
        top = true;
        topLeft=true; 
        topRight=false;
        middle=true;
        bottomLeft=true;
        bottomRight=true;
        bottom=true;    
        break;
      }
    case 7:
      {
        top = true;
        topLeft=false; 
        topRight=true;
        middle=false;
        bottomLeft=false;
        bottomRight=true;
        bottom=false;    
        break;
      }
    case 8:
      {
        top = true;
        topLeft=true; 
        topRight=true;
        middle=true;
        bottomLeft=true;
        bottomRight=true;
        bottom=true;    
        break;
      }
    case 9:
      {
        top = true;
        topLeft=true; 
        topRight=true;
        middle=true;
        bottomLeft=false;
        bottomRight=true;
        bottom=true;    
        break;
      }
    case 10: //case 10 means an unlit digit
      {
        top = false;
        topLeft=false; 
        topRight=false;
        middle=false;
        bottomLeft=false;
        bottomRight=false;
        bottom=false;    
        break;
      }
    }
    if (top==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawHorizontalElement(19, 20, 30, 20);
    if (topLeft==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawVerticalElement(10, 29, 10, 40);
    if (topRight==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawVerticalElement(35, 29, 35, 40);
    if (middle==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawHorizontalElement(19, 45, 30, 45);
    if (bottomLeft==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawVerticalElement(10, 54, 10, 65);
    if (bottomRight==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawVerticalElement(35, 54, 35, 65);
    if (bottom==true) {
      stroke(lightColor);
    } else {
      stroke(noLightColor);
    }
    drawHorizontalElement(19, 70, 30, 70);
  }
}

