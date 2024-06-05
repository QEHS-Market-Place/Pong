String gameName = "SLINGSHOT PONG";//Name of the game.
//
Button startButton, quitButton;
RadiantParticleCirc[] titleGlow = new RadiantParticleCirc[100];
//
int currentParticleReset = 0;
//
void mainMenuSetup() {
  startButton = new Button(appWidth*1/2, appHeight*1/2, appWidth/5, appHeight/7, borderThickness, color(#000000), color(#ffffff), 200, 255, "START");
  quitButton = new Button(appWidth*1/2, appHeight*5/6, appWidth/5, appHeight/7, borderThickness, color(#000000), color(#ffffff), 200, 255, "QUIT");
  //
  for (int i=0; i < titleGlow.length; i++) {
    titleGlow[i] = new RadiantParticleCirc(10000000, 100000000, appReferentMeasure/130, 0, 2, color(#ffffff));
  }
  //
  for (int i=0; i < stars.length; i++) {
    stars[i] = new Stars(random(0, appWidth), random(0, appHeight), gameReferentMeasure/random(130, 200), gameReferentMeasure/random(130, 200), color(#ffffff), 0, appWidth, 0, appHeight);
  }
}//End mainMenuSetup
//
void mainMenuDraw() {
  for (int i=0; i < stars.length; i++) {
    stars[i].move();
    stars[i].draw();
  }
  //
  titleGlow[currentParticleReset] = new RadiantParticleCirc(appWidth/2, appHeight*1/4, appReferentMeasure/30, 0, 4, color(#DBDBDB));
  //
  for (int i=0; i < titleGlow.length; i++) {
    titleGlow[i].move();
    titleGlow[i].draw();
  }
  textFont(appFont);
  textSize(appWidth/12);
  text(gameName, (appWidth/2)-(textWidth(gameName)/2), (appHeight*1/4)+(appWidth/48));
  startButton.draw();
  quitButton.draw();
  startButton.move();
  quitButton.move();
  //
  if (currentParticleReset + 1 > titleGlow.length - 1) {
    currentParticleReset = 0;
  } else {
    currentParticleReset++;
  }
}//End mainMenuSetup
//
void mainMenuMousePressed() {
  startButton.mousePressed();
  quitButton.mousePressed();
}//End mainMenuMousePressed
//
void mainMenuMouseReleased() {
  if (quitButton.buttonHeld == true) {
    playSound(buttonPress);
    exit();
  }
  //
  if (startButton.buttonHeld == true) {
    playSound(buttonPress);
    playerSelectSetup();
    currentScene = 1;
  }
  //
  startButton.mouseReleased();
  quitButton.mouseReleased();
}//End buttonPanelMouseReleased
