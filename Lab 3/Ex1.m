%% 
L1 = Link('d',0.1,'a', 0,'alpha', 0,'offset',0, 'qlim', [rad2deg(-170), rad2deg(170)])

L2 = Link('d', 0,'a', 1,'alpha', 0,'offset',0)

L3 = Link('d', 0,'a', 1,'alpha', -pi/2,'offset',0)

% L3 = Link('d',0.15,'a',0.0203,'alpha',-pi/2,'offset',0) 
% L4 = Link('d',0.4318,'a',0,'alpha',pi/2,'offset',0)
% L5 = Link('d',0,'a',0,'alpha',-pi/2,'offset',0)
% L6 = Link('d',0,'a',0,'alpha',0,'offset',0)
% workspace = [-x +x –y +y –z +z];
robot = SerialLink([L1], 'name', 'MYROBOT')
q = zeros(1,1)

robot.plot(q)
robot.teach()

%% 
L1 = Link('d',0.1273,'a', 0,'alpha', pi/2,'offset',0, 'qlim', [rad2deg(-170), rad2deg(170)])

L2 = Link('d', 0,'a', 0.612,'alpha', 0,'offset',0)

L3 = Link('d', 0,'a', 0.5723,'alpha', 0,'offset',0)

L4 = Link('d', 0.163,'a', 0,'alpha', pi/2,'offset', 0)

L5 = Link('d', 0,'a', 0,'alpha', 0,'offset',0)

L6 = Link('d', 0,'a', 0,'alpha', 0,'offset',0)

% L3 = Link('d',0.15,'a',0.0203,'alpha',-pi/2,'offset',0) 
% L4 = Link('d',0.4318,'a',0,'alpha',pi/2,'offset',0)
% L5 = Link('d',0,'a',0,'alpha',-pi/2,'offset',0)
% L6 = Link('d',0,'a',0,'alpha',0,'offset',0)
% workspace = [-x +x –y +y –z +z];
robot = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'MYROBOT')
q = zeros(1,6)

robot.plot(q)
robot.teach()

%% 
L1 = Link('d',0.09625,'a', 0,'alpha', pi/2,'offset', 0, 'qlim', [rad2deg(-170), rad2deg(170)])
L2 = Link('d', 0,'a', 0.33976,'alpha', 0,'offset',deg2rad(120))
L3 = Link('d', 0,'a', 0,'alpha', -pi/2,'offset',deg2rad(0))
L4 = Link('d', 0.236,'a', 0,'alpha', pi/2,'offset', 0)
L5 = Link('d', 0,'a', 0,'alpha', -pi/2,'offset',0)
L6 = Link('d', 0.134,'a', 0,'alpha', 0,'offset', 0)

% L3 = Link('d',0.15,'a',0.0203,'alpha',-pi/2,'offset',0) 
% L4 = Link('d',0.4318,'a',0,'alpha',pi/2,'offset',0)
% L5 = Link('d',0,'a',0,'alpha',-pi/2,'offset',0)
% L6 = Link('d',0,'a',0,'alpha',0,'offset',0)
% workspace = [-x +x –y +y –z +z];
robot = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'MYROBOT')
q = zeros(1,6)

robot.plot(q)
robot.teach()


