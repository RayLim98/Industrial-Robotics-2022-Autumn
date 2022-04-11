clc 
clear
clf

brick = PlyObject('Brick.ply', [1 1 0], 0);
hold on
mdl_puma560
p560.plot([0 0 -pi/2 -pi/2 0 0])
p560.teach()
p560.base = p560.base * transl(-0.5,0,0)
%%
% tr = p560.fkine(p560.getpos()) 
tr = p560.base
% tr(1:3, 1:3) = eye(3)
trTB = brick.pose * inv(tr)
% angle = atan2(trTB(2,4), trTB(1,4))
angle = calcAnglePose2Pose(tr, trTB)

p560.plot([angle 0 0 0 0 0])