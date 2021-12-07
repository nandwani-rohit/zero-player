function [distance, counter, actual] = objectiveFunTime(u_xy)
    global ball ballData walls winZone boundaryWidth boundaryHeight lambda o_x o_y gamma beta;

%     status = -1;
    distance = -1;
    actual = distance;
    
    ball.x = boundaryWidth * ballData(1)/100;
    ball.y = boundaryHeight * ballData(2)/100;
    ball.v_x = u_xy(1);
    ball.v_y = u_xy(2);

    counter = 0;
    while true
        ball.update();

        if (ball.x >= boundaryWidth || ball.x <= 0 || ball.y >= boundaryHeight || ball.y <= 0)
%             status = 0;
            distance = lambda * sqrt((ball.x - o_x)^2 + (ball.y - o_y)^2);
            actual = distance;
            counter = counter + 1;
            distance = distance + counter;
            break;
        elseif (winZone.checkCollision(ball))
%             status = 1;
            distance = sqrt((ball.x - o_x)^2 + (ball.y - o_y)^2);
            actual = distance;
            counter = counter + 1;
            distance = distance + gamma*power(counter, beta);
            break;
        end
        
        ball.checkCollision(walls);
        counter = counter + 1;

    end
end