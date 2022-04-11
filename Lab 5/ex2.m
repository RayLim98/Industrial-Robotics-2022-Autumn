clc
clf
clear

L(1) = Link('d',0,'a',1,'alpha',0,'offset',0);
L(2) = Link('d',0,'a',1,'alpha',0,'offset',0);
L(3) = Link('d',0,'a',1,'alpha',0,'offset',0);

bot = SerialLink(L, 'name', ['Ex2']);
bot.base = eye(4);
q = [0 0 0];

scale = 0.5;
workspace = [-2 2 -2 2 -0.05 2];                                    
bot.plot(q,'workspace',workspace,'scale',scale);       

%% Generate fkine for each link
tr(:,:,:,1) = bot.base;
for i = 1: bot.n
    link = bot.links(i);
    tr(:,:,:, i+1) = tr(:,:,:,i) * trotz(q(i)+L(i).offset) * transl(0,0,L(i).d) * transl(L(i).a,0,0) * trotx(L(i).alpha);
end
%% Create block
axis equal
centerpnt = [2,0,-0.5];
side = 1.5;
plotOptions.plotFaces = true;
[vertex,faces,faceNormals] = RectangularPrism(centerpnt-side/2, centerpnt+side/2,plotOptions);

%% Check any intersection
for linkIndex = 1: bot.n
    for faceIndex = 1:size(faces,1)
        vertOnPlane = vertex(faces(faceIndex,1)',:);
        [intersectP,check] = LinePlaneIntersection(faceNormals(faceIndex,:),vertOnPlane,tr(1:3,4,linkIndex)',tr(1:3,4,linkIndex+1)'); 
        if check == 1 && IsIntersectionPointInsideTriangle(intersectP,vertex(faces(faceIndex,:)',:))
            plot3(intersectP(1),intersectP(2),intersectP(3),'g*');
            display('Intersection');
        end
    end
end
bot.teach()

%% Generate step resolution
q1 = [-pi/4,0,0];
q2 = [-pi/2,0,0];
step = 2;
while ~isempty(find(1 < abs(diff(rad2deg(jtraj(q1,q2,step)))),1))
    step = step + 1;
end

qM = jtraj(q1,q2,step);
bot.plot(qM)
%% Check for Collsion
collided = false;
CollisionExist(bot, qM, vertex,faces,faceNormals)

%% Creating Way Points
% Way points
% q1 = bot.getpos(); % First joint state 
q1 = [-pi/4,0,0];
q2 = [pi/4,0,0];

qM = [q1; ikcon(bot, )]





