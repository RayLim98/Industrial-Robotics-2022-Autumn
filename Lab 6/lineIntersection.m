%% Generate fkine for each link
clc
clf
clear
% 
% L(1) = Link('d',0,'a',1,'alpha',0,'offset',0);
% L(2) = Link('d',0,'a',1,'alpha',0,'offset',0);
% L(3) = Link('d',0,'a',1,'alpha',0,'offset',0);
mdl_3link3d
scale = 0.5;
workspace = [-3 3 -3 3 -0.05 3];

q = [-pi/6 0 0]; 

R3.plot(q,'workspace',workspace,'scale',scale);       
tr(:,:,:,1) = R3.base;
for i = 1: R3.n
    link = R3.links(i);
    tr(:,:,:, i+1) = tr(:,:,:,i) * trotz(q(i)+link.offset) * transl(0,0,link.d) * transl(link.a,0,0) * trotx(link.alpha);
end

%% Wall
[y, z] = meshgrid(-3:0.2:3, 0:0.1:1);
x = zeros(size(y)) + 3;
hold on
T = delaunay(y,z);
s = trisurf(T,x,y,z);
vertex = s.Vertices;
faces = s.Faces;
% need to create face normals
faceNormals = zeros(size(faces,1),3);
for faceIndex = 1:size(faces,1)
    v1 = vertex(faces(faceIndex,1)',:);
    v2 = vertex(faces(faceIndex,2)',:);
    v3 = vertex(faces(faceIndex,3)',:);
    faceNormals(faceIndex,:) = unit(cross(v2-v1,v3-v1));
end

%%
for faceIndex = 1: size(faces,1)
    vertOnPlane = vertex(faces(faceIndex,1)',:);
    [intersectP,check] = LinePlaneIntersection(faceNormals(faceIndex,:),vertOnPlane,tr(1:3,4,i)',tr(1:3,4,i+1)'); 
    if check == 1 && IsIntersectionPointInsideTriangle(intersectP,vertex(faces(faceIndex,:)',:))
        plot3(intersectP(1),intersectP(2),intersectP(3),'g*');
        display('Intersection');
    end
end

R3.teach()
