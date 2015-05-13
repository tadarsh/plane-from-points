function [img] = fill_new_points(plane)
%FILL_NEW_POINTS Summary of this function goes here
%   Detailed explanation goes here

    % Converting to 2D
    plane_2d = convert_2D(plane);
    points_2d = plane_2d.points_2d(:, 1:2);
    colors = plane_2d.points(:, 7:9);

    % Finding the convex hull and the extreme points
    K = convhull(points_2d(:,1), points_2d(:,2));
    conv_hull_points = points_2d(K, :);
    min_x = min(conv_hull_points(:, 1));
    max_x = max(conv_hull_points(:, 1));
    min_y = min(conv_hull_points(:, 2));
    max_y = max(conv_hull_points(:, 2));
    
    % Centering the points
    N = size(points_2d, 1);
    centered_points_2d = points_2d - [min_x*ones(N, 1), min_y*ones(N, 1)];
    centered_points_2d = centered_points_2d ./ [(max_x - min_x)*ones(N, 1), ...
                                        (max_y - min_y)*ones(N, 1)];
    
    % Creating an image
    G = 1000;
    img = zeros(G, G, 3);
    points_image = centered_points_2d * G; 
    for i=1:points_image
        pt = points_image(i, :);
        img(floor(pt(1)), floor(pt(2)), :) = colors(i, :);
    end
 
end

