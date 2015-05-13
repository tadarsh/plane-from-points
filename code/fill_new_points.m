function [points_3d, colors, normals] = fill_new_points(plane)
%FILL_NEW_POINTS Summary of this function goes here
%   Detailed explanation goes here

    % Converting to 2D
    plane_2d = convert_2D(plane);
    points_2d = plane_2d.points_2d(:, 1:2);
    colors = plane_2d.points(:, 7:9);
    normal = plane.plane;

    % Finding the convex hull and the extreme points
    K = convhull(points_2d(:,1), points_2d(:,2));
    conv_hull_points = points_2d(K, :);
    min_x = min(conv_hull_points(:, 1));
    max_x = max(conv_hull_points(:, 1));
    min_y = min(conv_hull_points(:, 2));
    max_y = max(conv_hull_points(:, 2));
    
    %disp([max_x max_y min_x min_y])
    % Centering the points
    N = size(points_2d, 1);
    centered_points_2d = points_2d - [min_x*ones(N, 1), min_y*ones(N, 1)];
    centered_points_2d = centered_points_2d ./ [(max_x - min_x)*ones(N, 1), ...
                                        (max_y - min_y)*ones(N, 1)];
    
    % Creating an image
    G = 100;

    img = zeros(G + 1, G + 1, 3);
    points_image = centered_points_2d * G; 
    points1 = floor(points_image);
    points2 = ceil(points_image);
    points3 = [floor(points_image(:, 1)), ceil(points_image(:, 2))];
    points4 = [ceil(points_image(:, 1)), floor(points_image(:, 2))];

    for i=1:size(points_image, 1)
        img(points1(i, 1) + 1, points1(i, 2) + 1, :) = colors(i, :);
        %img(points2(i, 1) + 1, points2(i, 2) + 1, :) = colors(i, :);
        %img(points3(i, 1) + 1, points3(i, 2) + 1, :) = colors(i, :);
        %img(points4(i, 1) + 1, points4(i, 2) + 1, :) = colors(i, :);
    end
    img = uint8(img); 

    % Filling small gaps
    se = strel('ball', 3, 3);
    img2 = imdilate(img, se);
    img2 = imerode(img2, se);
    img = img;

    % Getting points
    points = zeros(10000, 2);
    colors = zeros(10000, 3);
    point_count = 0;
    for i=1:101
        for j=1:101
            if ((img2(i, j, 1) ~= 0) && (img2(i, j, 2) ~= 0) && (img2(i, j, 3) ~= 0))
                point_count = point_count + 1;
                points(point_count, 1) = i;
                points(point_count, 2) = j;
                colors(point_count, :) = img2(i, j, :); 
            end
        end
    end
    points = points(1:point_count, :);
    colors = colors(1:point_count, :);
    
    %Changing it to lie between 0 and 100
    points = (points - 1)/100;
    N = size(points, 1);
    points = points .* [(max_x - min_x)*ones(N, 1), ...
                                        (max_y - min_y)*ones(N, 1)];
    
    points = points  + [min_x*ones(N, 1), min_y*ones(N, 1)];

    % Converting them to 3D points
    points_homo = [points, zeros(N, 1), ones(N, 1)];
    points_3d = plane_2d.T * points_homo';
    points_3d = points_3d';
    normals = ones(N, 1) * normal';
end

