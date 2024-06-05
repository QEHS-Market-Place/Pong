class RectangleRounded extends Shape {
  float bevel;
  //
  RectangleRounded (float x, float y, float w, float h, float bevel, color colour) {
    super(x, y, w, h, colour);
    this.bevel = bevel;
  }//End Rectangle
  //
  void draw() {
    noStroke();
    fill(colour);
    rect(x,y,w-2*bevel,h);
    rect(x,y,w,h-2*bevel);
    circle(x-w/2+bevel, y-h/2+bevel, bevel*2);//tl
    circle(x+w/2-bevel, y-h/2+bevel, bevel*2);//tr
    circle(x-w/2+bevel, y+h/2-bevel, bevel*2);//bl
    circle(x+w/2-bevel, y+h/2-bevel, bevel*2);//br
  }//End draw
}//End Rectangle
//
class Paddle extends RectangleRounded {
  float velocityX, velocityY, xLock, maxVelocityX, maxVelocityY, maxCharge;
  char up, down, charge;
  String chargeDir;
  boolean upHeld, downHeld, chargeHeld;
  int mode;
  //
  int controlHelpOpacity = 100;
  int botReactionTime=int(random(0, 10));
  ControlHelp upHelp, downHelp, chargeHelp;
  //
  boolean readyToPlay;
  //
  Paddle(float x, float y, float w, float h, float bevel, color colour, char up, char down, char charge, String chargeDir, int mode) {
    super(x, y, w, h, bevel, colour);
    this.up = up;
    this.down = down;
    this.charge = charge;
    this.chargeDir = chargeDir;
    this.mode = mode;
    maxCharge = gameWidth/10;
    velocityX = 0;
    velocityY = 0;
    maxVelocityX = gameReferentMeasure/30;
    maxVelocityY = gameReferentMeasure/30;
    xLock = x;
    //
    upHelp = new ControlHelp(x, y, w, w, borderThickness/2, color(#000000), color(#ffffff), 0, controlHelpOpacity, str(up));
    downHelp = new ControlHelp(x, y, w, w, borderThickness/2, color(#000000), color(#ffffff), 0, controlHelpOpacity, str(down));
      if (chargeDir == "Left") {
        chargeHelp = new ControlHelp(x, y, w, w, borderThickness/2, color(#000000), color(#ffffff), 0, controlHelpOpacity, str(charge));
      } else if (chargeDir == "Right") {
        chargeHelp = new ControlHelp(x, y, w, w, borderThickness/2, color(#000000), color(#ffffff), 0, controlHelpOpacity, str(charge));
      }
    //
    if (mode == 0) {
      readyToPlay = false;
    } else {
      controlHelpOpacity = 0;
      readyToPlay = true;
    }
  }//End Paddle
  //
  void move() {
    //
    if (gameActive == true) {
      if (upHeld == false && downHeld == false) {//decelearate when not moving
        if (velocityY > 0) {
          if (velocityY > gameHeight/600) {
            velocityY-=gameHeight/600;
          } else {
            velocityY=0;
          }
        } else if (velocityY < 0) {
          if (velocityY < gameHeight/-600) {
            velocityY+=gameHeight/600;
          } else {
            velocityY=0;
          }
        }
      }
      //
      if (upHeld == true && velocityY < maxVelocityY) {//accelerated motion, rather than just sliding. Includes max velocity to prevent paddle going too fast.
        velocityY -= gameHeight/600;
      }
      //
      if (downHeld == true && abs(velocityY) < maxVelocityY) {
        velocityY += gameHeight/600;
      }
      //
      if (chargeHeld == true) {//slow down when charged.
        maxVelocityY = gameReferentMeasure/90;
        if (chargeDir == "Left") {
          if (x > maxCharge) {
            velocityX -= gameWidth/100;
          } else {
            velocityX = 0;
          }
        } else if (chargeDir == "Right") {
          if (x < gameWidth-maxCharge) {
            velocityX += gameWidth/100;
          } else {
            velocityX = 0;
          }
        }
      } else {
        maxVelocityY = gameReferentMeasure/30;
      }
    } else {
      y = balls[0].y;
    }
    //
    if ( x + w/2 >= gameWidth ) {//bounce, (shouldn't happen because the paddle shouldn't be able touch the side edges of the screen, is here anyways don't @ me)
      x = gameWidth-w/2;
      velocityX *= -1;
    } else if( x - w/2 <= 0 ) {
      x = 0+w/2;
      velocityX *= -1;
    }
    //
    if ( y + h/2 >= gameHeight ) {//bounce
      y = gameHeight-h/2;
      velocityY = (velocityY*-0.75)-1;
    } else if( y - h/2 <= 0 ) {
      y = 0+h/2;
      velocityY = (velocityY*-0.75)+1;
    }
    //
    if (abs(velocityY) > maxVelocityY) {//limiter on velocity, since bouncing may help exceed max velocity
      if (velocityY < 0) {velocityY = maxVelocityY*-1;} else {velocityY = maxVelocityY;}
    }
    //
    if (chargeHeld == false) {//When not charging, the paddle gets constantly pulled to its origin point, giving it a slingshot-y feeling
      if (x < xLock) {
        velocityX += (xLock-x)/4;
      } else if (x > xLock) {
        velocityX -= (x-xLock)/4;
      } else {
        velocityX = 0;
      }
    }
    //
    x += velocityX;
    velocityX *= 0.5;
    //
    y += velocityY;
    //
    if (readyToPlay == true && controlHelpOpacity > 0) {//Fade opacity of control instructions
    controlHelpOpacity--;
    }
    upHelp.opacity = controlHelpOpacity;
    upHelp.y = y-h;
    //
    if (y - h/2 <= 0) {//STOP GETTING CAUGHT ON THE EDGE OF THE SCREEN!!!!! GOD!!!!
      y = h/2;
    } else if (y + h/2 >= gameHeight) {
      y = gameHeight-h/2;
    }
    //
    if (controlHelpOpacity > 0) {
      upHelp.borderOpacity = controlHelpOpacity;
      upHelp.x = x;
      upHelp.y = y-h;
      upHelp.draw();
      upHelp.move();
      //
      downHelp.borderOpacity = controlHelpOpacity;
      downHelp.x = x;
      downHelp.y = y-h/1.5;
      downHelp.draw();
      downHelp.move();
      //
      if (chargeDir == "Left") {
        chargeHelp.borderOpacity = controlHelpOpacity;
        chargeHelp.x = x-w*1.5;
        chargeHelp.y = y-h/1.5;
        chargeHelp.draw();
        chargeHelp.move();
      } else if (chargeDir == "Right") {
        chargeHelp.borderOpacity = controlHelpOpacity;
        chargeHelp.x = x+w*1.5;
        chargeHelp.y = y-h/1.5;
        chargeHelp.draw();
        chargeHelp.move();
      }
    }
  }//End move
  //
  void keyPressed() {
    if (mode == 0) {
      if (readyToPlay == false && (key == up || key == down)) {
        readyToPlay = true;
      }
      //
      if (key == up) {
        upHeld = true;
      }
      //
      if (key == down) {
        downHeld = true;
      }
      //
      if (key == charge) {
        if (chargeDir == "Left" || chargeDir == "Right") {
          chargeHeld = true;
        }
      }
    }
  }//End keyPressed
  //
  void keyReleased() {
    if (mode == 0) {
      if (key == up) {
        upHeld = false;
      }
      //
      if (key == down) {
        downHeld = false;
      }
      //
      if (key == charge) {
        chargeHeld = false;
      }
    }
  }//End keyReleased
}//End Paddle
