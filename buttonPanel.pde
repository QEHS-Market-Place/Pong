Button menuButton, restartButton;
//
void buttonPanelSetup() {
  menuButton = new Button(appWidth*2/10, appHeight*8/9, appWidth/7, appHeight/14, borderThickness, color(#000000), color(#ffffff), 255, 255, "MENU");
  restartButton = new Button(appWidth*5/10, appHeight*8/9, appWidth/7, appHeight/14, borderThickness, color(#000000), color(#ffffff), 255, 255, "RESTART");
  quitButton = new Button(appWidth*8/10, appHeight*8/9, appWidth/7, appHeight/14, borderThickness, color(#000000), color(#ffffff), 255, 255, "QUIT");
}//End buttonPanelSetup
//
void buttonPanelDraw() {
  noStroke();
  fill(#000000);
  rectMode(CORNER);
  rect(0, gameY + gameHeight + borderThickness, appWidth, appHeight);
  rectMode(CENTER);
  stroke(#ffffff);
  strokeWeight(borderThickness);
  line(0, gameY + gameHeight + borderThickness/2, appWidth, gameY + gameHeight + borderThickness/2);
  menuButton.draw();
  restartButton.draw();
  quitButton.draw();
  menuButton.move();
  restartButton.move();
  quitButton.move();
}//End buttonPanelDraw
//
void buttonPanelMousePressed() {
  menuButton.mousePressed();
  restartButton.mousePressed();
  quitButton.mousePressed();
}//End buttonPanelMousePressed

void buttonPanelMouseReleased() {
  if (menuButton.buttonHeld == true) {
    playSound(buttonPress);
    mainMenuSetup();
    currentScene = 0;
  }
  //
  if (restartButton.buttonHeld == true) {
    playSound(buttonPress);
    buttonPanelSetup();
    gameSetup();
  }
  //
  if (quitButton.buttonHeld == true) {
    playSound(buttonPress);
    exit();
  }
  //
  menuButton.mouseReleased();
  restartButton.mouseReleased();
  quitButton.mouseReleased();
}//End buttonPanelMouseReleased
