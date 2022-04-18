clc 
clear 
clf
centerPoint = [0,0,0];
radii = [3,2,1]
[X,Y,Z] = ellipsoid(centerPoint (1),centerPoint (2),centerPoint (3),radii(1),radii(2),radii(3));
ellip = surf(X,Y,Z)
hold on

[Y,Z] = meshgrid(-0.75:0.05:0.75,-0.75:0.05:0.75);
X = repmat(0.75,size(Y,1),size(Y,2));
% wall = surf(X,Y,Z);
% 
% hold on
% Combine one surface as a point cloud
cubePoints = [X(:),Y(:),Z(:)];

% Make a cube by rotating the single side by 0,90,180,270, and around y to make the top and bottom faces
cubePoints = [ cubePoints ...
             ; cubePoints * rotz(pi/2)...
             ; cubePoints * rotz(pi) ...
             ; cubePoints * rotz(3*pi/2) ...
             ; cubePoints * roty(pi/2) ...
             ; cubePoints * roty(-pi/2)...
             ];
% Plot the cube's point cloud         
cubeAtOigin_h = plot3(cubePoints(:,1),cubePoints(:,2),cubePoints(:,3),'r.');
cubePoints = cubePoints + repmat([2,0,-0.5],size(cubePoints,1),1);
cube_h = plot3(cubePoints(:,1),cubePoints(:,2),cubePoints(:,3),'b.');
axis equal

%% Check Points of cube inside ellipsoid
counter = 0;
for i = 1: size(cubePoints, 1)
    point = cubePoints(i,:);
    pointPosition = (point(1) - centerPoint(1))^2/radii(1)... 
                    + (point(2) - centerPoint(2))^2/radii(2)... 
                    + (point(3) - centerPoint(3))^2/radii(3);
    if pointPosition <= 1
        % Inside
        counter = counter + 1;
    end
end

%% Transform Ellipsoid
centerPoint = ([0,0,0] + 1);
radii = [3,2,1];
[X,Y,Z] = ellipsoid(centerPoint (1),centerPoint (2),centerPoint (3),radii(1),radii(2),radii(3));
ePoints = [X(:), Y(:),Z(:)] * rotx(pi/4)
ellip2 = surf(X,Y,Z);

%% Transform cube
cubePoints = cubePoints * rotx(pi/4);
try delete(cube_h); end
cube_h = plot3(cubePoints(:,1),cubePoints(:,2),cubePoints(:,3),'b.');

counter = 0;
for i = 1: size(cubePoints, 1)
    point = cubePoints(i,:);
    pointPosition = (point(1) - centerPoint(1))^2/radii(1)... 
                    + (point(2) - centerPoint(2))^2/radii(2)... 
                    + (point(3) - centerPoint(3))^2/radii(3);
    if pointPosition < 1
        % Inside
        counter = counter + 1;
    end
end
%% Robot 
L1 = Link('d',0,'a',1,'alpha',0,'qlim',[-pi pi])
L2 = Link('d',0,'a',1,'alpha',0,'qlim',[-pi pi])
L3 = Link('d',0,'a',1,'alpha',0,'qlim',[-pi pi])        
robot = SerialLink([L1 L2 L3],'name','myRobot');  

% New values for the ellipsoid (guessed these, need proper model to work out correctly)
centerPoint = [0,0,0];
radii = [1,0.5,0.5];
[X,Y,Z] = ellipsoid( centerPoint(1), centerPoint(2), centerPoint(3), radii(1), radii(2), radii(3) );
for i = 1:4
    robot.points{i} = [X(:),Y(:),Z(:)];
    warning off
    robot.faces{i} = delaunay(robot.points{i});    
    warning on;
end

robot.plot3d([0,0,0]);
axis equal
camlight
% robot.teach
% keyboard

% 2.9
q = [0,0,0]
tr = robot.fkine(q);
%% 
