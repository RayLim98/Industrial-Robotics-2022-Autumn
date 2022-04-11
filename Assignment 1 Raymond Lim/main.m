status = profile('status')
profile on
%% Set up Environment
clc
clf
clear
% Load Robots
ur5 = LinearUR5c(false);
hold on
ur3 = UR3(0,-0.5,0);
ur3.model.plotopt = {'nojoints', 'noname', 'noshadow',};
%%
s_LoadBricks
s_Scene

%% Calc Ready Pose \ Animate Ready Pose \ Drop off Zone
step = 20;
stepRad = pi/180;

q03 = ur3.model.getpos();
qUr3R = [pi/2 -pi/2 pi/2 -pi/2 -pi/2 -pi/2];
trR3 = ur3.model.fkine(qUr3R);
trR3 = trR3(1:3, 1:3);
qUr3M = jtraj(q03, qUr3R, step);

q05 = ur5.model.getpos();
qR5 = [0 -pi/2 -pi/2 -pi/2 -pi/2 pi/2 0];
trR5 = ur5.model.fkine(qR5);
trR5 = trR5(1:3, 1:3);
qM5 = jtraj(q05, qR5, step);

for i = 1: step
    q3 = qUr3M(i,:);
    q5 = qM5(i,:); 
    ur3.model.animate(q3)
    ur5.model.animate(q5)
    drawnow();
    pause(0.05)
end

%% Reach to Brick
% for loop for every brick position. Brick Alignment
for brickIdx = 1: size(BricksUr3,2)
    brick = BricksUr3(brickIdx);
    brick2 = BricksUr5(brickIdx);
    trBrick3 = optimizeBrickPose(brick.pose(), trR3);
    trBrick5 = optimizeBrickPose(brick2.pose(), trR5);
    drpOf = DropOffZone(brickIdx);
    drpOf2 = DropOffZone2(brickIdx);
    
    q03 = ur3.model.getpos();
    q05 = ur5.model.getpos();  
    trBase5 = eye(4) * transl(q05(1),ur5.model.base(2,4),ur5.model.base(3,4));

    % Alignment
    deltaQ3 = calcAnglePose2Pose(ur3.model.base, brick.pose);
    deltaQ5 = calcAnglePose2Pose(trBase5, brick2.pose);
    qM3Align = genTrajectoryAlignment(q03, deltaQ3, 1, 15);
    qM5Align = genTrajectoryAlignment(q05, deltaQ5, 2, 15, trBrick5, ur5.model.qlim(1,:));
    for i = 1: size(qM3Align, 1)
        q3 = qM3Align(i,:);
        q5 = qM5Align(i,:);
        ur3.model.animate(q3)
        ur5.model.animate(q5)
        drawnow();
    end

    % Pick trajectory
    q03 = ur3.model.getpos();
    q05 = ur5.model.getpos();
    qEndUr3 = ur3.model.ikine(trBrick3, q03);
    qEndUr5 = checkPrisJoint(ur5.model.ikine(trBrick5, q05), ur5.model.qlim(1,:), trBrick5(1,4));
    qM3Pic = jtraj(q03,qEndUr3,step);
    qM5Pic = jtraj(q05,qEndUr5,step);
    for i = 1: size(qM3Pic, 1)
        q3 = qM3Pic(i,:);
        q5 =  qM5Pic(i,:);
        ur3.model.animate(q3)
        ur5.model.animate(q5)
        drawnow();
    end

    % Return to Starting Pose
    qM3 = vertcat(flip(qM3Pic),flip(qM3Align));
    qM5 = vertcat(flip(qM5Pic),flip(qM5Align));
    for i = 1: size(qM3, 1)
        q3 = qM3(i,:);
        q5 = qM5(i,:);
        tr3 = ur3.model.fkine(q3);
        tr5 = ur5.model.fkine(q5);
        brick.trObject(tr3);
        brick2.trObject(tr5)
        ur3.model.animate(q3)
        ur5.model.animate(q5)
        drawnow();
    end

    % Drop Off 
    q03 = ur3.model.getpos();
    q05 = ur5.model.getpos();
    trDrp3 = optimizeBrickPose(transl(drpOf.x, drpOf.y, drpOf.z),trR3);
    trDrp5 = optimizeBrickPose(transl(drpOf2.x, drpOf2.y, drpOf2.z),trR5);
    qf3 = ur3.model.ikine(trDrp3, q03);
    qf5 = checkPrisJoint(ur5.model.ikine(trDrp3, q05), ur5.model.qlim(1,:), trDrp3(1,4));
    qM3Drp = jtraj(q03, qf3, 10);
    qM5Drp = jtraj(q05, qf5, 10);
    for i = 1: size(qM3Drp, 1)
        q3 = qM3Drp(i,:);
        q5 = qM5Drp(i,:);
        tr3 = ur3.model.fkine(q3);
        tr5 = ur5.model.fkine(q5);
        brick.trObject(tr3);
        brick2.trObject(tr5);
        ur3.model.animate(q3);
        ur5.model.animate(q5);
        drawnow();
    end
    qM3DrpRet = flip(qM3Drp);
    qM5DrpRet = flip(qM5Drp);
    for i = 1: size(qM3DrpRet, 1)
        q3 = qM3DrpRet(i,:);
        q5 = qM5DrpRet(i,:);
        ur3.model.animate(q3);
        ur5.model.animate(q5);
        drawnow();
    end
end

%% Cal work Space

stepRads = deg2rad(50);
qlim = ur3.model.qlim;
pointCloudeSize = prod(floor((qlim(1:5,2)-qlim(1:5,1))/stepRads + 1));
pointCloud = zeros(pointCloudeSize,3);
counter = 1;
tic
for q1 = qlim(1,1):stepRads:qlim(1,2)
    for q2 = qlim(2,1):stepRads:qlim(2,2)
        for q3 = qlim(3,1):stepRads:qlim(3,2)
            for q4 = qlim(4,1):stepRads:qlim(4,2)
                for q5 = qlim(5,1):stepRads:qlim(5,2)
                    % Don't need to worry about joint 6, just assume it=0
                    q6 = 0;
%                     for q6 = qlim(6,1):stepRads:qlim(6,2)
                        q = [q1,q2,q3,q4,q5,q6];
                        tr = ur3.model.fkine(q);                        
                        pointCloud(counter,:) = tr(1:3,4)';
                        counter = counter + 1; 
                        if mod(counter/pointCloudeSize * 100,1) == 0
                            display(['After ',num2str(toc),' seconds, completed ',num2str(counter/pointCloudeSize * 100),'% of poses']);
                        end
%                     end
                end
            end
        end
    end
end

% 2.6 Create a 3D model showing where the end effector can be over all these samples.  
plot3(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3),'b.');

%%
highestValue = max(pointCloud(:,1));
lowestValue = min(pointCloud(:,1));
display(['Highest Value is: ',num2str(highestValue)]);
display(['Lowest Value is: ',num2str(lowestValue)]);

radius = abs(highestValue - lowestValue)/2;
volume = (4/3)*pi*radius^3;

display(['Radius: ',num2str(radius)]);
display(['Volumn: ',num2str(volume)]);


profile viewer