PlayerBox leftPlayerRect, rightPlayerRect;
Button gameModeButton;
//
int gameMode=0;//Rules for who wins the game
/*
0: First to five
1: First to ten
2: Best of three
3: Endless
*/
int leftPlayerMode, rightPlayerMode;//Modes for the ai controlling the players
/*
0: no CPU, regular gameplay & controls
1: easy: moves at random.
2: medium: moves up when below the ball, down when above the ball, charges when ball is in range, releases when ball is at x lock. (artificial reaction time might need to be included, maybe delay each movement by a few ticks)
3: hard: moves up when below the ball, down when above the ball, charges when ball is in range, releases when ball is at x lock.
*/
void playerSelectSetup() {
  startButton = new Button(appWidth*2/3, appHeight*7/8, appWidth/7, appHeight/14, borderThickness, color(#000000), color(#ffffff), 255, 255, "GO!");
  menuButton = new Button(appWidth*1/3, appHeight*7/8, appWidth/7, appHeight/14, borderThickness, color(#000000), color(#ffffff), 255, 255, "BACK");
  gameModeButton = new Button(appWidth*1/2, appHeight*3/4, appWidth/5, appHeight/14, borderThickness, color(#000000), color(#ffffff), 255, 255, "FIRST TO 5");
  //
  leftPlayerRect = new PlayerBox(appWidth*1/3, appHeight*2/5, appWidth/4, appHeight/2, borderThickness, color(#000000), color(#ffffff), 255, 255, "Player 1", 0);
  rightPlayerRect = new PlayerBox(appWidth*2/3, appHeight*2/5, appWidth/4, appHeight/2, borderThickness, color(#000000), color(#ffffff), 255, 255, "Player 2", 0);
}//End playerSelectSetup
//
void playerSelectDraw() {
  switch(gameMode) {
    case 0:
      gameModeButton.text = "1ST TO 5";
      break;
    case 1:
      gameModeButton.text = "1ST TO 10";
      break;
    case 2:
      gameModeButton.text = "BEST OF 3";
      break;
    case 3:
      gameModeButton.text = "ENDLESS";
      break;
  }
  //
  leftPlayerRect.draw();
  leftPlayerRect.move();
  rightPlayerRect.draw();
  rightPlayerRect.move();
  //
  startButton.draw();
  menuButton.draw();
  gameModeButton.draw();
  startButton.move();
  menuButton.move();
  gameModeButton.move();
}//End playerSelectSetup
//
void playerSelectMousePressed() {
  startButton.mousePressed();
  menuButton.mousePressed();
  gameModeButton.mousePressed();
  leftPlayerRect.mousePressed();
  rightPlayerRect.mousePressed();
}//End playerSelectMousePressed
//
void playerSelectMouseReleased() {
  if (startButton.buttonHeld == true) {
    playSound(buttonPress);
    buttonPanelSetup();
    gameSetup();
    currentScene = 2;
  }
  //
  if (menuButton.buttonHeld == true) {
    playSound(buttonPress);
    mainMenuSetup();
    currentScene = 0;
  }
  //
  if (gameModeButton.buttonHeld == true) {
    playSound(buttonPress);
    if (gameMode + 1 <= 3) {
      gameMode++;
    } else {
      gameMode = 0;
    }
  }
  //
  startButton.mouseReleased();
  menuButton.mouseReleased();
  gameModeButton.mouseReleased();
  leftPlayerRect.mouseReleased();
  rightPlayerRect.mouseReleased();
}//End buttonPanelMouseReleased
