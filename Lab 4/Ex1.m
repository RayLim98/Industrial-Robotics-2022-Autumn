clc
clear

L1 = Link('d',0,'a',1,'alpha',0,'qlim',[-pi pi])
L2 = Link('d',0,'a',1,'alpha',0,'qlim',[-pi pi])
L3 = Link('d',0,'a',1,'alpha',0,'qlim',[-pi pi])
robot = SerialLink([L1 L2 L3],'name','myRobot');

robot.base = troty(pi)
q = zeros(1,3);
robot.plot(q,'workspace',[-2 2 -2 2 -0.05 2],'scale',0.5);
robot.teach()


newQ = robot.ikine(transl(-0.75,-0.5,0),q,[1,1,0,0,0,0]);
robot.plot(newQ, 'trail', '-')

% interates only in the y direction
for y=-0.5:0.05:0.5
    newQ = robot.ikine(transl(-0.75,y,0),newQ,[1,1,0,0,0,0]);
    robot.animate(newQ);
    drawnow();
end
%% draw circle

% set starting position
for x= -0.5:0.05:0.5
    y = sqrt(0.5^2 - x^2);
    newQ = robot.ikine(transl(x,y,0),newQ,[1,1,0,0,0,0]);
    robot.animate(newQ);
    drawnow();
end

%%
clc
clear
mesh_h = PlaceObject('penVertexColour.ply');
axis equal
vertices = get(mesh_h,'Vertices');

transformedVertices = [vertices,ones(size(vertices,1),1)] * transl(0,0,0.1)';
set(mesh_h,'Vertices',transformedVertices(:,1:3));

transformedVertices = [vertices,ones(size(vertices,1),1)] * trotx(pi/2)';
set(mesh_h,'Vertices',transformedVertices(:,1:3));

mdl_planar3
hold on
p3.plot([0,0,0])
p3.delay = 0;

axis([-3,3,-3,3,-0.5,8])

for i = -pi/4:0.01:pi/4
    p3.animate([i,i,i])
    tr = p3.fkine([i,i,i]);
    transformedVertices = [vertices,ones(size(vertices,1),1)] * tr';
    set(mesh_h,'Vertices',transformedVertices(:,1:3));
    drawnow();
    pause(0.01);
end