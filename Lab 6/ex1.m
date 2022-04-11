clc
clf
clear

workspace = [-2 2 -2 2 0 3];
robot = SchunkUTSv2_0();
q = [0,pi/2,0,0,0,0];
robot.plot3d(q, 'workspace', workspace);
view(3);
camlight;
hold on;

tr = robot.fkine(q)
startP = tr(1:3,4);
endP = tr(1:3,4) + 1.9594 * tr(1:3,3);
line1_h = plot3([startP(1),endP(1)],[startP(2),endP(2)],[startP(3),endP(3)],'r');
plot3(endP(1),endP(2),endP(3),'r*');

q = [ pi/10, pi/2, 0, 0, 0, 0 ];


tr = robot.fkine(q)
startP = tr(1:3,4);
endP = tr(1:3,4) + 2.4861 * tr(1:3,3);
line2_h = plot3([startP(1),endP(1)],[startP(2),endP(2)],[startP(3),endP(3)],'r');
plot3(endP(1),endP(2),endP(3),'r*');

q = [ -pi/10, 5*pi/12, 0, 0, 0, 0 ];
tr = robot.fkine(q)
startP = tr(1:3,4);
endP = tr(1:3,4) + 1.9132 * tr(1:3,3);
line3_h = plot3([startP(1),endP(1)],[startP(2),endP(2)],[startP(3),endP(3)],'r');
plot3(endP(1),endP(2),endP(3),'r*');

w1 = CreateYWall(1,2,[0,2]);

