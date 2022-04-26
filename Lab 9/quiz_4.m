%% 
P = [2,2,2,2; -0.3,0.3,0.3,-0.3; 1.3,1.3,0.7,0.7];
pStar = [600 300 300 600; 300 300 600 600];

cam = CentralCamera('focal',0.08,'pixel',10e-5,'resolution',[1024 1024], 'centre',[512 512],'name','UR10camera');
r = UR10();

q0 = [1.6; -1; -1.2; -0.5;0;0];
Tc0 = r.model.fkine(q0);
cam.T = Tc0;
uv = cam.plot(P);
e = pStar-uv

%% 
clc
mdl_planar3
[v,f,fn] = RectangularPrism([2,-1,-1],[3,1,1])
trajcount = jtraj(50)
q1 = [pi/3,0,0]
q2 = [-pi/3,0,0]
result = Iscollision(p3,q1,f,v,fn);
%% 
[X,Y] = meshgrid(-10:1:10,-10:1:10);
Z = X;
[x,y,z] = ellipsoid(3,2,1,1,2,3);
surf(X,Y,Z)
hold on
surf(x,y,z)
%% clc 
mdl_puma560
% q = [0,2.1677,-2.7332,0,-0.9425,0]; %c
% q = [0,0.7854,3.1416,0,0.7854,0];
% q = [0,1.5708,-3.1416,0,0,0];
 q = [0,0.7,3,0,0.7,0]; %wrong 
jacobian = p560.jacob0(q);
measureOfManip = sqrt(det(jacobian(1:2,:)*jacobian(1:2,:)'))

