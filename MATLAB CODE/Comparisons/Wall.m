classdef Wall < handle
    properties
        p1_x
        p1_y
        p2_x
        p2_y
        slope
        theta1
        theta2
        vertical
    end
    
    methods
        function obj = Wall(p1_x, p1_y, p2_x, p2_y)
            obj.p1_x = p1_x;
            obj.p1_y = p1_y;
            obj.p2_x = p2_x;
            obj.p2_y = p2_y;

            if (p1_x ~= p2_x)
                obj.slope = (p2_y - p1_y)/(p2_x - p1_x);
                obj.vertical = false;
            else
                obj.slope = 0;
                obj.vertical = true;
            end

            t1 = atan2(p1_y, p1_x);
            t2 = atan2(p2_y, p2_x);
            obj.theta1 = min([t1, t2]);
            obj.theta2 = max([t1, t2]);
        end

        function whichSide = side(obj, x, y)
            if (~obj.vertical)
                whichSide = y - obj.slope*(x - obj.p1_x) - obj.p1_y;
            else
                whichSide = x - obj.p1_x;
            end
        end

        function value = within(obj, x, y)
            theta = atan2(y, x);
            value = ((theta >= obj.theta1) && (theta <= obj.theta2));
        end

        function value = checkCollision(obj, p)
            crossing = (obj.side(p.x, p.y) * obj.side(p.x + p.v_x, p.y + p.v_y) <= 0);
            range = obj.within(p.x, p.y);

            value = (crossing && range);
        end

        function update(obj, p)
            if (~obj.vertical)
                change = -2*(-p.v_x * obj.slope + p.v_y)/(obj.slope^2 + 1);
                p.v_x = p.v_x - change*obj.slope;
                p.v_y = p.v_y + change;
            else
                p.v_x = -p.v_x;
            end
        end
    end
end

