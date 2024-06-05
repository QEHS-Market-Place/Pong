float appWidth, appHeight, appReferentMeasure;
float gameX, gameY, gameWidth, gameHeight, gameReferentMeasure, borderThickness;
String displayMessage = "Bad aspect ratio. Turn your phone to landscape mode. Ugly.";
color backgroundColour, gameBackgroundColour;
//
PFont appFont;
int appFontSize;
//
void display() {
  rectMode(CENTER);
  ellipseMode(CENTER);
  //
  println(width, height, displayWidth, displayHeight);
  appReferentMeasure = (appWidth < appHeight) ? appWidth : appHeight;
  //
  gameWidth = appWidth;
  gameHeight = appHeight*4/5;
  gameX = appWidth/2-gameWidth/2;
  gameY = 0;
  gameReferentMeasure = (gameWidth < gameHeight) ? gameWidth : gameHeight;
  borderThickness = appReferentMeasure/150;
  //
  backgroundColour = color(#000000);
  gameBackgroundColour = color(#000000);
  //
  appFontSize = int(gameReferentMeasure/6);
  appFont = loadFont("OCRAExtended-200.vlw");
}//End display
//
void drawGameBackground() {
  noStroke();
  fill(gameBackgroundColour);
  rectMode(CORNER);
  rect(gameX, gameY, gameWidth, gameHeight);
  rectMode(CENTER);
}//End drawGameBackground
