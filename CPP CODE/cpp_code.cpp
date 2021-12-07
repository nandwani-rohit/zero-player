#include <iostream>
// #include <bits/std-c++>
#include <cmath>

using namespace std;

float wallsData[12][4] = {
    {28/3, 23, 28/3, 68},       // wall 1
    {28/3, 71, 24, 86},         // wall 2
    {22, 53, 44, 35},           // wall 3
    {44/3, 8, 256/3, 8},        // wall 4
    {100/3, 88, 148/3, 76},     // wall 5
    {148/3, 64, 196/3, 80},     // wall 6
    {72, 26, 72, 60},           // wall 7 
    {84, 74, 87.5, 99},         // wall 8
    {99, 74, 95.5, 99},         // wall 9
    {268/3, 64, 296/3, 64},     // wall 10 
    {296/3, 32, 296/3, 64},     // wall 11
    {87.5, 99, 95.5, 99}        // wall 12                      
};

// x, y
float ballData[2] = {8, 17};

class Wall;
class Protagonist;

class Protagonist
{
  public :
    float x, y, v_x, v_y;
  
    Protagonist(float x, float y, float v_x, float v_y)
    {
        this->x = x;
        this->y = y;
        this->v_x = v_x;
        this->v_y = v_y;    
    }
  
    void update()
    {  
        this->x += this->v_x;
        this->y += this->v_y;
    }

    void checkCollision(Wall walls[], int nWalls);  

};

class Wall
{
  public :
    float p1_x, p1_y, p2_x, p2_y;
    float slope, theta1, theta2;
    bool vertical = false;

    Wall() {}

    Wall(float p1_x, float p1_y, float p2_x, float p2_y)
    {
        this->p1_x = p1_x;
        this->p1_y = p1_y;
        this->p2_x = p2_x;
        this->p2_y = p2_y;
    
        if (p1_x != p2_x)
        {
            this->slope = (p2_y - p1_y)/(p2_x - p1_x);
        }
        else
        {
            this->vertical = true;
            this->slope = 0;
        }
      
        float t1 = atan2(p1_y, p1_x);
        float t2 = atan2(p2_y, p2_x);
        this->theta1 = min(t1, t2);
        this->theta2 = max(t1, t2);
    }
  
    float side(float x, float y)
    {
        if (not this->vertical)
        {
            return y - this->slope * (x - this->p1_x) - this->p1_y;
        }
        else 
        {
            return x - this->p1_x;
        }
    }
  
    bool within(float x, float y)
    {
        float theta = atan2(y, x);
        return (theta >= this->theta1 and theta <= this->theta2);
    }

    bool checkCollision(Protagonist *p)
    {
        bool crossing, range;
        crossing = (this->side(p->x, p->y) * this->side(p->x + p->v_x, p->y + p->v_y) <= 0);
        range = this->within(p->x, p->y);  

        return (crossing and range);
    }

    void update(Protagonist *p)
    {
        if (not this->vertical)
        {
            float change = -2*(-p->v_x*this->slope + p->v_y)/(pow(this->slope,2) + 1);
            p->v_x += change*(-this->slope);
            p->v_y += change;
        }
        else
        {
            p->v_x *= -1;
        }
    }
};

void Protagonist::checkCollision(Wall walls[], int nWalls)
{    
    for (int i = 0; i < nWalls; ++i)
    {
        if (walls[i].checkCollision(this))
        {
            walls[i].update(this);
            // break;
        }
    }
}

bool successOrDeath(float u_x, float u_y)
{
	float boundaryWidth = 760;
 	float boundaryHeight = 1520/3;
  
    Wall* walls = new Wall[12];
  
    for (int i = 0; i < 12; ++i)
    {
        walls[i] = Wall(
            boundaryWidth * wallsData[i][0]/100,
            boundaryHeight * wallsData[i][1]/100,
            boundaryWidth * wallsData[i][2]/100,
            boundaryHeight * wallsData[i][3]/100
        );
    }
    
    Wall winZone = Wall(
        boundaryWidth * wallsData[7][0]/100,
        boundaryHeight * wallsData[7][1]/100,
        boundaryWidth * wallsData[8][0]/100,
        boundaryHeight * wallsData[8][1]/100
    );
  
    Protagonist ball = Protagonist(
        boundaryWidth * ballData[0]/100,
        boundaryHeight * ballData[1]/100,
        u_x,
        u_y
    );

    bool outcome = false;
  
    while (true)
    {
  	    ball.update();       
          
        if (ball.x >= boundaryWidth || ball.x <= 0 || ball.y >= boundaryHeight || ball.y <= 0)
        {
		    outcome = false;
            break;
        }
        else if (winZone.checkCollision(&ball))
        {
            outcome = true;
            break;
        }

        ball.checkCollision(walls, 12);
    }
    
    return outcome;
}



int main()
{
	float u_x, u_y;
  
    u_x = 6.2430243;
    u_y = 5.00168;
  
    cout << boolalpha;
    cout << successOrDeath(u_x, u_y);
    
    return 0;
}