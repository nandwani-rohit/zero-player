final int WIDTH = 800;
final int HEIGHT = int(2.*WIDTH/3);
final float boundaryWidth = .95*WIDTH;
final float boundaryHeight = .95*HEIGHT;
float u_x, u_y;

color c = color(11);
Wall[] walls;
Wall winZone;
Protagonist ball;

void settings()
{
  size(WIDTH, HEIGHT);
}

void setup()
{
  background(c);
  //initialize();
  walls = new Wall[wallsData.length];
  for (int i = 0; i < walls.length; ++i)
  {
    walls[i] = new Wall(
                         boundaryWidth * wallsData[i][0]/100,
                         boundaryHeight * wallsData[i][1]/100,
                         boundaryWidth * wallsData[i][2]/100,
                         boundaryHeight * wallsData[i][3]/100,
                         wallsData[i][4]
                       );
  }
  
  winZone = new Wall(
                      boundaryWidth * wallsData[7][0]/100,
                      boundaryHeight * wallsData[7][1]/100,
                      boundaryWidth * wallsData[8][0]/100,
                      boundaryHeight * wallsData[8][1]/100,
                      7890
                    );
                    
  //u_x = ballData[2] * boundaryWidth/100;
  //u_y = ballData[3] * boundaryHeight/100;
  
  u_x = ballData[2];
  u_y = ballData[3];
  
  //u_x = 10.888503;
  //u_y = 3.5755765;

  
  ball = new Protagonist(
                          ballData[0] * boundaryWidth/100,
                          ballData[1] * boundaryHeight/100,
                          u_x,
                          u_y
                        );
                        

}

void draw()
{
  background(c);
  boundary();
  
  translate((width-boundaryWidth)/2, (height-boundaryHeight)/2);
  for (int i = 0; i < walls.length; ++i)
  {
    walls[i].display();
  }
  
  winZone.display();
  
  ball.display();
}
  
