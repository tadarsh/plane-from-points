function plane_struct = convert_2D(plane_struct)
    localz = plane_struct.plane(1:3);
    N = size(plane_struct.points, 1);
    points_3d = [plane_struct.points(:, 1:3), ...
        ones(N, 1)];
    origin = points_3d(1,1:3);
    localx = points_3d(2,1:3)-origin;   
    %unitx = localx/norm(localx,2);
    localy = cross(localz, localx);  
    %unity = localy/norm(localy,2); 
    %assume transformation matrix
    T = [localx(:), localy(:), localz(:), origin(:); 0 0 0 1];
    C = [points_3d(:, 1:3), ones(N,1)];
    Coor_2D = T \ C';
    points_2d = Coor_2D';  
    plane_struct.T = T;
    plane_struct.points_2d = points_2d;
end