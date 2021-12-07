classdef Protagonist < handle

    properties
        x
        y
        v_x
        v_y
    end
    
    methods
        function obj = Protagonist(x, y, v_x, v_y)
            obj.x = x;
            obj.y = y;
            obj.v_x = v_x;
            obj.v_y = v_y;
        end

        function update(obj)
            obj.x = obj.x + obj.v_x;
            obj.y = obj.y + obj.v_y;
        end

        function checkCollision(obj, walls)
            for i = 1:length(walls)
                if (walls(i).checkCollision(obj))
                    walls(i).update(obj);
                end
            end
        end


    end
end

