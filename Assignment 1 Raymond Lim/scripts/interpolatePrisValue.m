function [x] = interpolatePrisValue(brickPose, qlim)
%GETPRISVALUE Summary of this function goes here
%   Detailed explanation goes here
    brickX = brickPose(1,4);
    if brickX >= qlim(1) && brickX <= qlim(2)
        qPrisF = brickX ;
    else 
        if brickX > qlim(2)
            qPrisF = qlim(2);
        elseif brickX < qlim(1)
            qPrisF = qlim(1);
        end
    end     
    x = qPrisF;
end

