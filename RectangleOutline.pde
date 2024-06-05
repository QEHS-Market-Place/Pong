abstract class RectangleOutline extends Shape {
  float t;
  float opacity, borderOpacity;
  color borderColour;
  //
  RectangleOutline (float x, float y, float w, float h, float t, color colour, color borderColour, float opacity, float borderOpacity) {
    super(x, y, w, h, colour);
    this.t = t;
    this.opacity = opacity;
    this.borderOpacity = borderOpacity;
    this.borderColour = borderColour;
  }//End RectangleOutline
  //
  void draw() {
    stroke(borderColour, borderOpacity);
    strokeWeight(t);
    fill(colour, opacity);
    rect(x,y,w,h);
  }//End draw
}//End RectangleOutline
//
class ControlHelp extends RectangleOutline {
  String text;
  //
  ControlHelp(float x, float y, float w, float h, float t, color colour, color borderColour, float opacity, float borderOpacity, String text) {
    super(x, y, w, h, t, colour, borderColour, opacity, borderOpacity);
    this.text = text;
  }//End ControlHelp
  //
  void move() {
    fill(borderColour, borderOpacity);
    noStroke();
    textFont(appFont);
    textSize(w);
    text(text.toUpperCase(), x-textWidth(text)/2, y+((w*0.75)/2));
  }//End move
}//End ControlHelp
//
class Button extends RectangleOutline {
  String text;
  Boolean mouseHover = false, buttonHeld = false;
  //
  Button(float x, float y, float w, float h, float t, color colour, color borderColour, float opacity, float borderOpacity, String text) {
    super(x, y, w, h, t, colour, borderColour, opacity, borderOpacity);
    this.text = text;
  }//End Button
  //
  void move() {
    if (mouseX >= x-w/2 && mouseX <= x+w/2 && mouseY >= y-h/2 && mouseY <= y+h/2) {//test for mouse hover
      mouseHover = true;
    } else {
      mouseHover = false;
      buttonHeld = false;
    }
    //
    stroke(borderColour);
    strokeWeight(borderThickness);
    if (mouseHover == true) {//Draw hollow outline around button when mouse is hovering over
      line(x-w/2-borderThickness*2, y-h/2-borderThickness*2, x-w/2+borderThickness*2, y-h/2-borderThickness*2);//top left
      line(x-w/2-borderThickness*2, y-h/2-borderThickness*2, x-w/2-borderThickness*2, y-h/2+borderThickness*2);
      //
      line(x+w/2+borderThickness*2, y-h/2-borderThickness*2, x+w/2-borderThickness*2, y-h/2-borderThickness*2);//top right
      line(x+w/2+borderThickness*2, y-h/2-borderThickness*2, x+w/2+borderThickness*2, y-h/2+borderThickness*2);
      //
      line(x-w/2-borderThickness*2, y+h/2+borderThickness*2, x-w/2+borderThickness*2, y+h/2+borderThickness*2);//bottom left
      line(x-w/2-borderThickness*2, y+h/2+borderThickness*2, x-w/2-borderThickness*2, y+h/2-borderThickness*2);
      //
      line(x+w/2+borderThickness*2, y+h/2+borderThickness*2, x+w/2-borderThickness*2, y+h/2+borderThickness*2);//bottom right
      line(x+w/2+borderThickness*2, y+h/2+borderThickness*2, x+w/2+borderThickness*2, y+h/2-borderThickness*2);
    }
    noStroke();
    fill(borderColour, borderOpacity);
    if (buttonHeld == true) {
      rect(x,y,w,h);
    } else {
      textFont(appFont);
      textSize(w/6);
      text(text, x-textWidth(text)/2, y+w/18);
    }
  }//End move
  //
  void mousePressed() {
    if (mouseHover == true && mouseButton == LEFT) {
      buttonHeld = true;
    } else {
      buttonHeld = false;
    }
  }//End mousePressed
  //
  void mouseReleased() {
    if (mouseButton == LEFT) {     
      buttonHeld = false;
    }
  }//End mouseReleased
}//End Button
//
class ScoreBoard extends RectangleOutline {
  String side;
  //
  ScoreBoard(float x, float y, float w, float h, float t, color colour, color borderColour, float opacity, float borderOpacity, String side) {
    super(x, y, w, h, t, colour, borderColour, opacity, borderOpacity);
    this.side = side;
  }//End ScoreBoard
  //
  void move() {
    fill(borderColour, borderOpacity);
    noStroke();
    textFont(appFont);
    textSize(w*0.75);
    if (side == "Left") {
      if (leftScore < 10) {
        text("0" + str(leftScore), x-((w)/2.2), y+((w*0.75)/2));
      } else if (leftScore > 99) {
        colour = color(#ff0000);
        text("99", x-((w)/2.2), y+((w*0.75)/2)+gameY);
      } else {
        text(str(leftScore), x-((w)/2.2), y+((w*0.75)/2));
      }
    } else if (side == "Right") {
      if (rightScore < 10) {
        text("0" + str(rightScore), x-((w)/2.2), y+((w*0.75)/2));
      } else if (rightScore > 99) {
        colour = color(#ff0000);
        text("99", x-((w)/2.2), y+((w*0.75)/2));
      } else {
        text(str(rightScore), x-((w)/2.2), y+((w*0.75)/2));
      }
    }
  }//End move
}//End ScoreBoard
//
class PlayerBox extends RectangleOutline {
  String text;
  int mode;
  //
  Button human, easy, medium, hard;
  //
  PlayerBox(float x, float y, float w, float h, float t, color colour, color borderColour, float opacity, float borderOpacity, String text, int mode) {
    super(x, y, w, h, t, colour, borderColour, opacity, borderOpacity);
    this.text = text;
    this.mode = mode;
    //
    human = new Button(x, y-(h*3/8), w*7/8, h*1/7, borderThickness/2, color(#000000), color(#ffffff), 255, 255, "Human");
    easy = new Button(x, y-(h*1/8), w*7/8, h*1/7, borderThickness/2, color(#000000), color(#ffffff), 255, 255, "CPU Easy");
    medium = new Button(x, y+(h*1/8), w*7/8, h*1/7, borderThickness/2, color(#000000), color(#ffffff), 255, 255, "CPU Medium");
    hard = new Button(x, y+(h*3/8), w*7/8, h*1/7, borderThickness/2, color(#000000), color(#ffffff), 255, 255, "CPU Hard");
  }//End PlayerBox
  //
  void move() {
    noFill();
    stroke(borderColour);
    strokeWeight(borderThickness/2);
    switch(mode) {
      case 0:
        rect(x, y-(h*3/8), w*7/8+borderThickness*2, h*1/7+borderThickness*2);
        break;
      case 1:
        rect(x, y-(h*1/8), w*7/8+borderThickness*2, h*1/7+borderThickness*2);
        break;
      case 2:
        rect(x, y+(h*1/8), w*7/8+borderThickness*2, h*1/7+borderThickness*2);
        break;
      case 3:
        rect(x, y+(h*3/8), w*7/8+borderThickness*2, h*1/7+borderThickness*2);
        break;
    }
    //
    fill(borderColour, borderOpacity);
    noStroke();
    textFont(appFont);
    textSize(w/text.length());
    text(text, x-textWidth(text)/2, y-h*5/8);
    //
    human.draw();
    easy.draw();
    medium.draw();
    hard.draw();
    human.move();
    easy.move();
    medium.move();
    hard.move();
  }//End move
  //
  void mousePressed() {
    human.mousePressed();
    easy.mousePressed();
    medium.mousePressed();
    hard.mousePressed();
  }//End mousePressed
  //
  void mouseReleased() {
    if (human.buttonHeld == true) {
      playSound(buttonPress);
      mode = 0;
    }
    //
    if (easy.buttonHeld == true) {
      playSound(buttonPress);
      mode = 1;
    }
    //
    if (medium.buttonHeld == true) {
      playSound(buttonPress);
      mode = 2;
    }
    //
    if (hard.buttonHeld == true) {
      playSound(buttonPress);
      mode = 3;
    }
    //
    human.mouseReleased();
    easy.mouseReleased();
    medium.mouseReleased();
    hard.mouseReleased();
  }//End mousePressed
}//End PlayerBox
