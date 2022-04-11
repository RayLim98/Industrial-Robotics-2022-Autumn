axis equal;   % Make the axes scales match
hold on;      % Add to the plot
x = 2;
y = 2;
z = 2;
xlabel('x');
ylabel('y');
zlabel('z');

%% Background
img = imread('warehouse.jpg');     
xImage = [-x -x; -x -x];   % The x data for the image corners
yImage = [-y y; -y y];             % The y data for the image corners
zImage = [1 1; 0 0];   % The z data for the image corners
surf(xImage,yImage,zImage,...    % Plot the surface
     'CData',img,...
     'FaceColor','texturemap');

%% Floor
img = imread('floor.png');     
xImage = [2 2; -2 -2];   % The x data for the image corners
yImage = [-2 2; -2 2];            % The y data for the image corners
zImage = [0 0; 0 0];   % The z data for the image corners
surf(xImage,yImage,zImage,...    % Plot the surface
     'CData',img,...
     'FaceColor','texturemap');

%%
PlyObject('barrier.ply', [-1,-1.2,0],0)
PlyObject('barrier.ply', [0.6,-1.2,0],pi)
% PlyObject('barrier.ply', [-1,-1,0],pi/2)
PlyObject('conveyor.ply', [-0.4,0,0],0)
PlyObject('conveyor.ply', [0,0,0],   0)
PlyObject('conveyor.ply', [0.4,0,0],0)
PlyObject('conveyor.ply', [0.8,0,0],0)
PlyObject('conveyor.ply', [1.2,0,0],0)
PlyObject('conveyor.ply', [1.6,0,0],0)
PlyObject('3DScan_Man_036.ply', [0,-1.5,0],pi)
PlyObject('fence.ply', [0,-1.3,0],pi/2)
% PlyObject('cylinder.ply', [0,0,0], pi)
