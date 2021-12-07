void boundary()
{
  stroke(255);
  noFill();
  rectMode(CENTER);
  rect(width*.5, height*.5, boundaryWidth, boundaryHeight);
}

void checkBoundaryCollision(Protagonist p)
{
  if (p.x >= boundaryWidth || p.x <= 0 || p.y >= boundaryHeight || p.y <= 0)
  {
    //println("Death : " + nf(u_x,2,14) + " " + nf(u_y,2,14));
    println("Death : " + u_x + " " + u_y);
    u_x = random(0,2) * boundaryWidth/100;
    u_y = random(-2,2) * boundaryHeight/100;
    
    ball = new Protagonist(
                            ballData[0] * boundaryWidth/100,
                            ballData[1] * boundaryHeight/100,
                            u_x,
                            u_y
                          );
  }
  else if ((winZone.side(p.x, p.y) * winZone.side(p.x + p.v_x, p.y + p.v_y) <= 0) && winZone.within(p.x, p.y))
  {
    println("SUCCESS : " + u_x + " " + u_y);
    //println("SUCCESS : " + nf(u_x,2,14) + " " + nf(u_y,2,14));
    //exit();
    
    u_x = random(0,2) * boundaryWidth/100;
    u_y = random(-2,2) * boundaryHeight/100;
    
    ball = new Protagonist(
                            ballData[0] * boundaryWidth/100,
                            ballData[1] * boundaryHeight/100,
                            u_x,
                            u_y
                          );
  }
}
                          
    //if (p.x >= boundaryWidth)
    //{
    //  p.x = boundaryWidth-1;
    //  p.v_x *= -1;
    //}
    //else if (p.x <= 0)
    //{
    //  p.x = 1;
    //  p.v_x *= -1;
    //}
    
    //if (p.y >= boundaryHeight)
    //{
    //  p.y = boundaryHeight-1;
    //  p.v_y *= -1;
    //}
    //else if (p.y <= 0)
    //{
    //  p.y = 1;
    //  p.v_y *= -1;
    //}
//}
