L1 = Link('d',0,'a',1,'alpha',0,'offset',0,'qlim', [-pi*30/180,pi*30/180]);
L2 = Link('d',0,'a',2,'alpha',0,'offset',0,'qlim', [-pi,pi]);
L3 = Link('d',0,'a',3,'alpha',0,'offset',0,'qlim', [-pi,pi]);
% ... % More link definition in between (if required)
% Ln = Link('d',___,'a',___,'alpha',___,'offset',___,'qlim', [__,__]);

robot = SerialLink([L1, L2, L3],'name','myRobot');
% This creates a vector of n joint angles at 0.
q = zeros(1,3);
% workspace = [-x +x –y +y –z +z];
workspace = [-4 4 -4 4 -4 4];                                  

scale = 1;
robot.plot(q,'workspace',workspace,'scale',scale); 

robot.teach();

p = robot.getpos();

qlim = robot.qlim;