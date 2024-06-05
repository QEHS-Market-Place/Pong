import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
import processing.pdf.*;
//Global Variables
int currentScene;//current scene
/*
main menu:0
player select:1
game:2
settings:3
*/
void setup() {
  fullScreen(); appWidth = displayWidth; appHeight = displayHeight; 
  //size(800, 450); appWidth = width; appHeight = height; 
  currentScene = 0;
  display();
  audioSetup();
  mainMenuSetup();
  playerSelectSetup();
  gameSetup();
  buttonPanelSetup();
  //
  switch(currentScene) {
    case 0:
      mainMenuSetup();
      break;
    case 1:
      playerSelectSetup();
      break;
    case 2:
      gameSetup();
      buttonPanelSetup();
      break;
    default:
      noSceneError();
      break;
  }
}//End setup
//
void draw() {
  background(backgroundColour);
  //
  if (appWidth < appHeight) {
    noStroke();
    fill(#ff0000);
    textSize(appWidth/displayMessage.length()*2);
    text(displayMessage, 0, (appWidth/displayMessage.length()*2));
  }
  //
  switch(currentScene) {
    case 0:
      mainMenuDraw();
      break;
    case 1:
      playerSelectDraw();
      break;
    case 2:
      drawGameBackground();
      gameDraw();
      buttonPanelDraw();
      break;
    default:
      noSceneError();
      break;
  }
  /*
  if (leftPaddle != null) {
    textFont(appFont);
    textSize(appWidth/30);
    text(leftPaddle.y-leftPaddle.h/2, 0, gameHeight);
  }
  */ //debug text
}//End setup
//
void keyPressed() {
  switch(currentScene) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      gameKeyPressed();
      break;
    default:
      noSceneError();
      break;
  }
}//End keyPressed
//
void keyReleased() {
  switch(currentScene) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      gameKeyReleased();
      break;
    default:
      noSceneError();
      break;
  }
}//End keyReleased
//
void mousePressed() {
  switch(currentScene) {
    case 0:
      mainMenuMousePressed();
      break;
    case 1:
      playerSelectMousePressed();
      break;
    case 2:
      buttonPanelMousePressed();
      gameMousePressed();
      break;
    default:
      noSceneError();
      break;
  }
}//End mousePressed
//
void mouseReleased() {
  switch(currentScene) {
    case 0:
      mainMenuMouseReleased();
      break;
    case 1:
      playerSelectMouseReleased();
      break;
    case 2:
      buttonPanelMouseReleased();
      gameMouseReleased();
      break;
    default:
      noSceneError();
      break;
  }
}//End mouseReleased
//
void noSceneError() {
  println("Invalid scene, doofus");
  exit();
}//ERROR: CURRENT SELECTED SCENE DOESN'T EXIST
//
void noWinnerError() {
  println("Nobody won, doofus");
  exit();
}//ERROR: CURRENT WINNING PLAYER DOESN'T EXIST OR IS INVALID
//End Driver
