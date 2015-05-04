% Script to detect planes from a 3D point cloud

close all;
% Reading points
points = csvread('../data/hall.csv');
plot3(points(:, 1), points(:, 2), points(:, 3), 'b.');

% Run RANSAC to find inliers
[p, inliers] = ransac(points', @plane_3d, @plane_dist_3d, @isdegenerate, 3, 0.01);
points_in_plane = points(inliers, :);
hold on;
plot3(points_in_plane(:, 1), points_in_plane(:, 2), points_in_plane(:, 3), 'r.')

fprintf('Plane detection done..\n');
disp(size(inliers, 2))

i = 1
while size(inliers, 2) >= 1000
    %Running once more to get a second plane
    inlier_index = 1;
    global_index = 1;
    outlier_index = 1;
    outliers = ones(1, size(points, 1) - size(inliers, 2));

    while global_index ~= size(points, 1) 
        if inlier_index <= size(inliers, 2) 
            if inliers(inlier_index) == global_index
                inlier_index = inlier_index + 1;
                global_index = global_index + 1;
            else
                outliers(outlier_index) = global_index;
                outlier_index = outlier_index + 1;
                global_index = global_index + 1;
            end
        else 
            outliers(outlier_index) = global_index;
            outlier_index = outlier_index + 1;
            global_index = global_index + 1;
        end
    end

    points = points(outliers, :);
    % Run RANSAC to find inliers
    [p, inliers] = ransac(points', @plane_3d, @plane_dist_3d, @isdegenerate, 3, 0.01);
    points_in_plane = points(inliers, :);
    plot3(points_in_plane(:, 1), points_in_plane(:, 2), points_in_plane(:, 3), 'g.')

    fprintf('Plane detection done.., %d\n', i);
    disp(size(inliers, 2));
    i = i + 1;
end


