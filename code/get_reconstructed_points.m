%assume points are Nx3, where N is number of points.
%let first point origin in 2D coordinate system (can be shifted later)
%Calculate out-of-plane vector (local z)
% N = size(Coor_3D,1);
% origin = Coor_3D(1,:);
% localz = cross(Coor_3D(2,:)-origin, Coor_3D(3,:)-origin);
% %normalize it
% unitz = localz/norm(localz,2);
% %calculate local x vector in plane
% localx = Coor_3D(2,:)-origin;   
% unitx = localx/norm(localx,2);
% %calculate local y
% localy = cross(localz, localx);  
% unity = localy/norm(localy,2); 
% %assume transformation matrix
% T = [localx(:), localy(:), localz(:), origin(:); 0 0 0 1];
% C = [Coor_3D, ones(N,1)];
% Coor_2D = T \ C';
% %Coor_2D = Coor_2D(1:3,:)';

no_planes = size(new_planes.keys, 2);
keys = new_planes.keys();
figure;
hold all;
points = [];
normals = [];
colors = [];

for i = 1:no_planes    
    curr_plane = new_planes(keys{i});
    [a, b, c] = fill_new_points(curr_plane);
    points = [points;a];
    colors = [colors;b];
    normals = [normals;c];
end
