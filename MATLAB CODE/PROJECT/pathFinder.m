function [points, counter, distance] = pathFinder(u_xy)
    global ball ballData walls winZone boundaryWidth boundaryHeight lambda o_x o_y;

    points = [];
    distance = -1;
    
    ball.x = boundaryWidth * ballData(1)/100;
    ball.y = boundaryHeight * ballData(2)/100;
    ball.v_x = u_xy(1);
    ball.v_y = u_xy(2);

    counter = 1;
    while true
        points(counter,:) = [ball.x ball.y];
        ball.updateLess(0.1);

        if (ball.x >= boundaryWidth || ball.x <= 0 || ball.y >= boundaryHeight || ball.y <= 0)
            distance = lambda * sqrt((ball.x - o_x)^2 + (ball.y - o_y)^2);
            break;
        elseif (winZone.checkCollision(ball))
            distance = sqrt((ball.x - o_x)^2 + (ball.y - o_y)^2);
            break;
        end
        
        ball.checkCollision(walls);
        counter = counter + 1;

    end
end