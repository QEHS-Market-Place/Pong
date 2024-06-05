abstract class Circle extends Shape {
  Circle (float x, float y, float w, float h, color colour) {
    super(x, y, w, h, colour);
  }//End Circle
  //
  void draw() {
    fill(colour);
    ellipse(x,y,w,h);
  }//End draw
}//End Circle
//
class Firework {
  AudioPlayer fireworkSound;
  FireworkParticle[] particle = new FireworkParticle[100];
  //
  Firework(float x, float y, color colour) {
    fireworkSound = minim.loadFile("data/fireworks.wav");
    //
    for (int i=0; i < particle.length; i++) {
      particle[i] = new FireworkParticle(x, y, gameReferentMeasure/random(40, 60), 0, colour);
    }
  }//End Fireworks
  //
  void move() {
    for (int i=0; i < particle.length; i++) {
      particle[i].move();
      particle[i].draw();
      fill(#ffffff);
      circle(particle[i].x, particle[i].y, particle[i].w*2/5);
    }
  }//End move
}//End Fireworks
//
class FireworkParticle extends Circle {
  float velocityX, velocityY, accelerationY, totalVelocity, velocityAngle;
  int fireworkColour;
  //
  FireworkParticle(float x, float y, float w, float h, color colour) {
    super(x, y, w, h, colour);
    h = w;
    totalVelocity = (gameReferentMeasure/random(40, 60))*random(0.025, 1);
    velocityAngle = random(0, 2*PI);
    velocityX = (totalVelocity*cos(velocityAngle));
    velocityY = (totalVelocity*sin(velocityAngle));
    accelerationY = 0.25;
  }//End Fireworks
  //
  void move() {
    velocityY+=accelerationY;// "gravity"
    x += velocityX;
    y += velocityY;
    w *= 0.95;
    h = w;
  }//End move
}//End Fireworks
//
//
class Stars extends Circle {
  float scrollSpeed, scrollDirectionAngle;
  float maxDistX, minDistX, maxDistY, minDistY;
  //
  Stars(float x, float y, float w, float h, color colour, float minDistX, float maxDistX, float minDistY, float maxDistY) {
    super(x, y, w, h, colour);
    this.maxDistX = maxDistX;
    this.minDistX = minDistX;
    this.maxDistY = maxDistY;
    this.minDistY = minDistY;
    h=w;
    scrollSpeed = gameReferentMeasure/random(500,600);
    scrollDirectionAngle = 10*PI/9;
  }//End Stars
  //
  void move() {
    x += scrollSpeed*cos(scrollDirectionAngle)*0.25;
    y += scrollSpeed*sin(scrollDirectionAngle)*-0.25;
    //
    if (x+w/2 < minDistX) {
      x = maxDistX+w/2;
    } else if (x-w/2 > maxDistX) {
      x = minDistX-w/2;
    }
    //
    if (y+h/2 < minDistY) {
      y = maxDistY+h/2;
    } else if (y-h/2 > maxDistY) {
      y = minDistY-h/2;
    }
  }//End move
}//End Stars
//
//
class RadiantParticleCirc extends Circle {
  float velocityX, velocityY, accelerationY, totalVelocity, velocityAngle;
  float stretch;
  int fireworkColour;
  //
  RadiantParticleCirc(float x, float y, float w, float h, float stretch, color colour) {
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
    w *= 0.95;
    h = w;
  }//End move
}//End Radiant Particles
