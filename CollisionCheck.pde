boolean collisionCheckRight(float colliderRightX, float colliderRightY, float colliderRightWidth, float colliderRightHeight, float colliderLeftX, float colliderLeftY, float colliderLeftWidth, float colliderLeftHeight) {//Collision Check on the left & right sides of two rectangular objects
  float colliderRightTopSide = colliderRightY - colliderRightHeight/2,//variables containing the x value of the left & right sides and y values of the top & bottom values of the right collider
        colliderRightBottomSide = colliderRightY + colliderRightHeight/2,
        colliderRightLeftSide = colliderRightX - colliderRightWidth/2,
        colliderRightRightSide = colliderRightX + colliderRightWidth/2;
  //
  float colliderLeftTopSide = colliderLeftY - colliderLeftHeight/2,//variables containing the x value of the left & right sides and y values of the top & bottom values of the left collider
        colliderLeftBottomSide = colliderLeftY + colliderLeftHeight/2,
        colliderLeftLeftSide = colliderLeftX - colliderLeftWidth/2,
        colliderLeftRightSide = colliderLeftX + colliderLeftWidth/2;
  //
  if (colliderRightBottomSide >= colliderLeftTopSide && 
      colliderRightTopSide <= colliderLeftBottomSide &&
      colliderRightLeftSide <= colliderLeftRightSide && 
      colliderRightRightSide >= colliderLeftLeftSide) {
    return true;
  } else {
    return false;
  }
}//End collisionCheckSide
/*CONDITIONS FOR TOP COLLISION:
  -right side of top object is greater than left side of bottom object
  -left side of top object is less than right side of bottom object
  -bottom side of top object is greater than or equal to top side of bottom object
  -top side of top object is less than top side of bottom object
*/
/*CONDITIONS FOR RIGHT COLLISION:
  -bottom side of right object is greater than top side of left object
  -top side of right object is less than bottom side of left object
  -left side of right object is less than right side of left object
  -right side of right object is greater than left side of left object
*/
