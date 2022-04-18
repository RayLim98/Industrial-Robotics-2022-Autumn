clc
clf
clear

workspace = [-2 2 -2 2 0 3];
robot = SchunkUTSv2_0();
q = [0,pi/2,0,0,0,0];
robot.plot3d(q, 'workspace', workspace);
view(3);
camlight;
axis equal
hold on;
wall  = CreateYWall(2,1,[0,2]);

tr = robot.fkine(q)
startP = tr(1:3,4);
endP = startP + 1.9594 * tr(1:3,3);
line1_h = plot3([startP(1),endP(1)],[startP(2),endP(2)],[startP(3),endP(3)],'r');
plot3(endP(1),endP(2),endP(3),'r*');
robot.plot3d(q)

q = [ pi/10, pi/2, 0, 0, 0, 0 ];

tr = robot.fkine(q)
startP = tr(1:3,4);
endP = tr(1:3,4) + 2.4861 * tr(1:3,3);
line2_h = plot3([startP(1),endP(1)],[startP(2),endP(2)],[startP(3),endP(3)],'r');
plot3(endP(1),endP(2),endP(3),'r*');
robot.plot3d(q)

q = [ -pi/10, 5*pi/12, 0, 0, 0, 0 ];
tr = robot.fkine(q)
startP = tr(1:3,4);
endP = tr(1:3,4) + 1.9132 * tr(1:3,3);
line3_h = plot3([startP(1),endP(1)],[startP(2),endP(2)],[startP(3),endP(3)],'r');
plot3(endP(1),endP(2),endP(3),'r*');
robot.plot3d(q)

q = [0,pi/2,0,0,0,0];
step =  pi/180;

for i = deg2rad(-20): deg2rad(1): deg2rad(20)
    for j = deg2rad(-20): deg2rad(1): deg2rad(20)

    end
end


