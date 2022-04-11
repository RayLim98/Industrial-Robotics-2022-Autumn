function [rad] = calcAnglePose2Pose(tr0,trT)
%CALCANGLEPOSE2POSE Summary of this function goes here
%   Detailed explanation goes here
    tr0(1:3, 1:3) = eye(3);
    trT(1:3, 1:3) = eye(3); 
    tr02T = trT * inv(tr0);
    x = tr02T(1,4);
    y = tr02T(2,4);
    rad = atan2(y,x);
end

