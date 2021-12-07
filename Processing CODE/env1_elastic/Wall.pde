class Wall
{
  // parameters of a Wall
  float p1_x, p1_y, p2_x, p2_y;
  float slope, theta1, theta2;
  float e;
  color c;
  boolean trouble = false;
  
  // Constructor Method
  Wall(float p1_x, float p1_y, float p2_x, float p2_y, float e)
  {
    this.p1_x = p1_x;
    this.p1_y = p1_y;
    this.p2_x = p2_x;
    this.p2_y = p2_y;
    this.e = e;
    this.c = lerpColor(#FFF300, #FF0B03, (e-.2)/(1.5-.01));
    
    if (e == 7890)
    {
      this.c = #00F4FF;
    }
    if (p1_x != p2_x)
    {
      this.slope = (p2_y - p1_y)/(p2_x - p1_x);
    }
    else
    {
      this.trouble = true;
    }
    
      
    float t1 = atan2(p1_y, p1_x);
    float t2 = atan2(p2_y, p2_x);
    this.theta1 = min(t1, t2);
    this.theta2 = max(t1, t2);
  }
  
  void display()
  {
    if (this.e != 7890)
    {
      strokeWeight(2);
    }
    else
    {
      strokeWeight(5);
    }
    stroke(c);
    fill(c);
    line(p1_x, p1_y, p2_x, p2_y);
  }
  
  float side(float x, float y)
  {
    // gives y-value if x-value is given
    
    if (!this.trouble)
    {
      return y - this.slope * (x - this.p1_x) - p1_y;
    }
    else
    {
      return x - this.p1_x;
    }
  }
  
  boolean within(float x, float y)
  {
    float theta = atan2(y, x);
    return (theta >= this.theta1 && theta <= this.theta2);
  }

  void checkCollision(Protagonist p)
  {
    boolean crossing, range;
    crossing = (this.side(p.x, p.y) * this.side(p.x + p.v_x, p.y + p.v_y) <= 0);
    range = this.within(p.x, p.y);  
    
    if (crossing && range)
    {
      if (!this.trouble)
      {
        float change = -(this.e+1)*(-p.v_x*this.slope + p.v_y)/(sq(this.slope) + 1);
        p.v_x += change*(-this.slope);
        p.v_y += change;
      }
      else
      {
        p.v_x *= -this.e;
      }
    }
  }
  
}
