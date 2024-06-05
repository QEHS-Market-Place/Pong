abstract class Shape {
  float x, y, w, h;
  color colour;
  //
  Shape(float x, float y, float w, float h, color colour) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colour = colour;
  }//End Constructor
  //
  abstract void draw();
}//End Shape
