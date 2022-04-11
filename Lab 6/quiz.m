%% Collision Checking
lineIntersection

%% Create 5Dof Planar
clc
clear
clf
L(1) = Link('d', 0, 'a', 1,'alpha',0, 'offset',0);
L(2) = Link('d', 0, 'a', 1,'alpha',0, 'offset',0);
L(3) = Link('d', 0, 'a', 1,'alpha',0, 'offset',0);
L(4) = Link('d', 0, 'a', 1,'alpha',0, 'offset',0);
L(5) = Link('d', 0, 'a', 1,'alpha',0, 'offset',0);
myRobot = SerialLink(L,'name', '5Dofrobot')

%% Distence sense distance to puma end effector 
clc
clf
clear
mdl_puma560
q = [0, 45, -80, 0, 45, 0];
EE = p560.fkine(deg2rad(q));

EPosition = EE(1:3,4)
Sensor  = [-0; 2.4567;-1.1516]
diff = Sensor - EPosition

distance =sqrt(diff(1)^2 + diff(2)^2 + diff(3)^2 )
%% Lab assignment 1 trajectories


%% Point in Puma end effector Coordinate From
clc 
clear
mdl_puma560
q = [0, 30, -80, 0, 45,0] * pi/180;
tr = fkine(p560, q)
btr = transl(0.4,-0.2,0.7) * trotx(pi/2);
tr2Ball = inv(tr) * btr;

%% Puma Ikine
clc 
clf
clear
mdl_puma560
tr = eye(4);
q = p560.ikine(tr); 

%% Puma Distance to Wall Along Z
clc 
clf
clear
mdl_puma560

%% Puma Ray
clc
clear
mdl_puma560
q = [pi/10,0,-pi/2,0,0,0];
wall = 1.2;
transform = p560.fkine(q)
EEtransform = transform * transl(0,0,1);
ans = LinePlaneIntersection([-1,0,0],[wall,0,1],transform(1:3,4)',EEtransform(1:3,4)')

%% Safety

%% Sawyer