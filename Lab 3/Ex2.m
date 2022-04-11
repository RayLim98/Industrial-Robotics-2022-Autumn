%% 
LINKS = linkConfig();
robot = SerialLink(LINKS, 'name', 'VM-6083D-W');

% robot.plotopt = {'nojoints', 'noname', 'noshadow', 'nowrist'}; 
q = zeros(1, length(LINKS));   
T = robot.fkine(q);
% J = robot.jacob0(q);
% J = J(1:3,1:3);
% Jinv = inv(J);

robot.plot(q);
robot.teach();
% robot.vellipse(q)
