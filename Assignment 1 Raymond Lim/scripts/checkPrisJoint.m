function [qEnd] = checkPrisJoint (qEnd, qlim, brickX)
%GENTRAJECTORYALIGNMENT Summary of this function goes here
%   Returns q Matrix Trajectory
%   Will only work for prismatic in the x direction 
    qf = qEnd;
    if brickX >= qlim(1) && brickX <= qlim(2)
        qPrisF = brickX ;
    else 
        if brickX > qlim(2)
            qPrisF = qlim(2);
        elseif brickX < qlim(1)
            qPrisF = qlim(1);
        end
    end   
    qf(1) = qPrisF;
    qEnd = qf;
end

