classdef Position
    properties
        x = 0;
        y = 0;
        z = 0;
    end
    methods 
        function self = Position(x, y ,z)
            self.x = x;
            self.y = y;
            self.z = z;
        end
    end
end