%% Point In Puma End Effector Coordinate Frame
clear
close
clc
mdl_puma560
p560.base = transl(0,0,0); % Change the base if required
q = deg2rad([ -90 30 -80 0 45 0]); % Change the joint position depending on the question
ballPos = transl(0.4, -0.2, 0.7)*trotx(-pi/2);
% ballPoswrtEE = (p560.fkine(q))\ballPos;
ballPoswrtEE = inv(p560.fkine(q))*ballPos

%% Puma560 intersection
clear
close
clc
mdl_puma560
q = [pi/8 0 -pi/2 0 0 0];

%% End effector location of a 5 link planar robot (5DOF Planar)
close
clear
clc
L1 = Link('d', 0, 'a', 1, 'alpha', 0);
L2 = Link('d', 0, 'a', 1, 'alpha', 0);
L3 = Link('d', 0, 'a', 1, 'alpha', 0);
L4 = Link('d', 0, 'a', 1, 'alpha', 0);
L5 = Link('d', 0, 'a', 1, 'alpha', 0);
L = [L1 L2 L3 L4 L5];
robot = SerialLink(L, 'name', 'myRobot');
q = deg2rad([30 -30 30 -30 0]);
robot.plot(q, 'workspace', [-5 5 -5 5 -0.2 2], 'scale', 0.5)
disp('Robot end effector pose is ')
robot.fkine(robot.getpos)
%% mdl_3link3d collission (checking) with a flat wall
clear
close
clc
mdl_3link3d
q = [-pi/6 0 0]; 
R3.plot(q, 'workspace', [ -6 6 -6 6 0 3], 'scale', 0.5)
hold on
L = R3.links;
linkLocation = ones(4, 4, 3);
linkLocation(:,:,1) = R3.base;
planeVertex_x = [3 3 3 3];
planeVertex_y = [6 -6 -6 6];
planeVertex_z = [0 0 2 2];
% Patch automatically connects the last xyz coordinate with the first xyz coordinate
patch(planeVertex_x, planeVertex_y, planeVertex_z, 'r'); 
for i = 1:R3.n
    linkLocation(:,:,i+1) = linkLocation(:,:,i)*trotz(q(i)+L(i).offset)*transl(0,0,L(i).d)*transl(L(i).a,0,0)*trotx(L(i).alpha);
end
normalPoint = unit(cross(([3 -6 0]-[3 6 0]),([3 -6 2]-[3 6 0])));
planePoint = [3 6 2];
[intersectionPoint, check] = LinePlaneIntersection(normalPoint,planePoint,linkLocation(1:3,4,3)',linkLocation(1:3,4,4)');
%% Puma560 ikine
clear
close
clc
mdl_puma560
tr = transl(0.6, -0.5, 0.1); % EE location
guess = zeros(1,p560.n); % Initial guess
m = [1 1 1 0 0 0]; % xyz trans and rot mask (0 to ignore)
p560.ikine(tr, qn, m) % End effector pose

%% Puma560 sensor distance to EE
clear
close
clc
mdl_puma560
p560.base = transl(0,0,0); % Base of the robot
q = deg2rad([0 45 -80 0 45 0]);
eePose = p560.fkine(q);
eeLocation = eePose(1:3,4)'
sensorLocation = transl(2.2265, -0.6828, 1.6327);
x_dist = eeLocation(1) - sensorLocation(1, 4);
y_dist = eeLocation(2) - sensorLocation(2, 4);
z_dist = eeLocation(3) - sensorLocation(3, 4);
distance = sqrt(sum([x_dist^2 y_dist^2 z_dist^2]))