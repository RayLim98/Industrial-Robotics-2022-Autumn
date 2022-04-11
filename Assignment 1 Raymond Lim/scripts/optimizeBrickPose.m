% to change the pose of the brick to complement the position of the end
% effector
function [optimizedPose] = optimizeBrickPose(qfBrick, endEff)
    qfBrick = qfBrick * transl(0,0,0.08);
    qfBrick(1:3,1:3) = endEff(1:3,1:3);
    optimizedPose = qfBrick;
end

