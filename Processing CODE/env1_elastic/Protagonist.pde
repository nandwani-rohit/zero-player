class Protagonist
{
  float x, y, v_x, v_y;
  color c = #7AEEF7;
  float r = width*1/100;
  
  Protagonist(float x, float y, float v_x, float v_y)
  {
    this.x = x;
    this.y = y;
    this.v_x = v_x;
    this.v_y = v_y;    
  }
  
  void display()
  {
    fill(this.c);
    strokeWeight(1);
    stroke(this.c);
    circle(this.x, this.y, r);
    
    this.x += this.v_x;
    this.y += this.v_y;
    
    this.checkCollision();
  }
  
  void checkCollision()
  {
    checkBoundaryCollision(this);
    for (int i = 0; i < walls.length; ++i)
    {
      walls[i].checkCollision(this);
    }
  }
  
}
