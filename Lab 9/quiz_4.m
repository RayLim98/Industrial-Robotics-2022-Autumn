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
close all
clear
clf
clc

mdl_planar3
[v,f,fn] = RectangularPrism([2,-1,-1],[3,1,1]);
q1 = [pi/3,pi/2,0];
q2 = [-pi/3,-pi/2,0];
qM = jtraj(q1, q2, 50);
result = IsCollision(p3,qM,f,v,fn);
%% 
close all
clear
clf
clc

[X,Y] = meshgrid(-10:1:10,-10:1:10);
Z = X;
c = [1 2 3];
r = [1 2 3];

pCld = [X(:),Y(:),Z(:)];
plot3(pCld(:,1),pCld(:,2),pCld(:,3), 'b.')
hold on
surf(X,Y,Z)

[x,y,z] = ellipsoid(c(1),c(2),c(3),r(1),r(2),r(3));
surf(x,y,z)

counter = 0;
for i = 1: size(pCld, 1)
    point = pCld(i,:);
    pointPosition = (point(1) - c(1))^2/r(1)^2 ... 
                    + (point(2) - c(2))^2/r(2)^2 ... 
                    + (point(3) - c(3))^2/r(3)^2;
    if pointPosition < 1
        % Inside
        counter = counter + 1;
    end
end

%% Measures of Manipulating 
close all
clear
clf
clc

mdl_puma560
q = [0,2.3562,-3.0159,0,-0.9076,0];
jacobian = p560.jacob0(q);
measureOfManip = sqrt(det(jacobian*jacobian'))
p560.plot(q)

q = [0,1.5708,-3.0159,0.1466,0.5585,0];
jacobian = p560.jacob0(q);
measureOfManip = sqrt(det(jacobian*jacobian'))
p560.plot(q)

q = [1.1170,1.0996,-3.4872,0.1466,0.5585,0.6500];
jacobian = p560.jacob0(q);
measureOfManip = sqrt(det(jacobian*jacobian'))
p560.plot(q)

%% Measures of Manipulating For only 2 Rows
close all
clear
clf
clc

mdl_planar3
q = [0, 1.5708, -1.5708];
jacobian = p3.jacob0(q);
jacobian = jacobian(1:2,:);
measureOfManip = sqrt(det(jacobian*jacobian'))
p3.plot(q)

q = [0.65, 0.11, -0.1];
jacobian = p3.jacob0(q);
jacobian = jacobian(1:2,:);
measureOfManip = sqrt(det(jacobian*jacobian'))
p3.plot(q)

q = [0.7854, -0.7854, 0.7854];
jacobian = p3.jacob0(q);
jacobian = jacobian(1:2,:);
measureOfManip = sqrt(det(jacobian*jacobian'))
p3.plot(q)

q = [0, -0.7854, -0.7854]; %wrong  
jacobian = p3.jacob0(q);
jacobian = jacobian(1:2,:);
measureOfManip = sqrt(det(jacobian*jacobian'))
p3.plot(q)

%%

