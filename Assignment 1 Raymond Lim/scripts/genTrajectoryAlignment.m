function [qMAlign] = genTrajectoryAlignment (q0,deltaRad,linkNumber, step ,brickTr, qlim)
%GENTRAJECTORYALIGNMENT Summary of this function goes here
%   Returns q Matrix Trajectory
%   Will only work for prismatic in the x direction 
%  init qf = [pi/2 -pi/2 pi/2 -pi/2 -pi/2 -pi/2]; UR3
    qf = q0;
    if nargin > 4
        brickX = brickTr(1,4);
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
    end 
    qf(linkNumber) = deltaRad;
    qMAlign = jtraj(q0, qf, step);
end

