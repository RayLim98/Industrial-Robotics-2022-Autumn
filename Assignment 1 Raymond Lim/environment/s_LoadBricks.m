brickPos1 = [
    Position(-0.32, -0.5, 0)... 
    Position(0.3, -0.5, 0)...
    Position(0, -1, 0)...
    Position(0.5, -0.5, 0)...
    ];
brickPos2 = [
    Position(0.5, 0.5, 0)... 
    Position(-1.5, 0.5, 0)...
    Position(-0.5, 1, 0)...
    Position(-1.5, 1, 0)...
    ];

BricksUr3(1) = PlyObject('Brick.ply', [brickPos1(1).x, brickPos1(1).y, brickPos1(1).z], pi/2);
% BricksUr3(1) = PlyObject('Brick.ply', [0,0,0], pi/2);
BricksUr3(2) = PlyObject('Brick.ply', [brickPos1(2).x, brickPos1(2).y, brickPos1(2).z], pi/2);
BricksUr3(3) = PlyObject('Brick.ply', [brickPos1(3).x, brickPos1(3).y, brickPos1(3).z], 0);
BricksUr3(4) = PlyObject('Brick.ply', [brickPos1(4).x, brickPos1(4).y, brickPos1(4).z], 0);
% BricksUr3(4) = PlyObject('Brick.ply', [0,0,0.8], 0);

BricksUr5(1) = PlyObject('Brick.ply', [brickPos2(1).x, brickPos2(1).y, brickPos2(1).z], 0);
BricksUr5(2) = PlyObject('Brick.ply', [brickPos2(2).x, brickPos2(2).y, brickPos2(2).z], 0);
BricksUr5(3) = PlyObject('Brick.ply', [brickPos2(3).x, brickPos2(3).y, brickPos2(3).z], 0);
BricksUr5(4) = PlyObject('Brick.ply', [brickPos2(4).x, brickPos2(4).y, brickPos2(4).z], 0);

% DropOffZone = [transl(0,0,0) transl(0.2,0,0) transl(-0.2,0,0)];
DropOffZone(1) = Position(0,0,0.07);
DropOffZone(2) = Position(-0.2,0,0.07);
DropOffZone(3) = Position(0.2,0,0.07);
DropOffZone(4) = Position(0.2,0,0.07);

DropOffZone2(1) = Position(0.2,0,0.07);
DropOffZone2(2) = Position(0,0,0.14);
DropOffZone2(3) = Position(-0.2,0,0.14);
DropOffZone2(4) = Position(-0.2,0,0.14);