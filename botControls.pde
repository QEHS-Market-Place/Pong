void botControl(Paddle player, int mode, Ball ball) {
  switch(mode) {
    case 1://easy: moves and charges at random.
      float randDir = random(-1,1);
      float randCharge = random(0, 80);
      //
      if (randDir > 0) {
        playerMoveUp(player);
      } else {
        playerMoveDown(player);
      }
      //
      if (randCharge < 2 && player.chargeHeld == false) {
        playerHoldCharge(player);
      } else if (randCharge > 18 && player.chargeHeld == true){
        playerReleaseCharge(player);
      }
    break;
    case 2://medium: moves up when below the ball, down when above the ball, charges when ball is in range, releases when ball is at x lock. Includes reaction time.
      if (player.botReactionTime <= 0) {
        if (ball.y > player.y) {
        playerMoveDown(player);
      } else if (ball.y < player.y) {
        playerMoveUp(player);
      } else {
        player.downHeld = false;
        player.upHeld = false;
      }
      //
      if (ball.y > player.y - player.h/2 && ball.y < player.y + player.h/2 && ((player.chargeDir == "Left" && ball.velocityX < 0) || (player.chargeDir == "Right" && ball.velocityX > 0)) && ((player.chargeDir == "Left" && ball.x < gameWidth/2) || (player.chargeDir == "Right" && ball.x > gameWidth/2))) {
        playerHoldCharge(player);
      } else {
        playerReleaseCharge(player);
      }
      //
      if ((player.chargeDir == "Left" && ball.x < player.xLock) || (player.chargeDir == "Right" && ball.x > player.xLock)) {
        playerReleaseCharge(player);
      }
        //
        player.botReactionTime = int(random(3, 10));
      } else {
        player.botReactionTime--;
      }
    break;
    case 3://hard: moves up when below the ball, down when above the ball, charges when ball is in range, releases when ball is at x lock.
      if (ball.y > player.y) {
        playerMoveDown(player);
      } else if (ball.y < player.y) {
        playerMoveUp(player);
      } else {
        player.downHeld = false;
        player.upHeld = false;
      }
      //
      if (ball.y > player.y - player.h/2 && ball.y < player.y + player.h/2 && ((player.chargeDir == "Left" && ball.velocityX < 0) || (player.chargeDir == "Right" && ball.velocityX > 0)) && ((player.chargeDir == "Left" && ball.x < gameWidth/2) || (player.chargeDir == "Right" && ball.x > gameWidth/2))) {
        playerHoldCharge(player);
      } else {
        playerReleaseCharge(player);
      }
      //
      if ((player.chargeDir == "Left" && ball.x < player.xLock) || (player.chargeDir == "Right" && ball.x > player.xLock)) {
        playerReleaseCharge(player);
      }
    break;
  }
  //
}//End botControl
//
void playerMoveUp(Paddle player) {
  player.downHeld = false;
  player.upHeld = true;
}
//
void playerMoveDown(Paddle player) {
  player.upHeld = false;
  player.downHeld = true;
}
//
void playerHoldCharge(Paddle player) {
  player.chargeHeld = true;
}
//
void playerReleaseCharge(Paddle player) {
  player.chargeHeld = false;
}
