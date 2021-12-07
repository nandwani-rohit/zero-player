function distance = objectiveFun(u_xy)
    global ball ballData walls winZone boundaryWidth boundaryHeight lambda o_x o_y;

    status = -1;
    distance = -1;
    
    ball.x = boundaryWidth * ballData(1)/100;
    ball.y = boundaryHeight * ballData(2)/100;
    ball.v_x = u_xy(1);
    ball.v_y = u_xy(2);

    counter = 0;
    while true
        ball.update();

        if (ball.x >= boundaryWidth || ball.x <= 0 || ball.y >= boundaryHeight || ball.y <= 0)
            status = 0;
            distance = lambda * sqrt((ball.x - o_x)^2 + (ball.y - o_y)^2);
            break;
        elseif (winZone.checkCollision(ball))
            status = 1;
            distance = sqrt((ball.x - o_x)^2 + (ball.y - o_y)^2);
            break;
        end
        
        ball.checkCollision(walls);
        counter = counter + 1;
        
        %disp(sprintf("%d | %.7f %.7f %.7f %.7f", counter, ball.x, ball.y, ball.v_x, ball.v_y));
        
%         if (counter >= 1000000)
%             status = -2;
%             break;
%         end
    end
end