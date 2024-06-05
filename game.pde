int leftScore, rightScore, leftStreak, rightStreak;
int activeBalls;
int currentFirework = 0, fireworkTimer = 0;
int flickerDir = 15;
boolean gameActive;//Determines how the game acts when someone wins
String winningText;
//
Ball[] balls = new Ball[5];
Firework[] fireworks = new Firework[10];
Stars[] stars = new Stars[300];
Paddle leftPaddle, rightPaddle;
ScoreBoard leftScoreboard, rightScoreboard;
//
void gameSetup() {
  gameActive = true;
  //
  leftScore = 0;
  rightScore = 0;
  leftStreak = 0;
  rightStreak = 0;
  activeBalls = 1;
  //
  leftScoreboard = new ScoreBoard(gameWidth*1/3, gameHeight*2/7, gameReferentMeasure/7, gameReferentMeasure/7, borderThickness, color(#000000), color(#ffffff), 0, 100, "Left");
  rightScoreboard = new ScoreBoard(gameWidth*2/3, gameHeight*2/7, gameReferentMeasure/7, gameReferentMeasure/7, borderThickness, color(#000000), color(#ffffff), 0, 100, "Right");
  //
  leftPaddle = new Paddle(gameWidth*1/7, gameHeight/2, gameReferentMeasure/23, gameReferentMeasure/5, gameReferentMeasure/100, color(#ffffff), 'w', 's', 'a', "Left", leftPlayerRect.mode);
  rightPaddle = new Paddle(gameWidth*6/7, gameHeight/2, gameReferentMeasure/23, gameReferentMeasure/5, gameReferentMeasure/100, color(#ffffff), 'i', 'k', 'l', "Right", rightPlayerRect.mode);
  //
  for (int i=0; i < stars.length; i++) {
    stars[i] = new Stars(random(0, gameWidth), random(0, gameHeight), gameReferentMeasure/random(130, 200), gameReferentMeasure/random(130, 200), color(#ffffff), gameX, gameWidth, gameY, gameHeight);
  }
  //
  for (int i=0; i < fireworks.length; i++) {
    fireworks[i] = new Firework(100000, 100000, color(#ffffff));
  }
  //
  for (int i=0; i < balls.length; i++) {
    if (i > 0) {
      balls[i] = new Ball(random(gameWidth*3/7, gameWidth*4/7), random(0, gameHeight), gameReferentMeasure/30, gameReferentMeasure/30, color(#ffffff));
    } else {
      balls[i] = new Ball(gameWidth/2, gameHeight/2, gameReferentMeasure/30, gameReferentMeasure/30, color(#ffffff));
    }
  }
}//End gameSetup
//
void gameDraw() {
  if (leftPlayerRect.mode != 0) {botControl(leftPaddle, leftPlayerRect.mode, balls[0]);}
  if (rightPlayerRect.mode != 0) {botControl(rightPaddle, rightPlayerRect.mode, balls[0]);}
  //
  for (int i=0; i < stars.length; i++) {
    stars[i].move();
    stars[i].draw();
  }
  //
  for (int i=0; i < fireworks.length; i++) {
    fireworks[i].move();
  }
  //
  leftScoreboard.move();
  rightScoreboard.move();
  leftScoreboard.draw();
  rightScoreboard.draw();
  //
  if (leftPaddle.readyToPlay == true && rightPaddle.readyToPlay == true) {//move balls when both players have moved
    for (int i=0; i < activeBalls; i++) {
      balls[i].move();
    }
  }
  //
  ballCollisionCheck();
  //
  for (int i=0; i < activeBalls; i++) {//draw balls
      balls[i].draw();
  }
  //
  leftPaddle.move();
  rightPaddle.move();
  leftPaddle.draw();
  rightPaddle.draw();
  //
  if (gameActive == false) {
    noStroke();
    fill(#ffffff);
    textFont(appFont);
    textSize(gameWidth/18);
    text(winningText, (gameX + gameWidth/2) - textWidth(winningText)/2, (gameY+gameHeight/2)+gameWidth/54);
    if (fireworkTimer <= 0) {
      colorMode(HSB);
      newFirework(random(gameWidth*1/3, gameWidth*2/3), random(0, gameHeight), color(random(0,255), 255, 255));
      colorMode(RGB);
      fireworkTimer = int(random(20, 40));
    } else {
      fireworkTimer--;
    }
    if (restartButton.borderOpacity <= 0 || restartButton.borderOpacity >= 255) {
      flickerDir *= -1;
    }
    restartButton.borderOpacity += flickerDir;
  }
  /*
  if ((leftStreak >= 3 || rightStreak >= 3) && activeBalls < balls.length) {//when one player gets a streak of three points, add another ball (hackathon feature, will probably be removed/reworked)
    activeBalls++;
    leftStreak = 0;
    rightStreak = 0;
  }
  */
  //
  if (gameMode != 3 && gameActive == true) {
    switch(gameMode) {
      case 0:
        if (leftScore >= 5) {
          playerWins("Left");
        } else if (rightScore >= 5) {
          playerWins("Right");
        }
        break;
      case 1:
        if (leftScore >= 10) {
          playerWins("Left");
        } else if (rightScore >= 10) {
          playerWins("Right");
        }
        break;
      case 2:
        if ((leftScore == 3) || (leftScore == 2 && rightScore <= 1)) {
          playerWins("Left");
        } else if ((rightScore == 3) || (rightScore == 2 && leftScore <= 1)) {
          playerWins("Right");
        }
        break;
    }
  }
}//End gameDraw
//
void gameKeyPressed() {
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}//End gameKeyPressed
//
void gameKeyReleased() {
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}//End gameKeyReleased
//
void gameMousePressed() {
  if (mouseButton == RIGHT) {//**EASTER EGG** Right click on the game window to make fireworks!
    colorMode(HSB);
    newFirework(mouseX, mouseY, color(random(0,255), 255, 255));
    colorMode(RGB);
  }
}//End gameKeyPressed
//
void gameMouseReleased() {
}//End gameKeyReleased
//
void ballCollisionCheck() {
  for (int i=0; i < balls.length; i++) {//check if balls bounce off of either paddle
    if (collisionCheckRight(balls[i].x, balls[i].y, balls[i].w, balls[i].w, leftPaddle.x, leftPaddle.y, leftPaddle.w, leftPaddle.h) == true && balls[i].velocityX * leftPaddle.velocityX <= 0 && balls[i].paddleBounceTimer <= 0) {//Ball bounces off my paddle when moving in opposite (or no) X direction, gains paddle's x velocity
      playSound(bounce);
      balls[i].velocityX += leftPaddle.velocityX*-1;
      leftPaddle.velocityX = 0;
      balls[i].x = leftPaddle.x+balls[i].w/2+leftPaddle.w/2;
      balls[i].velocityX *= -1;
      balls[i].paddleBounceTimer = 20;
    }
  }
  //
  for (int i=0; i < balls.length; i++) {
    if (collisionCheckRight(rightPaddle.x, rightPaddle.y, rightPaddle.w, rightPaddle.h, balls[i].x, balls[i].y, balls[i].w, balls[i].w) == true && balls[i].velocityX * rightPaddle.velocityX <= 0 && balls[i].paddleBounceTimer <= 0) {//Ball bounces off your paddle when moving in opposite (or no) Xdirection, gains paddle's x velocity
      playSound(bounce);
      balls[i].velocityX += rightPaddle.velocityX*-1;
      leftPaddle.velocityX = 0;
      balls[i].x = rightPaddle.x-balls[i].w/2-rightPaddle.w/2;
      balls[i].velocityX *= -1;
      balls[i].paddleBounceTimer = 20;
    }
  }
}//End ballCollisionCheck
//
void newFirework(float x, float y, color colour) {
  playSound(fireworks[currentFirework].fireworkSound);
  currentFirework = (currentFirework >= 9) ? 0 : currentFirework + 1;
  fireworks[currentFirework] = new Firework(x, y, colour);
}//End newFirework
//
void playerWins(String winningPlayer) {
  playSound(victory);
  gameActive = false;
  //
  if (winningPlayer == "Left") {
    winningText = "Player 1 victory!";
  } else if (winningPlayer == "Right") {
    winningText = "Player 2 victory!";
  } else {
    noWinnerError();
  }
}//End playerWins
