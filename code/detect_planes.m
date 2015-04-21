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


points = points(~inliers);