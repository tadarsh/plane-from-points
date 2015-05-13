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
for i = 1:no_planes    
    curr_plane = new_planes(keys{i});
    curr_plane = convert_2D(curr_plane);
    %curr_plane.points_2d = points_2d;
    %curr_plane.T = Transform;
%     figure;
%     plot(curr_plane.points_2d(:, 1), curr_plane.points_2d(:, 2), '.');
    
    points_2d = curr_plane.points_2d(:, 1:2);
    min_x = min(points_2d(:, 1));
    min_y = min(points_2d(:, 2));
    max_x = max(points_2d(:, 1));
    max_y = max(points_2d(:, 2));
    N = size(points_2d, 1);
    centered_points_2d = points_2d - [min_x*ones(N, 1), min_y*ones(N, 1)];
    centered_points_2d = centered_points_2d ./ [(max_x - min_x)*ones(N, 1), ...
                                        (max_y - min_y)*ones(N, 1)];
    G = 1000;
    image = zeros(G, G);
    centered_points_2d = G * centered_points_2d;
    for j = 1:size(centered_points_2d, 1)
        x = floor(centered_points_2d(j, 1));
        y = floor(centered_points_2d(j, 2));
        if y > 0
            image(x+1, y) = 1;
        end
        if x > 0
            image(x, y+1) = 1;
            if y > 0
                image(x, y) = 1;
            end
        end
        image(x+1, y+1) = 1;    

        if x < G+1
            if y < G+1
                image(x+2, y+2) = 1;        
            end
            image(x+2, y+1) = 1;    
        end
        if y < G+1    
            image(x+1, y+2) = 1;    
        end
    end
    se = strel('square',5);
    image = imdilate(image, se);
    %image = imfill(image);
    image = imdilate(image, se);
    %image = imfill(image);
    se = strel('square',3);
    image = imdilate(image, se);
    %image = imfill(image);
    
    
    new_nPts = sum(sum(image));
    new_2d_points = zeros(new_nPts, 2);
    counter = 1;
    for l = 1:G
        for j = 1:G
            if image(l, j) > 0
                new_2d_points(counter, :) = [l-1, j-1];
                counter = counter + 1;
            end
        end
    end
    new_2d_points = new_2d_points/G;
    new_2d_points = new_2d_points .* [(max_x - min_x)*ones(new_nPts, 1), ...
                                        (max_y - min_y)*ones(new_nPts, 1)];
    new_2d_points = new_2d_points + [min_x*ones(new_nPts, 1), min_y*ones(new_nPts, 1)];
    
    new_2d_points_homo = [new_2d_points, zeros(new_nPts, 1), ones(new_nPts, 1)];
    new_3d_points = curr_plane.T * new_2d_points_homo';
    new_3d_points = new_3d_points';
    curr_plane.filled_3d = new_3d_points;
    %close all;
    %figure;
    %plot3(curr_plane.points(:, 1), curr_plane.points(:, 2), curr_plane.points(:, 3), '.');
    %figure;
    plot3(curr_plane.filled_3d (:, 1), curr_plane.filled_3d (:, 2), curr_plane.filled_3d (:, 3), '.');
    %waitforbuttonpress;
    new_planes(keys{i}) = curr_plane;
end