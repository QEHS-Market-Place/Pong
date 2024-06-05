Minim minim;
AudioPlayer explosion, buttonPress, bounce, victory;

void audioSetup() {
  minim = new Minim(this);
  explosion = minim.loadFile("data/explosion.wav");
  buttonPress = minim.loadFile("data/click.wav");
  bounce = minim.loadFile("data/bounce.wav");
  victory = minim.loadFile("data/victory.wav");
}//End audioSetup
//
void playSound(AudioPlayer sound) {
  sound.rewind();
  sound.play();
}//End playSound
