#include <iostream>
#include <cmath>
#include <iomanip>

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

    Protagonist() {}
  
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

float boundaryWidth = 760;
float boundaryHeight = 1520/3;
float o_x = 0;
float o_y = 0;
float lambda = 10;
  
Wall* walls = new Wall[12];
Wall winZone;
Protagonist ball;

void initialize()
{  
    for (int i = 0; i < 12; ++i)
    {
        walls[i] = Wall(
            boundaryWidth * wallsData[i][0]/100,
            boundaryHeight * wallsData[i][1]/100,
            boundaryWidth * wallsData[i][2]/100,
            boundaryHeight * wallsData[i][3]/100
        );
    }
    
    winZone = Wall(
        boundaryWidth * wallsData[7][0]/100,
        boundaryHeight * wallsData[7][1]/100,
        boundaryWidth * wallsData[8][0]/100,
        boundaryHeight * wallsData[8][1]/100
    );

    o_x = (winZone.p1_x + winZone.p2_x)/2;
    o_y = (winZone.p1_y + winZone.p2_y)/2;
}

struct result
{
    int status;
    float distance;
};

struct result successOrDeath(float u_x, float u_y)
{
    struct result answer;
    answer.status = -1;
    answer.distance = 0;
    
    ball.x = boundaryWidth * ballData[0]/100;
    ball.y = boundaryHeight * ballData[1]/100;
    ball.v_x = u_x;
    ball.v_y = u_y;
  
    while (true)
    {
  	    ball.update();       
          
        if (ball.x >= boundaryWidth || ball.x <= 0 || ball.y >= boundaryHeight || ball.y <= 0)
        {
		    answer.status = 0;
            answer.distance = lambda * hypot(ball.x - o_x, ball.y - o_y);
            break;
        }
        else if (winZone.checkCollision(&ball))
        {
            answer.status = 1;
            answer.distance = hypot(ball.x - o_x, ball.y - o_y);
            break;
        }

        ball.checkCollision(walls, 12);
    }
    
    return answer;
}



int main()
{
	float u_x, u_y;
  
    u_x = 4.5908365;
    u_y = 3.8361359;
  
    initialize();
    
    cout << setprecision(8);

    // prints "1" --> SUCCESS
    // prints "0" --> DEATH
    // prints "-1" --> ERROR

    struct result answer = successOrDeath(u_x, u_y);
    cout << answer.status << " " << answer.distance << " || " << ball.v_x << " " << ball.v_y << "\n";
    
    return 0;
}