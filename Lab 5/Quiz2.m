%% Baxter
clc
clear
mdl_baxter
qleft = [5*pi/3,0,0,0,8*pi/2,0,0];

% Base of right ----> to endEffector of left
endEffectorPose = left.fkine(qleft);
basePose = right.base();

endEffectorLoc = endEffectorPose(1:3, 4);
baseLoc = basePose(1:3, 4);

diff = endEffectorLoc - baseLoc;

distance = sqrt(diff(1)^2 + diff(2)^2 + diff(3)^2)

%% Baxter 2 LEFT AND RIGHT DISTANCE 
clc
clear
mdl_baxter
left_q = [0,pi/10,0,0,0,-pi/10,0]
right_q = [0,-pi/10,0,0,0,pi/10,0]
leftPoseEnd = left.fkine(left_q)
rightPoseEnd = right.fkine(right_q)

l_xyz = leftPoseEnd(1:3,4);
r_xyz = rightPoseEnd(1:3,4);

diff = l_xyz - r_xyz;

distance = sqrt(diff(1)^2 + diff(2)^2 + diff(3)^2);

%% Baxter 3 INIT
clc
clear
mdl_baxter

mask = [1,1,1,0,0,0];
% qr = qr * 1.1;
qr
tr = left.fkine(qr)
left.plot(qr)
%%
% endEffectPose = left.fkine(qr)
qIk = left.ikine(tr, qr, mask)
trIk = left.fkine(qIk)
left.plot(qIk)


%% Puma560
clc
clear
mdl_puma560
mdl_ball

% p560.base = transl(0, 0, 0.5)
% q = [pi/10,0,0,0,0,2*pi/5]
% p560.fkine(q)
% p560.plot(q)
q =  [45, 0, 0, 45, 0, 45] * pi/180;
p560.base = transl(0,0,0.8)
ball = transl(0.5,0,0.6) * trotx(pi/2) 

tr = p560.fkine(q)
% endEF = tr(1:3, 4)
% ball_p = ball(1:3,4)
trDiff = ball * inv(tr) 
% deff = ball_p - endEF

p560.plot(q)

%%
clc
clear
mdl_puma560

q = pi/8*ones(1,6)
q(1,2) = +pi/4 
p560.jacob0(q)



%% Hyper Rendundant 
clc
clear
mdl_hyper2d

% q = [-pi, pi/2, -pi/2, pi/2, -pi/2, pi/2, -pi/2, -pi/3, pi/3, -pi/3]
% q = [pi, pi/2, -pi/2, pi/2, -pi/2, pi/2, -pi/2, pi/2, pi/3, -pi/3]
% q = [pi, pi/2, -pi/2, pi, -pi/2, pi/2, -pi/2, pi/2, -pi/3, -pi/3]
q = [-pi/2, pi/2, -pi/2, pi/2, -pi/2, pi/2, -pi/2, pi/2, pi/3, -pi/3]


h2d.plot(q)
%%
clc
clear
mdl_puma560
fkine(p560,ikine(p560,fkine(p560,[pi/4,0,0,0,0,0]))) == fkine(p560,[pi/4,0,0,0,0,0])
fkine(p560,ikine(p560,fkine(p560,[pi/4,0,0,0,0,0]),[pi/4,0,0,0,0,0])) == fkine(p560,[pi/4,0,0,0,0,0])
%%
clc
clear
mdl_puma560
q = pi/18*ones(1,6);
J = p560.jacob0(q)
q(1) = q(1) + pi/4;
J2 = p560.jacob0(q)

%% From floor
clc
clear
mdl_puma560
p560.base = transl(0,0,0.4);
q = [0,0,pi/10,0,0,0]
% q = [9*pi/10,0,3*pi/8,0,0,2*pi/7]
tr = p560.fkine(q)
p560.plot(q)