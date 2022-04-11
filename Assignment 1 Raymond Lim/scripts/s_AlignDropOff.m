deltaQ = calcAnglePose2Pose(ur3.model.base, brick.pose);
q03 = ur3.model.getpos();
qM3 = genTrajectoryAlignment(q03, 0, 1, 15);
ur3.model.plot(qM3);