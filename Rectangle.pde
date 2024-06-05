abstract class Rectangle extends Shape {
  //
  Rectangle (float x, float y, float w, float h, color colour) {
    super(x, y, w, h, colour);
  }//End Rectangle
  //
  void draw() {
    noStroke();
    fill(colour);
    rect(x,y,w,h);
  }//End draw
}//End Rectangle
//
class Ball extends Rectangle {
  float velocityX, velocityY, directionX, directionY, velocityLockY, velocityLockX, maxVelocityX, maxVelocityY;
  int paddleBounceTimer = 0;
  int dustReset = 0;
  //
  ScoreExplosion[] celebration = new ScoreExplosion[25];
  RadiantParticleRect[] dust = new RadiantParticleRect[10];
  //
  Ball(float x, float y, float w, float h, color colour) {
    super(x, y, w, h, colour);
    directionX = (random(-1,1) > 0) ? 1 : -1;
    directionY = (random(-1,1) > 0) ? 1 : -1;
    velocityLockX = gameReferentMeasure/random(80, 120)*directionX;
    velocityLockY = gameReferentMeasure/random(80, 120)*directionY;
    maxVelocityX = velocityLockX * 4;
    maxVelocityY = velocityLockY * 4;
    velocityX = velocityLockX;
    velocityY = velocityLockY;
    //
    for (int i=0; i < celebration.length; i++) {
      celebration[i] = new ScoreExplosion(10000, 10000, w/random(1,3), h, color(#ffffff), PI/2, 3*PI/2, 1);
    }
    //
    for (int i=0; i < dust.length; i++) {
      dust[i] = new RadiantParticleRect(100000000, 10000000, w, h, 1, color(colour));
    }
  }//End Ball
  //
  void move() {
    paddleBounceTimer--;
    if ( x + w/2 >= gameWidth ) {//Right side scored on
      //Fireworks when a goal is scored
      for (int i=0; i < celebration.length; i++) {
        celebration[i] = new ScoreExplosion(x, y, w/random(1,3), h, color(#ffffff), PI/2, 3*PI/2, 1);
      }
      playSound(explosion);
      //
      if (gameActive == true) {
        leftScore++;
        leftStreak++;
        rightStreak = 0;
      }
      //reset the ball's position when a goal is scored
      directionX = random(-1,1); if (directionX > 0) {directionX = 1;} else {directionX = -1;}
      directionY = random(-1,1); if (directionY > 0) {directionY = 1;} else {directionY = -1;}
      velocityX = gameReferentMeasure/random(80, 120)*directionX;
      velocityY = gameReferentMeasure/random(80, 120)*directionY;
      x = gameWidth/2;
      y = gameHeight/2;
    } else if( x - w/2 <= 0 ) {//Left side scored on
      for (int i=0; i < celebration.length; i++) {
        celebration[i] = new ScoreExplosion(x, y, w/random(1,3), h, color(#ffffff), PI/2, 3*PI/2, -1);
      }
      playSound(explosion);
      //
      if (gameActive == true) {
        rightScore++;
        rightStreak++;
        leftStreak = 0;
      }
      //
      directionX = random(-1,1); if (directionX > 0) {directionX = 1;} else {directionX = -1;}
      directionY = random(-1,1); if (directionY > 0) {directionY = 1;} else {directionY = -1;}
      velocityX = gameReferentMeasure/random(80, 120)*directionX;
      velocityY = gameReferentMeasure/random(80, 120)*directionY;
      x = gameWidth/2;
      y = gameHeight/2;
    }
    // Bounce. when the ball would move out of bounds, it snaps to the edge of the screen (to stay in bounds @ high speeds) and reverses direction.
    if ( y + h/2 >= gameHeight ) {
      y = gameHeight-h/2;
      velocityY *= -1;
    } else if( y - h/2 <= 0 ) {
      y = 0+h/2;
      velocityY *= -1;
    }
    // ball cannot exceed certain speed
    if (abs(velocityX) > abs(maxVelocityX)) {
      if (velocityX > 0) {
        velocityX = abs(maxVelocityX);
      } else {
        velocityX = abs(maxVelocityX)*-1;
      }
    }
    if (abs(velocityY) > abs(maxVelocityY)) {
      if (velocityY > 0) {
        velocityY = abs(maxVelocityY);
      } else {
        velocityY = abs(maxVelocityY)*-1;
      }
    }
    // slow down until ball is at initial velocityX.
    if (abs(velocityX) > abs(velocityLockX)) {
      if (abs(velocityX * 0.995) > abs(velocityLockX)) {
        velocityX *= 0.995;
      }
    }
    //
    for (int i=0; i < celebration.length; i++) {
      celebration[i].move();
      celebration[i].draw();
    }
    //
    if (dustReset + 1 > dust.length - 1) {
      dustReset = 0;
    } else {
      dustReset++;
    }
    dust[dustReset] = new RadiantParticleRect(x, y, ((abs(velocityX)*w)/25*random(1, 2)), h, 1, color(#DBDBDB));
    //
    for (int i=0; i < dust.length; i++) {
      dust[i].move();
      dust[i].draw();
    }
    //
    x += velocityX;
    y += velocityY;
  }//End move
}//End Ball
//
class ScoreExplosion extends Rectangle {
  float velocityX, velocityY, accelerationY, totalVelocity, velocityAngle;
  //
  ScoreExplosion(float x, float y, float w, float h, color colour, float minAngle, float maxAngle, int inverse) {
    super(x, y, w, h, colour);
    totalVelocity = (gameReferentMeasure/random(40, 60))*random(0.025, 1);
    velocityAngle = random(minAngle, maxAngle);
    velocityX = (totalVelocity*cos(velocityAngle))*inverse;
    velocityY = (totalVelocity*sin(velocityAngle));
    accelerationY = 0.25;
  }//End ScoreExplosion
  //
  void move() {
    velocityY+=accelerationY;// "gravity"
    x += velocityX;
    y += velocityY;
    w *= 0.95;
    h = w;
  }//End move
}//End ScoreExplosion
//
class RadiantParticleRect extends Rectangle {
  float velocityX, velocityY, accelerationY, totalVelocity, velocityAngle;
  float stretch;
  int fireworkColour;
  //
  RadiantParticleRect(float x, float y, float w, float h, float stretch, color colour) {
    super(x, y, w, h, colour);
    this.stretch = stretch;
    h = w;
    totalVelocity = (gameReferentMeasure/random(40, 60))*random(0.025, 1);
    velocityAngle = random(0, 2*PI);
    velocityX = (totalVelocity*cos(velocityAngle));
    velocityY = (totalVelocity*sin(velocityAngle));
  }//End Fireworks
  //
  void move() {
    totalVelocity *= 0.90;
    velocityX = (totalVelocity*cos(velocityAngle))*stretch;
    velocityY = (totalVelocity*sin(velocityAngle));
    x += velocityX;
    y += velocityY;
    w *= 0.9;
    h = w;
  }//End move
}//End Radiant Particles
